<template>
  <section class="section ai-timeline-horizontal">
    <div class="timeline-header">
      <h2 class="section-title">AI 发展历程</h2>
      <p class="section-subtitle">人工智能从诞生到爆发的关键里程碑</p>
    </div>

    <div class="timeline-horizontal-wrapper" ref="wrapperRef">
      <!-- 3D 纸飞机容器 -->
      <div class="plane-3d-container" ref="planeContainerRef"></div>

      <!-- 横向时间轴条目 -->
      <div class="timeline-horizontal-items">
        <div
          v-for="(item, index) in timelineData"
          :key="index"
          class="timeline-horizontal-item"
          :class="{ 
            'item-top': index % 2 === 0, 
            'item-bottom': index % 2 === 1,
            'visible': visibleItems[index]
          }"
        >
          <!-- 内容卡片 - 横向布局 -->
          <div class="timeline-horizontal-content">
            <div class="timeline-horizontal-year">{{ item.year }}</div>
            <div class="timeline-horizontal-info">
              <div class="timeline-horizontal-title">{{ item.title }}</div>
              <div class="timeline-horizontal-desc">{{ item.description }}</div>
              <div class="timeline-horizontal-tags" v-if="item.tags">
                <span v-for="(tag, tagIndex) in item.tags" :key="tagIndex" class="tag">
                  {{ tag }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import * as THREE from 'three'
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader.js'
import { MTLLoader } from 'three/examples/jsm/loaders/MTLLoader.js'

gsap.registerPlugin(ScrollTrigger)

// 时间轴数据 - AI发展历程
const timelineData = [
  {
    year: '1950',
    title: '图灵测试提出',
    description: '艾伦·图灵发表《计算机器与智能》，提出著名的图灵测试，为人工智能奠定了理论基础。',
    tags: ['理论基础', '图灵']
  },
  {
    year: '1956',
    title: '人工智能诞生',
    description: '达特茅斯会议召开，约翰·麦卡锡首次提出"人工智能"这一术语，标志着AI作为独立学科的诞生。',
    tags: ['达特茅斯会议', '学科诞生']
  },
  {
    year: '1966',
    title: 'ELIZA 聊天机器人',
    description: '约瑟夫·魏泽鲍姆开发出ELIZA，这是世界上第一个聊天机器人，展示了自然语言处理的早期可能性。',
    tags: ['NLP', '聊天机器人']
  },
  {
    year: '1997',
    title: '深蓝击败卡斯帕罗夫',
    description: 'IBM深蓝超级计算机击败国际象棋世界冠军，这是AI首次在复杂策略游戏中战胜人类顶尖选手。',
    tags: ['IBM', '博弈论']
  },
  {
    year: '2012',
    title: '深度学习革命',
    description: 'AlexNet在ImageNet竞赛中以压倒性优势获胜，深度神经网络重新引发全球关注。',
    tags: ['深度学习', '神经网络']
  },
  {
    year: '2016',
    title: 'AlphaGo 战胜李世石',
    description: 'Google DeepMind的AlphaGo以4:1击败围棋世界冠军，这一古老而复杂的游戏曾被认为是人类智慧的堡垒。',
    tags: ['DeepMind', '强化学习']
  },
  {
    year: '2020',
    title: 'GPT-3 震撼发布',
    description: 'OpenAI发布GPT-3，拥有1750亿参数，展现出惊人的语言理解和生成能力，开启了大语言模型时代。',
    tags: ['OpenAI', '大语言模型']
  },
  {
    year: '2022',
    title: 'ChatGPT 引爆AI浪潮',
    description: 'ChatGPT发布，两个月内用户突破1亿，成为历史上增长最快的消费级应用，将生成式AI带入大众视野。',
    tags: ['ChatGPT', '生成式AI']
  },
  {
    year: '2023',
    title: '多模态AI爆发',
    description: 'GPT-4、Claude、Midjourney等多模态大模型相继发布，AI开始具备理解图像、音频、视频的能力。',
    tags: ['GPT-4', '多模态']
  },
  {
    year: '2024',
    title: 'AI Agent 元年',
    description: 'AI Agent成为新热点，大模型开始具备规划、执行、调用工具的能力，向着通用人工智能迈进。',
    tags: ['AI Agent', 'AGI']
  }
]

const wrapperRef = ref(null)
const planeContainerRef = ref(null)
const visibleItems = ref(new Array(timelineData.length).fill(false))
let scrollHandler = null
let scene, camera, renderer, planeMesh
let animationId = null
let planeProgress = 0

onMounted(() => {
  // 等待DOM渲染完成
  setTimeout(() => {
    initThreeJS()
    initAnimations()
  }, 300)
})

onUnmounted(() => {
  if (scrollHandler) {
    window.removeEventListener('horizontal-scroll', scrollHandler)
  }
  if (animationId) {
    cancelAnimationFrame(animationId)
  }
  if (renderer) {
    renderer.dispose()
  }
})

// 创建KF-21战斗机3D模型 - 基于图片精确设计
const createFighterJet = (texture) => {
  const jetGroup = new THREE.Group()
  
  // 使用图片纹理创建材质
  const bodyMaterial = new THREE.MeshPhongMaterial({
    map: texture,
    shininess: 80,
    specular: 0x666666
  })
  
  const darkMaterial = new THREE.MeshPhongMaterial({
    color: 0x1a202c,
    shininess: 40
  })
  
  const glassMaterial = new THREE.MeshPhongMaterial({
    color: 0x2d3748,
    transparent: true,
    opacity: 0.6,
    shininess: 120,
    specular: 0xffffff
  })
  
  // ========== 机身主体 - 扁平菱形截面 ==========
  // 使用BoxGeometry创建扁平机身，更符合隐身战机设计
  const fuselageShape = new THREE.Shape()
  // 创建菱形截面
  fuselageShape.moveTo(0, 0.45)
  fuselageShape.lineTo(0.35, 0)
  fuselageShape.lineTo(0, -0.35)
  fuselageShape.lineTo(-0.35, 0)
  fuselageShape.lineTo(0, 0.45)
  
  const fuselagePath = new THREE.CurvePath()
  const fuselageCurve = new THREE.CatmullRomCurve3([
    new THREE.Vector3(0, 0, -4),
    new THREE.Vector3(0, 0, 0),
    new THREE.Vector3(0, 0, 4)
  ])
  
  const fuselageGeometry = new THREE.ExtrudeGeometry(fuselageShape, {
    depth: 8,
    bevelEnabled: true,
    bevelThickness: 0.05,
    bevelSize: 0.02,
    bevelSegments: 3
  })
  fuselageGeometry.rotateX(Math.PI / 2)
  fuselageGeometry.scale(1.2, 0.8, 1)
  
  const fuselage = new THREE.Mesh(fuselageGeometry, bodyMaterial)
  jetGroup.add(fuselage)
  
  // ========== 机头雷达罩 - 尖锐流线型 ==========
  const noseShape = new THREE.Shape()
  noseShape.moveTo(0, 0.4)
  noseShape.lineTo(0.15, 0)
  noseShape.lineTo(0, -0.15)
  noseShape.lineTo(-0.15, 0)
  noseShape.lineTo(0, 0.4)
  
  const noseGeometry = new THREE.ConeGeometry(0.35, 3.5, 4)
  noseGeometry.rotateX(Math.PI / 2)
  noseGeometry.rotateY(Math.PI / 4)
  const nose = new THREE.Mesh(noseGeometry, bodyMaterial)
  nose.position.z = 5.5
  jetGroup.add(nose)
  
  // ========== 主机翼 - KF-21梯形后掠翼 ==========
  const wingShape = new THREE.Shape()
  // 翼根
  wingShape.moveTo(0.5, 0.3)
  // 前缘后掠
  wingShape.lineTo(4.5, -1.5)
  // 翼尖切角
  wingShape.lineTo(5, -3.2)
  wingShape.lineTo(4.2, -3.5)
  // 后缘
  wingShape.lineTo(1.2, -2.8)
  // 翼根后缘
  wingShape.lineTo(0.5, -0.8)
  wingShape.lineTo(0.5, 0.3)
  
  const wingGeometry = new THREE.ExtrudeGeometry(wingShape, {
    depth: 0.15,
    bevelEnabled: true,
    bevelThickness: 0.05,
    bevelSize: 0.02,
    bevelSegments: 2
  })
  wingGeometry.rotateX(Math.PI / 2)
  
  // 左机翼
  const leftWing = new THREE.Mesh(wingGeometry, bodyMaterial)
  leftWing.position.set(-0.5, -0.05, 0.5)
  leftWing.rotation.y = Math.PI
  jetGroup.add(leftWing)
  
  // 右机翼
  const rightWing = new THREE.Mesh(wingGeometry, bodyMaterial)
  rightWing.position.set(0.5, -0.05, 0.5)
  jetGroup.add(rightWing)
  
  // ========== 水平尾翼 - 全动式 ==========
  const tailShape = new THREE.Shape()
  tailShape.moveTo(0.3, 0.2)
  tailShape.lineTo(2, -0.5)
  tailShape.lineTo(2.3, -1.8)
  tailShape.lineTo(1.5, -2)
  tailShape.lineTo(0.3, -0.6)
  tailShape.lineTo(0.3, 0.2)
  
  const tailGeometry = new THREE.ExtrudeGeometry(tailShape, {
    depth: 0.12,
    bevelEnabled: true,
    bevelThickness: 0.04,
    bevelSize: 0.015,
    bevelSegments: 2
  })
  tailGeometry.rotateX(Math.PI / 2)
  
  // 左水平尾翼
  const leftTail = new THREE.Mesh(tailGeometry, bodyMaterial)
  leftTail.position.set(-0.35, 0.1, -3.5)
  leftTail.rotation.y = Math.PI
  jetGroup.add(leftTail)
  
  // 右水平尾翼
  const rightTail = new THREE.Mesh(tailGeometry, bodyMaterial)
  rightTail.position.set(0.35, 0.1, -3.5)
  jetGroup.add(rightTail)
  
  // ========== 双垂直尾翼 - 大角度V型外倾 ==========
  const vTailShape = new THREE.Shape()
  vTailShape.moveTo(0, 0)
  vTailShape.lineTo(0.9, 0)
  vTailShape.lineTo(1.4, 2.8)
  vTailShape.lineTo(0.4, 2.6)
  vTailShape.lineTo(0, 0)
  
  const vTailGeometry = new THREE.ExtrudeGeometry(vTailShape, {
    depth: 0.18,
    bevelEnabled: true,
    bevelThickness: 0.05,
    bevelSize: 0.02,
    bevelSegments: 2
  })
  
  // 左垂尾 - 大角度外倾
  const leftVTail = new THREE.Mesh(vTailGeometry, bodyMaterial)
  leftVTail.position.set(-0.9, 0.3, -3.8)
  leftVTail.rotation.y = Math.PI / 2
  leftVTail.rotation.z = -0.35 // 更大的V型外倾角
  jetGroup.add(leftVTail)
  
  // 右垂尾 - 大角度外倾
  const rightVTail = new THREE.Mesh(vTailGeometry, bodyMaterial)
  rightVTail.position.set(0.9, 0.3, -3.8)
  rightVTail.rotation.y = Math.PI / 2
  rightVTail.rotation.z = 0.35 // 更大的V型外倾角
  jetGroup.add(rightVTail)
  
  // ========== DSI进气道 - 鼓包式设计 ==========
  // 创建鼓包形状
  const bumpGeometry = new THREE.SphereGeometry(0.5, 16, 12, 0, Math.PI * 2, 0, Math.PI / 2)
  bumpGeometry.scale(1, 0.4, 1.5)
  
  const leftBump = new THREE.Mesh(bumpGeometry, bodyMaterial)
  leftBump.position.set(-0.7, -0.25, 1.5)
  leftBump.rotation.x = -Math.PI / 6
  jetGroup.add(leftBump)
  
  const rightBump = new THREE.Mesh(bumpGeometry, bodyMaterial)
  rightBump.position.set(0.7, -0.25, 1.5)
  rightBump.rotation.x = -Math.PI / 6
  jetGroup.add(rightBump)
  
  // 进气口
  const intakeOpeningGeometry = new THREE.BoxGeometry(0.5, 0.35, 0.8)
  
  const leftIntake = new THREE.Mesh(intakeOpeningGeometry, darkMaterial)
  leftIntake.position.set(-0.7, -0.4, 1.8)
  leftIntake.rotation.x = 0.2
  jetGroup.add(leftIntake)
  
  const rightIntake = new THREE.Mesh(intakeOpeningGeometry, darkMaterial)
  rightIntake.position.set(0.7, -0.4, 1.8)
  rightIntake.rotation.x = 0.2
  jetGroup.add(rightIntake)
  
  // ========== 驾驶舱 - 气泡式整体座舱 ==========
  const cockpitGeometry = new THREE.CapsuleGeometry(0.4, 2.2, 8, 16)
  cockpitGeometry.rotateX(Math.PI / 2)
  const cockpit = new THREE.Mesh(cockpitGeometry, glassMaterial)
  cockpit.position.set(0, 0.65, 1.5)
  cockpit.scale.set(1, 0.7, 1)
  jetGroup.add(cockpit)
  
  // 座舱边框
  const cockpitFrameGeometry = new THREE.TorusGeometry(0.42, 0.03, 8, 20)
  cockpitFrameGeometry.rotateY(Math.PI / 2)
  const frameMaterial = new THREE.MeshPhongMaterial({ color: 0x1a202c })
  const cockpitFrame = new THREE.Mesh(cockpitFrameGeometry, frameMaterial)
  cockpitFrame.position.set(0, 0.65, 2.5)
  jetGroup.add(cockpitFrame)
  
  // ========== 发动机喷口 - 扁平矩形双发 ==========
  const exhaustShape = new THREE.Shape()
  exhaustShape.moveTo(-0.3, 0.2)
  exhaustShape.lineTo(0.3, 0.2)
  exhaustShape.lineTo(0.25, -0.2)
  exhaustShape.lineTo(-0.25, -0.2)
  exhaustShape.lineTo(-0.3, 0.2)
  
  const exhaustGeometry = new THREE.ExtrudeGeometry(exhaustShape, {
    depth: 0.8,
    bevelEnabled: true,
    bevelThickness: 0.03,
    bevelSize: 0.01,
    bevelSegments: 2
  })
  exhaustGeometry.rotateX(Math.PI / 2)
  
  const exhaustMaterial = new THREE.MeshPhongMaterial({
    color: 0x3d2817,
    emissive: 0xff3300,
    emissiveIntensity: 0.5
  })
  
  const leftExhaust = new THREE.Mesh(exhaustGeometry, exhaustMaterial)
  leftExhaust.position.set(-0.55, -0.2, -4.2)
  jetGroup.add(leftExhaust)
  
  const rightExhaust = new THREE.Mesh(exhaustGeometry, exhaustMaterial)
  rightExhaust.position.set(0.55, -0.2, -4.2)
  jetGroup.add(rightExhaust)
  
  // ========== 武器挂架和导弹 ==========
  // 翼下挂架
  const pylonGeometry = new THREE.CylinderGeometry(0.08, 0.06, 0.6, 8)
  pylonGeometry.rotateX(Math.PI / 2)
  const pylonMaterial = new THREE.MeshPhongMaterial({ color: 0x4a5568 })
  
  // 左机翼挂架
  const leftPylon1 = new THREE.Mesh(pylonGeometry, pylonMaterial)
  leftPylon1.position.set(-3, -0.35, 0.5)
  jetGroup.add(leftPylon1)
  
  const leftPylon2 = new THREE.Mesh(pylonGeometry, pylonMaterial)
  leftPylon2.position.set(-4.5, -0.45, -0.5)
  jetGroup.add(leftPylon2)
  
  // 右机翼挂架
  const rightPylon1 = new THREE.Mesh(pylonGeometry, pylonMaterial)
  rightPylon1.position.set(3, -0.35, 0.5)
  jetGroup.add(rightPylon1)
  
  const rightPylon2 = new THREE.Mesh(pylonGeometry, pylonMaterial)
  rightPylon2.position.set(4.5, -0.45, -0.5)
  jetGroup.add(rightPylon2)
  
  // 导弹/副油箱
  const missileGeometry = new THREE.CylinderGeometry(0.15, 0.12, 2.5, 12)
  missileGeometry.rotateX(Math.PI / 2)
  const missileMaterial = new THREE.MeshPhongMaterial({ 
    color: 0xc0c0c0,
    shininess: 60
  })
  
  // 翼尖导弹
  const leftMissile = new THREE.Mesh(missileGeometry, missileMaterial)
  leftMissile.position.set(-5.2, -0.35, -0.8)
  leftMissile.rotation.z = 0.15
  jetGroup.add(leftMissile)
  
  const rightMissile = new THREE.Mesh(missileGeometry, missileMaterial)
  rightMissile.position.set(5.2, -0.35, -0.8)
  rightMissile.rotation.z = -0.15
  jetGroup.add(rightMissile)
  
  // ========== 机身细节 ==========
  // 脊线
  const spineGeometry = new THREE.BoxGeometry(0.08, 0.15, 6)
  const spine = new THREE.Mesh(spineGeometry, bodyMaterial)
  spine.position.set(0, 0.5, 0)
  jetGroup.add(spine)
  
  // 边条翼
  const strakeShape = new THREE.Shape()
  strakeShape.moveTo(0, 0)
  strakeShape.lineTo(1.5, -0.3)
  strakeShape.lineTo(1.2, -0.6)
  strakeShape.lineTo(0, -0.2)
  strakeShape.lineTo(0, 0)
  
  const strakeGeometry = new THREE.ExtrudeGeometry(strakeShape, {
    depth: 0.08,
    bevelEnabled: false
  })
  strakeGeometry.rotateX(Math.PI / 2)
  
  const leftStrake = new THREE.Mesh(strakeGeometry, bodyMaterial)
  leftStrake.position.set(-0.4, -0.1, 2)
  leftStrake.rotation.y = Math.PI
  jetGroup.add(leftStrake)
  
  const rightStrake = new THREE.Mesh(strakeGeometry, bodyMaterial)
  rightStrake.position.set(0.4, -0.1, 2)
  jetGroup.add(rightStrake)
  
  return jetGroup
}

const initThreeJS = () => {
  if (!planeContainerRef.value) return
  
  const container = planeContainerRef.value
  const width = container.clientWidth
  const height = container.clientHeight
  
  // 创建场景
  scene = new THREE.Scene()
  
  // 创建相机
  camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 1000)
  camera.position.set(0, 5, 15)
  camera.lookAt(0, 0, 0)
  
  // 创建渲染器
  renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true })
  renderer.setSize(width, height)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
  container.appendChild(renderer.domElement)
  
  // 加载纸飞机OBJ模型
  const basePath = import.meta.env.BASE_URL || '/'
  const modelPath = `${basePath}photo/airplane.obj/`
  
  console.log('Loading paper airplane from:', modelPath)
  
  // 先加载OBJ文件
  const objLoader = new OBJLoader()
  objLoader.load(
    `${modelPath}paper_airplane.obj`,
    (object) => {
      console.log('Paper airplane loaded successfully!')
      planeMesh = object
      
      // 给纸飞机添加更浅的米白色材质
      planeMesh.traverse((child) => {
        if (child.isMesh) {
          child.material = new THREE.MeshStandardMaterial({
            color: 0xfaf8f5,  // 更浅的米白色
            metalness: 0.0,
            roughness: 0.95,
            side: THREE.DoubleSide,
            emissive: 0x333333,  // 增加自发光亮度
            emissiveIntensity: 0.25
          })
        }
      })
      
      // 计算模型边界框以居中
      const box = new THREE.Box3().setFromObject(planeMesh)
      const center = box.getCenter(new THREE.Vector3())
      const size = box.getSize(new THREE.Vector3())
      
      console.log('Model size:', size, 'center:', center)
      
      // 调整模型位置和大小
      planeMesh.position.set(-35 - center.x, -center.y, -center.z)
      
      // 缩放模型使其大小合适
      const maxDim = Math.max(size.x, size.y, size.z)
      const scale = 8 / maxDim  // 调整缩放比例
      planeMesh.scale.set(scale, scale, scale)
      
      // 旋转模型使其朝向正确（机头朝左，因为模型方向反了）
      planeMesh.rotation.y = -Math.PI / 2
      
      // 设置整个模型的透明度
      planeMesh.traverse((child) => {
        if (child.isMesh && child.material) {
          child.material.transparent = true
          child.material.opacity = 0
        }
      })
      
      scene.add(planeMesh)
    },
    (xhr) => {
      if (xhr.total > 0) {
        console.log('Loading:', (xhr.loaded / xhr.total * 100).toFixed(2) + '%')
      }
    },
    (error) => {
      console.error('Error loading OBJ model:', error)
    }
  )
  
  // 添加光源系统 - 让纸飞机在白色背景上清晰可见
  
  // 环境光 - 柔和的白色照明
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.7)
  scene.add(ambientLight)
  
  // 主光源 - 从斜上方照射，产生阴影增加立体感
  const mainLight = new THREE.DirectionalLight(0xffffff, 0.8)
  mainLight.position.set(15, 20, 10)
  mainLight.castShadow = true
  scene.add(mainLight)
  
  // 补光 - 从下方和侧面，减少阴影过暗
  const fillLight = new THREE.DirectionalLight(0xfff8e7, 0.4)
  fillLight.position.set(-10, -5, 5)
  scene.add(fillLight)
  
  // 轮廓光 - 突出纸飞机边缘
  const rimLight = new THREE.DirectionalLight(0xffffff, 0.5)
  rimLight.position.set(0, 5, -15)
  scene.add(rimLight)
  
  // 动画循环
  const animate = () => {
    animationId = requestAnimationFrame(animate)
    
    if (planeMesh) {
      // 自身旋转动画
      planeMesh.rotation.z += 0.02
      planeMesh.rotation.x = Math.sin(Date.now() * 0.001) * 0.1
      
      // 飞机从最左侧飞到最右侧，最大飞行距离
      // 进度 0 时在最左侧屏幕外，进度 1 时在最右侧屏幕外
      const extendedProgress = Math.max(-0.15, Math.min(1.15, planeProgress))
      // 飞机位置从 -45 飞到 +45，横跨整个可视区域
      const targetX = -45 + extendedProgress * 90 // 从 -45 飞到 +45，距离 90
      const targetY = Math.sin(extendedProgress * Math.PI * 2) * 1.5 // 上下浮动
      const targetZ = Math.cos(extendedProgress * Math.PI * 2) * 1 // 前后轻微移动
      
      planeMesh.position.x += (targetX - planeMesh.position.x) * 0.08
      planeMesh.position.y += (targetY - planeMesh.position.y) * 0.08
      planeMesh.position.z += (targetZ - planeMesh.position.z) * 0.08
      
      // 飞行姿态 - 机头朝左，保持水平飞行
      planeMesh.rotation.y = -Math.PI / 2
      
      // 渐入渐出效果 - 根据进度调整透明度
      let targetOpacity = 1
      if (planeProgress < 0) {
        // 渐入阶段
        targetOpacity = 1 - Math.abs(planeProgress) / 0.2
      } else if (planeProgress > 1) {
        // 渐出阶段
        targetOpacity = 1 - (planeProgress - 1) / 0.2
      }
      // 应用到战斗机的所有部件
      planeMesh.traverse((child) => {
        if (child.isMesh && child.material) {
          child.material.opacity += (targetOpacity - child.material.opacity) * 0.1
        }
      })
    }
    
    renderer.render(scene, camera)
  }
  
  animate()
  
  // 响应式处理
  const handleResize = () => {
    const newWidth = container.clientWidth
    const newHeight = container.clientHeight
    camera.aspect = newWidth / newHeight
    camera.updateProjectionMatrix()
    renderer.setSize(newWidth, newHeight)
  }
  
  window.addEventListener('resize', handleResize)
}

