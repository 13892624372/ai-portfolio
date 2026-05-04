<template>
  <div 
    class="dream-intro-overlay" 
    :class="{ 'active': isActive }"
    ref="overlayRef"
  >
    <!-- Three.js 容器 -->
    <div ref="threeContainerRef" class="three-container"></div>
    
    <!-- 提示文字 -->
    <div class="hint-text" v-if="!isActive && !isZooming">
      Give it a try
    </div>
    
    <!-- 白色幕布 -->
    <div class="white-curtain" :class="{ 'show': showWhiteCurtain, 'fade': isPlayingVideo }"></div>
    
    <!-- 视频播放器 -->
    <div class="video-container" v-if="isPlayingVideo">
      <video 
        ref="videoRef"
        class="dream-video"
        src="/photo/1.0版本.mp4"
        autoplay
        playsinline
        @ended="onVideoEnded"
      ></video>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import gsap from 'gsap'
import * as THREE from 'three'

const emit = defineEmits(['animationComplete', 'close'])

// Refs
const overlayRef = ref(null)
const threeContainerRef = ref(null)

// State
const isActive = ref(false)
const isDragging = ref(false)
const isZooming = ref(false)
const showWhiteCurtain = ref(false)
const isPlayingVideo = ref(false) // 是否正在播放视频

// Refs
const videoRef = ref(null)

// 保存动画初始状态用于倒放
const initialState = {
  cameraPosition: null,
  earthRotation: null,
  clickPoint: null
}

// Three.js 相关
let scene, camera, renderer, earth, starField
let animationId = null
let raycaster, mouse

// 拖拽相关
let isDraggingEarth = false
let previousMousePosition = { x: 0, y: 0 }
let targetRotation = { x: 0, y: 0 }
let currentRotation = { x: 0, y: 0 }
let dragStartPosition = { x: 0, y: 0 }
let hasMoved = false
const DRAG_THRESHOLD = 5 // 移动超过5像素认为是拖拽

// 自动旋转速度
const AUTO_ROTATION_SPEED = 0.0005

// 初始化 Three.js 场景
const initThreeJS = async () => {
  if (!threeContainerRef.value) return
  
  const container = threeContainerRef.value
  const width = container.clientWidth
  const height = container.clientHeight
  
  // 场景
  scene = new THREE.Scene()
  // 不设置背景色，让星空背景显示
  
  // 相机（far设置为2000确保能看到远处的星空）
  camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 2000)
  camera.position.z = 3.5
  
  // 渲染器
  renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true })
  renderer.setSize(width, height)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
  container.appendChild(renderer.domElement)
  
  // 射线检测
  raycaster = new THREE.Raycaster()
  mouse = new THREE.Vector2()
  
  // 创建地球
  await createEarth()
  
  // 创建星空
  createStarField()
  
  // 开始渲染循环
  animate()
  
  // 添加事件监听
  const canvas = renderer.domElement
  canvas.addEventListener('mousedown', onMouseDown)
  canvas.addEventListener('mousemove', onMouseMove)
  canvas.addEventListener('mouseup', onMouseUp)
  canvas.addEventListener('mouseleave', onMouseLeave)
  
  // 触摸事件支持
  canvas.addEventListener('touchstart', onTouchStart, { passive: false })
  canvas.addEventListener('touchmove', onTouchMove, { passive: false })
  canvas.addEventListener('touchend', onTouchEnd)
}

// 加载地球纹理
const loadEarthTexture = () => {
  const textureLoader = new THREE.TextureLoader()
  return new Promise((resolve, reject) => {
    const url = '/photo/earth.jpg'
    console.log('加载地球纹理:', url)
    textureLoader.load(
      url,
      (texture) => {
        console.log('地球纹理加载成功')
        texture.colorSpace = THREE.SRGBColorSpace
        resolve(texture)
      },
      (progress) => {
        console.log('地球纹理加载进度:', progress)
      },
      (error) => {
        console.error('地球纹理加载失败:', error)
        reject(error)
      }
    )
  })
}

