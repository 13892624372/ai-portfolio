<template>
  <div class="app">
    <Navbar @openProject="handleOpenProject" />
    <Sidebar />
    <main>
      <Hero />
      <!-- 横向滚动区域容器 -->
      <div class="horizontal-scroll-wrapper">
        <div class="horizontal-scroll-container" ref="horizontalContainer">
          <div class="horizontal-panel-narrow about-me-panel">
            <AboutMe />
          </div>
          <div class="horizontal-panel-medium about-ai-panel">
            <AITimeline />
          </div>
          <div class="horizontal-panel-narrow model-radar-panel">
            <ModelRadar />
          </div>
          <div class="horizontal-panel-skills skills-panel">
            <Skills />
          </div>
        </div>
      </div>
      <Projects ref="projectsRef" />
      <Experience />
      <Dream />
      <Contact />
    </main>
    <!-- 水波纹效果 -->
    <WaterRippleEffect />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import Navbar from './components/Navbar.vue'
import Sidebar from './components/Sidebar.vue'
import Hero from './components/Hero.vue'
import AboutMe from './components/AboutMe.vue'

import ModelRadar from './components/ModelRadar.vue'
import Skills from './components/Skills.vue'
import Projects from './components/Projects.vue'
import AITimeline from './components/AITimeline.vue'
import Experience from './components/Experience.vue'
import Dream from './components/Dream.vue'
import Contact from './components/Contact.vue'
import WaterRippleEffect from './components/WaterRippleEffect.vue'

const projectsRef = ref(null)
const horizontalContainer = ref(null)
let horizontalScrollTrigger = null

const handleOpenProject = (projectId) => {
  // 等待页面滚动完成后再打开弹窗
  setTimeout(() => {
    if (projectsRef.value) {
      // 调用 Projects 组件的 openModal 方法
      projectsRef.value.openModal(projectId)
    }
  }, 300)
}

// 初始化 GSAP ScrollTrigger
onMounted(() => {
  gsap.registerPlugin(ScrollTrigger)
  
  // 初始化横向滚动
  initHorizontalScroll()
})

onUnmounted(() => {
  // 清理 ScrollTrigger
  if (horizontalScrollTrigger) {
    horizontalScrollTrigger.kill()
  }
})

// 横向滚动动画实例（用于子组件同步）
let horizontalScrollTween = null

// 横向滚动逻辑
const initHorizontalScroll = () => {
  if (!horizontalContainer.value) return

  const container = horizontalContainer.value
  const viewportWidth = window.innerWidth
  // 总宽度：关于我(80vw) + 关于AI(180vw) + 大模型对比(80vw) + Skills(100vw) = 440vw
  // 横向滚动距离：440vw - 100vw(视口) = 340vw
  const scrollDistance = viewportWidth * 3.4

  // 创建横向滚动动画 tween
  horizontalScrollTween = gsap.to(container, {
    x: -scrollDistance,
    ease: 'none',
    scrollTrigger: {
      trigger: '.horizontal-scroll-wrapper',
      start: 'top top',
      end: () => `+=${scrollDistance}`,
      pin: true,
      scrub: 1,
      anticipatePin: 1,
      onUpdate: (self) => {
        // 触发全局事件，通知子组件滚动进度
        window.dispatchEvent(new CustomEvent('horizontal-scroll', {
          detail: { progress: self.progress, scrollDistance }
        }))
      }
    }
  })

  horizontalScrollTrigger = horizontalScrollTween.scrollTrigger
}
</script>

<style scoped>
.app {
  min-height: 100vh;
}

/* 横向滚动区域样式 */
.horizontal-scroll-wrapper {
  position: relative;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  background: var(--bg-primary, #ffffff);
  z-index: 10;
}

.horizontal-scroll-container {
  display: flex;
  width: 440vw; /* 关于我(80) + 关于AI(180) + 大模型对比(80) + Skills(100) = 440vw */
  height: 100%;
  will-change: transform;
}

.horizontal-panel-narrow {
  width: 80vw;
  height: 100vh;
  flex-shrink: 0;
  overflow-y: auto;
}

.horizontal-panel-medium {
  width: 180vw;
  height: 100vh;
  flex-shrink: 0;
  overflow-y: auto;
}

.horizontal-panel-skills {
  width: 100vw;
  height: 100vh;
  flex-shrink: 0;
  overflow-y: auto;
}

/* 自定义滚动条 */
.horizontal-panel::-webkit-scrollbar {
  width: 6px;
}

.horizontal-panel::-webkit-scrollbar-track {
  background: transparent;
}

.horizontal-panel::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.3);
  border-radius: 3px;
}

.horizontal-panel::-webkit-scrollbar-thumb:hover {
  background: rgba(128, 128, 128, 0.5);
}

/* 面板背景色 */
.about-me-panel {
  background: var(--bg-primary, #ffffff);
}

.about-ai-panel {
  background: var(--bg-primary, #ffffff);
}

.model-radar-panel {
  background: var(--bg-primary, #ffffff);
}

.skills-panel {
  background: var(--bg-primary, #ffffff);
}
</style>