const initAnimations = () => {
  // 初始状态：所有卡片隐藏
  const items = document.querySelectorAll('.timeline-horizontal-item')
  items.forEach((item, index) => {
    const content = item.querySelector('.timeline-horizontal-content')
    const isTop = index % 2 === 0

    gsap.set(content, {
      opacity: 0,
      y: isTop ? -50 : 50
    })
  })

  // 监听横向滚动事件
  scrollHandler = (e) => {
    const { progress } = e.detail
    updateAnimations(progress)
  }
  window.addEventListener('horizontal-scroll', scrollHandler)
}

const updateAnimations = (scrollProgress) => {
  // 计算纸飞机在AboutAI面板内的位置
  const panelStart = 0.18
  const panelEnd = 0.58

  // 更新3D纸飞机进度
  if (scrollProgress >= panelStart - 0.05 && scrollProgress <= panelEnd + 0.05) {
    const panelProgress = Math.max(0, Math.min(1, (scrollProgress - panelStart) / (panelEnd - panelStart)))
    planeProgress = panelProgress
  }

  // 计算每个条目应该显示的时间点
  if (scrollProgress < panelStart - 0.08 || scrollProgress > panelEnd + 0.08) {
    // 不在当前面板范围内，隐藏所有
    visibleItems.value = new Array(timelineData.length).fill(false)
    return
  }

  // 在当前面板内的进度 (0 ~ 1)
  const itemPanelProgress = Math.max(0, Math.min(1, (scrollProgress - panelStart) / (panelEnd - panelStart)))
   
  // 计算飞机当前在屏幕上的X位置（用于判断卡片触发时机）
  // 飞机位置范围：-45 到 +45，横跨整个屏幕
  const planeX = -45 + itemPanelProgress * 90

  // 根据飞机位置决定每个条目的显示状态
  // 卡片分布在屏幕不同位置，飞机飞到附近时才触发
  timelineData.forEach((_, index) => {
    // 计算每个卡片的目标位置（从左到右均匀分布）
    const cardTargetX = -35 + (index / (timelineData.length - 1)) * 70
    
    // 当飞机接近卡片位置时触发（距离小于12个单位）
    const distance = Math.abs(planeX - cardTargetX)
    const shouldBeVisible = distance < 12

    if (shouldBeVisible && !visibleItems.value[index]) {
      visibleItems.value[index] = true
      animateItemIn(index)
    } else if (!shouldBeVisible && visibleItems.value[index]) {
      visibleItems.value[index] = false
      animateItemOut(index)
    }
  })
}