// 创建地球
const createEarth = async () => {
  const geometry = new THREE.SphereGeometry(1, 128, 128)
  
  try {
    const texture = await loadEarthTexture()
    
    const material = new THREE.MeshPhongMaterial({
      map: texture,
      specular: new THREE.Color(0x222222),
      shininess: 10
    })
    
    earth = new THREE.Mesh(geometry, material)
    scene.add(earth)
  } catch (error) {
    console.error('创建地球失败:', error)
  }
  
  // 添加光源
  const ambientLight = new THREE.AmbientLight(0x333333, 0.6)
  scene.add(ambientLight)
  
  const directionalLight = new THREE.DirectionalLight(0xffffff, 1.2)
  directionalLight.position.set(5, 3, 5)
  scene.add(directionalLight)
  
  const rimLight = new THREE.DirectionalLight(0x4488ff, 0.8)
  rimLight.position.set(-5, 0, -5)
  scene.add(rimLight)
}

// 创建逼真的星空背景
const createStarField = () => {
  // 创建星空纹理（程序化生成）
  const canvas = document.createElement('canvas')
  canvas.width = 4096
  canvas.height = 2048
  const ctx = canvas.getContext('2d')
  
  // 深空背景
  const gradient = ctx.createRadialGradient(2048, 1024, 0, 2048, 1024, 2048)
  gradient.addColorStop(0, '#0a0a1a')
  gradient.addColorStop(0.4, '#050510')
  gradient.addColorStop(0.8, '#020205')
  gradient.addColorStop(1, '#000000')
  ctx.fillStyle = gradient
  ctx.fillRect(0, 0, 4096, 2048)
  
  // 添加星云效果
  for (let i = 0; i < 30; i++) {
    const x = Math.random() * 4096
    const y = Math.random() * 2048
    const radius = 200 + Math.random() * 400
    const nebulaGradient = ctx.createRadialGradient(x, y, 0, x, y, radius)
    const hue = Math.random() > 0.5 ? 220 + Math.random() * 40 : 280 + Math.random() * 40
    nebulaGradient.addColorStop(0, `hsla(${hue}, 60%, 30%, 0.15)`)
    nebulaGradient.addColorStop(0.5, `hsla(${hue}, 50%, 20%, 0.05)`)
    nebulaGradient.addColorStop(1, 'transparent')
    ctx.fillStyle = nebulaGradient
    ctx.fillRect(0, 0, 4096, 2048)
  }
  
  // 添加银河带
  ctx.save()
  ctx.translate(2048, 1024)
  ctx.rotate(Math.random() * Math.PI)
  for (let i = 0; i < 100; i++) {
    const x = (Math.random() - 0.5) * 4096
    const y = (Math.random() - 0.5) * 300
    const width = 100 + Math.random() * 200
    const height = 20 + Math.random() * 40
    const milkyWayGradient = ctx.createRadialGradient(x, y, 0, x, y, width)
    milkyWayGradient.addColorStop(0, 'rgba(255, 255, 255, 0.3)')
    milkyWayGradient.addColorStop(0.5, 'rgba(200, 200, 255, 0.1)')
    milkyWayGradient.addColorStop(1, 'transparent')
    ctx.fillStyle = milkyWayGradient
    ctx.beginPath()
    ctx.ellipse(x, y, width, height, 0, 0, Math.PI * 2)
    ctx.fill()
  }
  ctx.restore()
  
  // 添加星星
  for (let i = 0; i < 15000; i++) {
    const x = Math.random() * 4096
    const y = Math.random() * 2048
    const size = Math.random() < 0.9 ? Math.random() * 1.5 : Math.random() * 3
    const brightness = 0.3 + Math.random() * 0.7
    const hue = Math.random() > 0.8 ? 200 + Math.random() * 60 : 0
    const saturation = hue > 0 ? 30 : 0
    
    ctx.fillStyle = `hsla(${hue}, ${saturation}%, ${brightness * 100}%, ${brightness})`
    ctx.beginPath()
    ctx.arc(x, y, size, 0, Math.PI * 2)
    ctx.fill()
    
    // 亮星添加光晕
    if (size > 2) {
      const glowGradient = ctx.createRadialGradient(x, y, 0, x, y, size * 4)
      glowGradient.addColorStop(0, `hsla(${hue}, ${saturation}%, 80%, 0.3)`)
      glowGradient.addColorStop(1, 'transparent')
      ctx.fillStyle = glowGradient
      ctx.beginPath()
      ctx.arc(x, y, size * 4, 0, Math.PI * 2)
      ctx.fill()
    }
  }
  
  // 创建纹理
  const texture = new THREE.CanvasTexture(canvas)
  texture.colorSpace = THREE.SRGBColorSpace
  
  // 创建球体作为星空背景
  const geometry = new THREE.SphereGeometry(500, 64, 64)
  
  const material = new THREE.MeshBasicMaterial({
    map: texture,
    side: THREE.BackSide
  })
  
  starField = new THREE.Mesh(geometry, material)
  scene.add(starField)
  
  console.log('星空背景创建成功')
}

