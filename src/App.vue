<template>
  <div class="app">
    <Navbar @openProject="handleOpenProject" />
    <Sidebar />
    <main>
      <Hero />
      <About />
      <Skills />
      <Projects ref="projectsRef" />
      <Experience />
      <Contact />
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'
import Navbar from './components/Navbar.vue'
import Sidebar from './components/Sidebar.vue'
import Hero from './components/Hero.vue'
import About from './components/About.vue'
import Skills from './components/Skills.vue'
import Projects from './components/Projects.vue'
import Experience from './components/Experience.vue'
import Contact from './components/Contact.vue'

const projectsRef = ref(null)

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
})
</script>

<style scoped>
.app {
  min-height: 100vh;
}
</style>