const animateItemIn = (index) => {
  const items = document.querySelectorAll('.timeline-horizontal-item')
  const item = items[index]
  if (!item) return

  const content = item.querySelector('.timeline-horizontal-content')

  gsap.to(content, {
    opacity: 1,
    y: 0,
    duration: 0.5,
    ease: 'power3.out'
  })
}

const animateItemOut = (index) => {
  const items = document.querySelectorAll('.timeline-horizontal-item')
  const item = items[index]
  if (!item) return

  const content = item.querySelector('.timeline-horizontal-content')
  const isTop = index % 2 === 0

  gsap.to(content, {
    opacity: 0,
    y: isTop ? -50 : 50,
    duration: 0.3,
    ease: 'power2.in'
  })
}
</script>

<style scoped>
.ai-timeline-horizontal {
  width: 100%;
  height: 100%;
  background: var(--bg-primary, #ffffff);
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 40px 80px;
  box-sizing: border-box;
  overflow: hidden;
}

.timeline-header {
  text-align: center;
  margin-bottom: 40px;
  flex-shrink: 0;
  padding: 60px 20px 10px;
  min-height: 120px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
}

.section-title {
  font-size: 2.2rem;
  font-weight: 700;
  color: var(--text-primary, #1a1a2e);
  margin-bottom: 12px;
  background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #ec4899 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  display: block;
  line-height: 1.5;
  padding: 8px 16px;
  min-height: 60px;
}

.section-subtitle {
  font-size: 1rem;
  color: var(--text-secondary, #64748b);
}

/* 横向时间轴容器 */
.timeline-horizontal-wrapper {
  flex: 1;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
  min-height: 500px;
}

/* 3D 纸飞机容器 */
.plane-3d-container {
  position: absolute;
  left: 60px;
  right: 60px;
  top: 50%;
  height: 300px;
  transform: translateY(-50%);
  z-index: 1;
  pointer-events: none;
}

/* 横向时间轴条目容器 */
.timeline-horizontal-items {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  position: relative;
  padding: 0 60px;
  padding-left: calc(60px + 30vw);
  height: 100%;
  gap: 80px;
}

/* 单个时间轴条目 - 适应横向卡片 */
.timeline-horizontal-item {
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  flex-shrink: 0;
  width: auto;
}

/* 上方条目 - 错落高度和视差效果 */
.timeline-horizontal-item.item-top {
  justify-content: flex-end;
  padding-bottom: 120px;
}

.timeline-horizontal-item.item-top .timeline-horizontal-content {
  order: -1;
  margin-bottom: 80px;
}

/* 上方条目错落高度 - 奇数项更高，偶数项较低，形成波浪 */
.timeline-horizontal-item.item-top:nth-child(4n+1) .timeline-horizontal-content {
  transform: translateY(-20px);
}

.timeline-horizontal-item.item-top:nth-child(4n+3) .timeline-horizontal-content {
  transform: translateY(-10px);
}

/* 下方条目 - 错落高度和视差效果 */
.timeline-horizontal-item.item-bottom {
  justify-content: flex-start;
  padding-top: 120px;
}

.timeline-horizontal-item.item-bottom .timeline-horizontal-content {
  margin-top: 80px;
}

/* 下方条目错落高度 - 奇数项更低，偶数项较高，形成波浪 */
.timeline-horizontal-item.item-bottom:nth-child(4n+1) .timeline-horizontal-content {
  transform: translateY(20px);
}

.timeline-horizontal-item.item-bottom:nth-child(4n+3) .timeline-horizontal-content {
  transform: translateY(10px);
}

/* 可见状态下的视差效果 */
.timeline-horizontal-item.visible.item-top:nth-child(4n+1) .timeline-horizontal-content {
  transform: translateY(-30px);
}

.timeline-horizontal-item.visible.item-top:nth-child(4n+3) .timeline-horizontal-content {
  transform: translateY(-25px);
}

.timeline-horizontal-item.visible.item-bottom:nth-child(4n+1) .timeline-horizontal-content {
  transform: translateY(40px);
}

.timeline-horizontal-item.visible.item-bottom:nth-child(4n+3) .timeline-horizontal-content {
  transform: translateY(25px);
}

/* 内容卡片 - 横向布局（宽大于高） */
.timeline-horizontal-content {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 16px;
  padding: 16px 24px;
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid rgba(99, 102, 241, 0.15);
  border-radius: 16px;
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  text-align: left;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  will-change: transform, opacity;
  min-width: 320px;
  max-width: 400px;
}

.timeline-horizontal-item.visible .timeline-horizontal-content {
  background: rgba(255, 255, 255, 0.95);
  border-color: rgba(99, 102, 241, 0.3);
  box-shadow: 0 8px 30px rgba(99, 102, 241, 0.15);
}

.timeline-horizontal-content:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(99, 102, 241, 0.2);
}

/* 左侧：年份 */
.timeline-horizontal-year {
  font-size: 2rem;
  font-weight: 700;
  color: #6366f1;
  line-height: 1;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  flex-shrink: 0;
  min-width: 80px;
  text-align: center;
}

/* 右侧：内容区域 */
.timeline-horizontal-info {
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
}

.timeline-horizontal-title {
  font-size: 1rem;
  font-weight: 600;
  color: var(--text-primary, #1a1a2e);
  line-height: 1.3;
}

.timeline-horizontal-desc {
  font-size: 0.8rem;
  color: var(--text-secondary, #64748b);
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.timeline-horizontal-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 4px;
  margin-top: 4px;
}

.tag {
  padding: 2px 8px;
  background: rgba(99, 102, 241, 0.1);
  border: 1px solid rgba(99, 102, 241, 0.2);
  border-radius: 12px;
  font-size: 0.7rem;
  color: #6366f1;
  font-weight: 500;
}

/* 响应式调整 */
@media (max-width: 1600px) {
  .timeline-horizontal-items {
    gap: 60px;
    padding: 0 40px;
  }

  .timeline-horizontal-item {
    width: 180px;
  }
}

@media (max-width: 1400px) {
  .ai-timeline-horizontal {
    padding: 40px 60px;
  }

  .timeline-horizontal-items {
    gap: 50px;
    padding: 0 30px;
  }

  .timeline-horizontal-item {
    width: 160px;
  }

  .timeline-horizontal-item.item-top {
    padding-bottom: 150px;
  }

  .timeline-horizontal-item.item-top .timeline-horizontal-content {
    margin-bottom: 100px;
  }

  .timeline-horizontal-item.item-bottom {
    padding-top: 150px;
  }

  .timeline-horizontal-item.item-bottom .timeline-horizontal-content {
    margin-top: 100px;
  }

  .timeline-horizontal-year {
    font-size: 1.2rem;
  }

  .timeline-horizontal-title {
    font-size: 0.85rem;
  }

  .timeline-horizontal-desc {
    font-size: 0.7rem;
    -webkit-line-clamp: 2;
  }
}

@media (max-width: 1200px) {
  .ai-timeline-horizontal {
    padding: 30px 40px;
  }

  .timeline-horizontal-items {
    gap: 40px;
    padding: 0 20px;
  }

  .timeline-horizontal-item {
    width: 140px;
  }

  .section-title {
    font-size: 1.8rem;
  }

  .timeline-horizontal-content {
    padding: 12px;
  }

  .timeline-horizontal-year {
    font-size: 1.1rem;
  }

  .timeline-horizontal-desc {
    display: none;
  }
}

@media (max-width: 992px) {
  .timeline-horizontal-items {
    gap: 30px;
  }

  .timeline-horizontal-item {
    width: 120px;
  }

  .timeline-horizontal-tags {
    display: none;
  }

  .timeline-horizontal-title {
    font-size: 0.75rem;
  }
}
</style>