// 渲染循环
const animate = () => {
  animationId = requestAnimationFrame(animate)
  
  if (earth) {
    if (isDraggingEarth) {
      // 拖拽时应用目标旋转，停止自动旋转
      earth.rotation.y = targetRotation.y
      earth.rotation.x = targetRotation.x
      
      // 星空跟随地球同步旋转
      if (starField) {
        starField.rotation.y = targetRotation.y * 0.1
        starField.rotation.x = targetRotation.x * 0.1
      }
    } else {
      // 非拖拽时自动旋转
      earth.rotation.y += AUTO_ROTATION_SPEED
      earth.rotation.x = currentRotation.x
      
      // 同步 targetRotation 和 currentRotation
      targetRotation.y = earth.rotation.y
      targetRotation.x = earth.rotation.x
      currentRotation.y = earth.rotation.y
      currentRotation.x = earth.rotation.x
      
      // 星空缓慢跟随旋转
      if (starField) {
        starField.rotation.y = earth.rotation.y * 0.1
        starField.rotation.x = earth.rotation.x * 0.1
      }
    }
  }
  
  renderer.render(scene, camera)
}

// 调整尺寸
const resizeHandler = () => {
  if (!threeContainerRef.value || !camera || !renderer) return
  
  const width = threeContainerRef.value.clientWidth
  const height = threeContainerRef.value.clientHeight
  
  camera.aspect = width / height
  camera.updateProjectionMatrix()
  renderer.setSize(width, height)
}

// 鼠标按下
const onMouseDown = (event) => {
  if (!earth) return
  
  // 获取坐标（兼容鼠标和触摸）
  const clientX = event.clientX || (event.touches && event.touches[0].clientX)
  const clientY = event.clientY || (event.touches && event.touches[0].clientY)
  
  if (!clientX || !clientY) return
  
  const rect = renderer.domElement.getBoundingClientRect()
  mouse.x = ((clientX - rect.left) / rect.width) * 2 - 1
  mouse.y = -((clientY - rect.top) / rect.height) * 2 + 1
  
  raycaster.setFromCamera(mouse, camera)
  const intersects = raycaster.intersectObject(earth)
  
  if (intersects.length > 0) {
    isDraggingEarth = true
    hasMoved = false
    dragStartPosition = { x: clientX, y: clientY }
    previousMousePosition = { x: clientX, y: clientY }
    
    // 同步目标旋转到当前地球旋转
    targetRotation.x = earth.rotation.x
    targetRotation.y = earth.rotation.y
    currentRotation.x = earth.rotation.x
    currentRotation.y = earth.rotation.y
  }
}

// 鼠标移动
const onMouseMove = (event) => {
  if (!isDraggingEarth || !earth) return
  
  // 获取坐标（兼容鼠标和触摸）
  const clientX = event.clientX || (event.touches && event.touches[0].clientX)
  const clientY = event.clientY || (event.touches && event.touches[0].clientY)
  
  if (!clientX || !clientY) return
  
  const deltaX = clientX - previousMousePosition.x
  const deltaY = clientY - previousMousePosition.y
  
  // 检查是否移动超过阈值
  const totalDeltaX = Math.abs(clientX - dragStartPosition.x)
  const totalDeltaY = Math.abs(clientY - dragStartPosition.y)
  
  if (totalDeltaX > DRAG_THRESHOLD || totalDeltaY > DRAG_THRESHOLD) {
    hasMoved = true
    isDragging.value = true
  }
  
  // 更新目标旋转角度（降低灵敏度）
  targetRotation.y += deltaX * 0.002
  targetRotation.x += deltaY * 0.002
  
  previousMousePosition = { x: clientX, y: clientY }
}

