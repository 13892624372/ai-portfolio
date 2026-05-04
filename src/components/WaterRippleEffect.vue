<template>
  <div ref="containerRef" class="water-ripple-container"></div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const containerRef = ref(null)
let animationId = null
let ripples = []
let isInTargetArea = false

// 检查是否在目标区域（Hero 或 AboutMe）
const checkTargetArea = (y) => {
  const heroSection = document.querySelector('.hero')
  const aboutSection = document.querySelector('.about-me')
  
  let inHero = false
  let inAbout = false
  
  if (heroSection) {
    const rect = heroSection.getBoundingClientRect()
    inHero = y >= rect.top && y <= rect.bottom
  }
  
  if (aboutSection) {
    const rect = aboutSection.getBoundingClientRect()
    inAbout = y >= rect.top && y <= rect.bottom
  }
  
  return inHero || inAbout
}

class Ripple {
  constructor(x, y, intensity = 1) {
    this.x = x
    this.y = y
    this.radius = 0
    this.maxRadius = 80 * intensity
    this.opacity = 0.4 * intensity
    this.lineWidth = 3 * intensity
    this.speed = 1.5 + intensity
    this.intensity = intensity
    
    // 液态玻璃效果参数
    this.waves = []
    const waveCount = 3 + Math.floor(intensity * 2)
    for (let i = 0; i < waveCount; i++) {
      this.waves.push({
        offset: i * 8,
        amplitude: 2 + Math.random() * 3,
        frequency: 0.1 + Math.random() * 0.1,
        phase: Math.random() * Math.PI * 2
      })
    }
  }

  update() {
    this.radius += this.speed
    this.opacity -= 0.008
    this.lineWidth -= 0.015
    
    // 更新波纹相位
    this.waves.forEach(wave => {
      wave.phase += 0.1
    })
    
    return this.opacity > 0 && this.lineWidth > 0
  }

  draw(ctx) {
    const progress = this.radius / this.maxRadius
    
    // 主波纹 - 液态玻璃外圈
    ctx.beginPath()
    this.drawLiquidCircle(ctx, this.x, this.y, this.radius, this.waves)
    ctx.strokeStyle = `rgba(180, 220, 255, ${this.opacity * 0.8})`
    ctx.lineWidth = Math.max(0.5, this.lineWidth)
    ctx.stroke()
    
    // 内圈高光
    if (this.radius > 15) {
      ctx.beginPath()
      this.drawLiquidCircle(ctx, this.x, this.y, this.radius * 0.7, this.waves, 0.5)
      ctx.strokeStyle = `rgba(200, 235, 255, ${this.opacity * 0.6})`
      ctx.lineWidth = Math.max(0.3, this.lineWidth * 0.6)
      ctx.stroke()
    }
    
    // 核心高光点
    if (this.radius > 30 && this.intensity > 1) {
      ctx.beginPath()
      ctx.arc(this.x, this.y, 4, 0, Math.PI * 2)
      ctx.fillStyle = `rgba(220, 240, 255, ${this.opacity * 0.4})`
      ctx.fill()
    }
    
    // 玻璃反光效果
    if (this.radius > 20) {
      ctx.beginPath()
      const gradient = ctx.createRadialGradient(
        this.x - this.radius * 0.3, 
        this.y - this.radius * 0.3, 
        0,
        this.x, 
        this.y, 
        this.radius * 0.5
      )
      gradient.addColorStop(0, `rgba(255, 255, 255, ${this.opacity * 0.3})`)
      gradient.addColorStop(1, `rgba(255, 255, 255, 0)`)
      ctx.fillStyle = gradient
      ctx.arc(this.x, this.y, this.radius * 0.5, 0, Math.PI * 2)
      ctx.fill()
    }
  }
  
  // 绘制液态圆形（带波浪变形）
  drawLiquidCircle(ctx, cx, cy, radius, waves, phaseOffset = 0) {
    const points = 60
    for (let i = 0; i <= points; i++) {
      const angle = (i / points) * Math.PI * 2
      let r = radius
      
      // 应用波浪变形
      waves.forEach(wave => {
        r += Math.sin(angle * wave.frequency * 10 + wave.phase + phaseOffset) * wave.amplitude * (1 - radius / this.maxRadius)
      })
      
      const x = cx + Math.cos(angle) * r
      const y = cy + Math.sin(angle) * r
      
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.closePath()
  }
}

const init = () => {
  const container = containerRef.value
  if (!container) return

  // 创建 canvas
  const canvas = document.createElement('canvas')
  canvas.style.position = 'fixed'
  canvas.style.top = '0'
  canvas.style.left = '0'
  canvas.style.width = '100%'
  canvas.style.height = '100%'
  canvas.style.pointerEvents = 'none'
  canvas.style.zIndex = '9999'
  container.appendChild(canvas)

  const ctx = canvas.getContext('2d')

  const resize = () => {
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
  }
  resize()
  window.addEventListener('resize', resize)

  // 鼠标移动创建涟漪
  const onMouseMove = (e) => {
    // 检查是否在目标区域
    isInTargetArea = checkTargetArea(e.clientY)
    if (!isInTargetArea) return
    
    // 限制创建频率
    if (Math.random() > 0.2) return
    ripples.push(new Ripple(e.clientX, e.clientY, 0.6))
  }

  // 点击创建涟漪
  const onClick = (e) => {
    // 检查是否在目标区域
    if (!checkTargetArea(e.clientY)) return
    
    // 创建2层涟漪，避免重叠过多
    for (let i = 0; i < 2; i++) {
      setTimeout(() => {
        const ripple = new Ripple(e.clientX, e.clientY, 1.0)
        ripple.maxRadius = 100
        ripple.opacity = 0.35
        ripple.speed = 1.8
        ripples.push(ripple)
      }, i * 150)
    }
  }

  window.addEventListener('mousemove', onMouseMove)
  window.addEventListener('click', onClick)

  // 动画循环
  const animate = () => {
    animationId = requestAnimationFrame(animate)
    
    ctx.clearRect(0, 0, canvas.width, canvas.height)
    
    // 更新和绘制涟漪
    ripples = ripples.filter(ripple => {
      const alive = ripple.update()
      if (alive) ripple.draw(ctx)
      return alive
    })
  }
  animate()

  // 保存清理函数
  container._cleanup = () => {
    window.removeEventListener('resize', resize)
    window.removeEventListener('mousemove', onMouseMove)
    window.removeEventListener('click', onClick)
  }
}

onMounted(() => {
  init()
})

onUnmounted(() => {
  if (animationId) cancelAnimationFrame(animationId)
  if (containerRef.value && containerRef.value._cleanup) {
    containerRef.value._cleanup()
  }
})
</script>

<style scoped>
.water-ripple-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  z-index: 9999;
}
</style>
