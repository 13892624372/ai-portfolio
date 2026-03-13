<template>
  <aside class="sidebar" :class="{ visible: isVisible }">
    <div class="sidebar-content">
      <div class="sidebar-header">
        <span class="sidebar-title">目录导航</span>
      </div>
      <nav class="sidebar-nav">
        <a 
          v-for="item in navItems" 
          :key="item.id"
          :href="item.href"
          class="sidebar-link"
          :class="{ active: activeSection === item.id }"
          @click="scrollToSection(item.href)"
        >
          <span class="link-icon">{{ item.icon }}</span>
          <span class="link-text">{{ item.name }}</span>
        </a>
      </nav>
    </div>
    <button class="toggle-btn" @click="toggleSidebar">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <polyline v-if="isVisible" points="15 18 9 12 15 6"></polyline>
        <polyline v-else points="9 18 15 12 9 6"></polyline>
      </svg>
    </button>
  </aside>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const isVisible = ref(true)
const activeSection = ref('hero')

const navItems = [
  { id: 'hero', name: '首页', href: '#hero', icon: '🏠' },
  { id: 'about', name: '关于', href: '#about', icon: '👤' },
  { id: 'skills', name: '技术能力', href: '#skills', icon: '💻' },
  { id: 'projects', name: '项目作品', href: '#projects', icon: '🚀' },
  { id: 'experience', name: '工作经历', href: '#experience', icon: '📚' },
  { id: 'contact', name: '联系', href: '#contact', icon: '📧' }
]

const toggleSidebar = () => {
  isVisible.value = !isVisible.value
}

const scrollToSection = (href) => {
  const element = document.querySelector(href)
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' })
  }
}

const handleScroll = () => {
  const scrollPosition = window.scrollY + 200
  
  navItems.forEach(item => {
    const element = document.querySelector(item.href)
    if (element) {
      const elementTop = element.offsetTop
      const elementBottom = elementTop + element.offsetHeight
      
      if (scrollPosition >= elementTop && scrollPosition < elementBottom) {
        activeSection.value = item.id
      }
    }
  })
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  handleScroll()
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
.sidebar {
  position: fixed;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  z-index: 999;
  transition: all 0.3s ease;
}

.sidebar:not(.visible) {
  left: 0;
}

.sidebar-content {
  background: rgba(15, 23, 42, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 0 16px 16px 0;
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 20px;
  min-width: 180px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
  transition: all 0.3s ease;
}

.sidebar:not(.visible) .sidebar-content {
  transform: translateX(-100%);
  opacity: 0;
  pointer-events: none;
}

.sidebar-header {
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-title {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-primary);
}

.sidebar-nav {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.sidebar-link {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  border-radius: 8px;
  color: var(--text-secondary);
  text-decoration: none;
  font-size: 0.9rem;
  font-weight: 500;
  transition: all 0.3s ease;
}

.sidebar-link:hover {
  background: rgba(99, 102, 241, 0.1);
  color: var(--text-primary);
}

.sidebar-link.active {
  background: var(--gradient-1);
  color: white;
}

.link-icon {
  font-size: 1rem;
}

.link-text {
  white-space: nowrap;
}

.toggle-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 40px;
  height: 60px;
  background: rgba(15, 23, 42, 0.95);
  border: 1px solid rgba(255, 255, 255, 0.1);
  color: var(--text-secondary);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.sidebar.visible .toggle-btn {
  right: -40px;
  border-radius: 0 12px 12px 0;
  border-left: none;
}

.sidebar:not(.visible) .toggle-btn {
  left: 0;
  border-radius: 0 12px 12px 0;
  border-left: 1px solid rgba(255, 255, 255, 0.1);
}

.toggle-btn:hover {
  background: var(--gradient-1);
  color: white;
}

@media (max-width: 1024px) {
  .sidebar {
    display: none;
  }
}
</style>