// 鼠标释放
const onMouseUp = (event) => {
  // 如果没有移动，认为是点击
  if (isDraggingEarth && !hasMoved) {
    // 触发点击事件
    onCanvasClick(event)
  }
  
  // 同步 currentRotation 到 targetRotation，避免切换到非拖拽模式时跳动
  currentRotation.x = targetRotation.x
  currentRotation.y = targetRotation.y
  
  isDraggingEarth = false
  isDragging.value = false
  hasMoved = false
}

// 鼠标离开（不触发点击）
const onMouseLeave = () => {
  // 同步 currentRotation 到 targetRotation，避免切换到非拖拽模式时跳动
  currentRotation.x = targetRotation.x
  currentRotation.y = targetRotation.y
  
  isDraggingEarth = false
  isDragging.value = false
  hasMoved = false
}

// 触摸结束
const onTouchEnd = (event) => {
  // 如果没有移动，认为是点击
  if (isDraggingEarth && !hasMoved) {
    onCanvasClick(event)
  }
  
  // 同步 currentRotation 到 targetRotation，避免切换到非拖拽模式时跳动
  currentRotation.x = targetRotation.x
  currentRotation.y = targetRotation.y
  
  isDraggingEarth = false
  isDragging.value = false
  hasMoved = false
}

// 触摸开始
const onTouchStart = (event) => {
  if (event.touches.length === 1) {
    const touch = event.touches[0]
    onMouseDown({ clientX: touch.clientX, clientY: touch.clientY })
  }
}

// 触摸移动
const onTouchMove = (event) => {
  if (event.touches.length === 1) {
    event.preventDefault()
    const touch = event.touches[0]
    onMouseMove({ clientX: touch.clientX, clientY: touch.clientY })
  }
}

// 点击事件
const onCanvasClick = (event) => {
  // 如果正在播放视频，点击倒放返回
  if (isPlayingVideo.value) {
    reverseAnimation()
    return
  }
  
  // 防止在缩放或激活状态下重复触发
  if (isZooming.value || isActive.value) return
  
  const rect = renderer.domElement.getBoundingClientRect()
  const clientX = event.clientX || (event.changedTouches && event.changedTouches[0].clientX)
  const clientY = event.clientY || (event.changedTouches && event.changedTouches[0].clientY)
  
  mouse.x = ((clientX - rect.left) / rect.width) * 2 - 1
  mouse.y = -((clientY - rect.top) / rect.height) * 2 + 1
  
  raycaster.setFromCamera(mouse, camera)
  const intersects = raycaster.intersectObject(earth)
  
  if (intersects.length > 0) {
    // 获取点击点，传递给动画函数
    const clickPoint = intersects[0].point
    startAnimation(clickPoint)
  }
}

// 开始动画（镜头向点击位置拉近 + 白色幕布渐显）
const startAnimation = (clickPoint) => {
  isZooming.value = true
  
  // 保存初始状态用于倒放
  initialState.cameraPosition = camera.position.clone()
  initialState.earthRotation = earth.rotation.clone()
  initialState.clickPoint = clickPoint.clone()
  
  // 计算相机目标位置：从点击点方向拉近
  // 点击点归一化后乘以目标距离（1.2）
  const targetDistance = 1.2
  const direction = clickPoint.clone().normalize()
  const targetPosition = direction.multiplyScalar(targetDistance)
  
  // 保存地球初始旋转
  const initialRotation = earth.rotation.clone()
  
  // 计算地球应该朝向的目标旋转（让点击点正对相机）
  const targetQuaternion = new THREE.Quaternion()
  const originalRotation = earth.rotation.clone()
  
  // 临时让地球看向相机，获取目标旋转
  earth.lookAt(camera.position)
  const endRotation = earth.rotation.clone()
  
  // 恢复初始旋转
  earth.rotation.copy(initialRotation)
  
  // 镜头向点击位置拉近动画，持续3秒
  gsap.to(camera.position, {
    x: targetPosition.x,
    y: targetPosition.y,
    z: targetPosition.z,
    duration: 3,
    ease: 'power2.inOut'
  })
  
  // 同时动画地球旋转
  gsap.to(earth.rotation, {
    x: endRotation.x,
    y: endRotation.y,
    z: endRotation.z,
    duration: 3,
    ease: 'power2.inOut'
  })
  
  // 1.8秒后开始白色幕布渐显
  setTimeout(() => {
    showWhiteCurtain.value = true
  }, 1800)
  
  // 动画完成事件 - 自动播放视频
  setTimeout(() => {
    isActive.value = true
    isPlayingVideo.value = true // 自动播放视频
    emit('animationComplete')
  }, 3000)
}

