<template>
  <div class="app">
    <Navbar />
    <Sidebar />
    <main>
      <Hero />
      <About />
      <Skills />
      <Projects />
      <Experience />
      <Contact />
    </main>
  </div>
</template>

<script setup>
import Navbar from './components/Navbar.vue'
import Sidebar from './components/Sidebar.vue'
import Hero from './components/Hero.vue'
import About from './components/About.vue'
import Skills from './components/Skills.vue'
import Projects from './components/Projects.vue'
import Experience from './components/Experience.vue'
import Contact from './components/Contact.vue'
</script>

<style scoped>
.app {
  min-height: 100vh;
}
</style>