// 视频播放结束（不自动返回，保持视频结束画面或循环播放）
const onVideoEnded = () => {
  // 视频播放结束，不做任何操作，保持当前状态
  // 用户需要点击界面来倒放返回
}

// 倒放动画（恢复到初始状态）
const reverseAnimation = () => {
  if (!initialState.cameraPosition || !initialState.earthRotation) return
  
  // 停止视频播放
  isPlayingVideo.value = false
  if (videoRef.value) {
    videoRef.value.pause()
  }
  
  // 白色幕布渐隐
  showWhiteCurtain.value = false
  
  // 相机位置倒放
  gsap.to(camera.position, {
    x: initialState.cameraPosition.x,
    y: initialState.cameraPosition.y,
    z: initialState.cameraPosition.z,
    duration: 3,
    ease: 'power2.inOut'
  })
  
  // 地球旋转倒放
  gsap.to(earth.rotation, {
    x: initialState.earthRotation.x,
    y: initialState.earthRotation.y,
    z: initialState.earthRotation.z,
    duration: 3,
    ease: 'power2.inOut',
    onComplete: () => {
      // 倒放完成，重置状态
      isActive.value = false
      isZooming.value = false
      emit('close')
    }
  })
}

// 公开方法
const activate = () => {
  if (!isActive.value) startAnimation()
}

const reset = () => {
  isActive.value = false
  isZooming.value = false
  showWhiteCurtain.value = false
  isPlayingVideo.value = false
  initialState.cameraPosition = null
  initialState.earthRotation = null
  initialState.clickPoint = null
  if (camera) camera.position.z = 3.5
}

defineExpose({
  activate,
  reset,
  isActive: () => isActive.value
})

onMounted(() => {
  nextTick(() => {
    initThreeJS()
    window.addEventListener('resize', resizeHandler)
  })
})

onUnmounted(() => {
  window.removeEventListener('resize', resizeHandler)
  if (animationId) cancelAnimationFrame(animationId)
  if (renderer) {
    const canvas = renderer.domElement
    canvas.removeEventListener('mousedown', onMouseDown)
    canvas.removeEventListener('mousemove', onMouseMove)
    canvas.removeEventListener('mouseup', onMouseUp)
    canvas.removeEventListener('mouseleave', onMouseLeave)
    canvas.removeEventListener('touchstart', onTouchStart)
    canvas.removeEventListener('touchmove', onTouchMove)
    canvas.removeEventListener('touchend', onTouchEnd)
    renderer.dispose()
  }
})
</script>

<style scoped>
.dream-intro-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 10;
  opacity: 1;
  pointer-events: auto;
}

.three-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
}

.hint-text {
  position: absolute;
  top: 20%;
  left: 50%;
  transform: translateX(-50%);
  color: rgba(255, 255, 255, 0.6);
  font-size: 1.2rem;
  pointer-events: none;
  animation: pulse 2s infinite;
  z-index: 20;
}

@keyframes pulse {
  0%, 100% { opacity: 0.6; }
  50% { opacity: 1; }
}

.white-curtain {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: white;
  opacity: 0;
  pointer-events: none;
  z-index: 30;
  transition: opacity 1.5s ease-in-out;
}

.white-curtain.show {
  opacity: 1;
}

.white-curtain.fade {
  opacity: 0;
  transition: opacity 1.5s ease-out;
}

/* 视频容器 */
.video-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 40;
}

.dream-video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>
