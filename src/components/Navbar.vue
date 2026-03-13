<template>
  <nav class="navbar" :class="{ 'scrolled': isScrolled }">
    <div class="container">
      <div class="nav-wrapper">
        <a href="#" class="logo">
          <span class="logo-icon">AI</span>
        </a>
        
        <div class="nav-links" :class="{ 'active': isMenuOpen }">
          <a href="#hero" @click="closeMenu" class="nav-link">首页</a>
          <a href="#about" @click="closeMenu" class="nav-link">关于</a>
          
          <!-- 技能下拉菜单 -->
          <div class="nav-dropdown" 
               @mouseenter="showSkillsDropdown = true" 
               @mouseleave="showSkillsDropdown = false">
            <a href="#skills" @click="closeMenu" class="nav-link">技能</a>
            <div class="dropdown-menu" :class="{ 'show': showSkillsDropdown }">
              <a href="#skill1" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);">1</span>
                <span>技能 1</span>
              </a>
              <a href="#skill2" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #10b981 0%, #34d399 100%);">2</span>
                <span>技能 2</span>
              </a>
              <a href="#skill3" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);">3</span>
                <span>技能 3</span>
              </a>
            </div>
          </div>
          
          <!-- 项目下拉菜单 -->
          <div class="nav-dropdown" 
               @mouseenter="showProjectsDropdown = true" 
               @mouseleave="showProjectsDropdown = false">
            <a href="#projects" @click="closeMenu" class="nav-link">项目</a>
            <div class="dropdown-menu" :class="{ 'show': showProjectsDropdown }">
              <a href="#project1" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #ec4899 0%, #f472b6 100%);">1</span>
                <span>项目 1</span>
              </a>
              <a href="#project2" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);">2</span>
                <span>项目 2</span>
              </a>
              <a href="#project3" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);">3</span>
                <span>项目 3</span>
              </a>
            </div>
          </div>
          
          <a href="#experience" @click="closeMenu" class="nav-link">经历</a>
          <a href="#contact" @click="closeMenu" class="nav-link">联系</a>
        </div>
        
        <button class="menu-toggle" @click="toggleMenu" aria-label="Toggle menu">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const isScrolled = ref(false)
const isMenuOpen = ref(false)
const showSkillsDropdown = ref(false)
const showProjectsDropdown = ref(false)

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

const closeMenu = () => {
  isMenuOpen.value = false
  showSkillsDropdown.value = false
  showProjectsDropdown.value = false
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  padding: 20px 0;
  transition: all 0.3s ease;
}

.navbar.scrolled {
  background: rgba(15, 23, 42, 0.95);
  backdrop-filter: blur(10px);
  padding: 15px 0;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.nav-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
  color: var(--text-primary);
  font-weight: 700;
  font-size: 1.5rem;
}

.logo-icon {
  width: 40px;
  height: 40px;
  background: var(--gradient-1);
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
}

.logo-text {
  background: var(--gradient-1);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.nav-links {
  display: flex;
  gap: 30px;
  align-items: center;
}

.nav-link {
  color: var(--text-secondary);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s ease;
  position: relative;
}

.nav-link:hover {
  color: var(--text-primary);
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--gradient-1);
  transition: width 0.3s ease;
}

.nav-link:hover::after {
  width: 100%;
}

/* 下拉菜单样式 */
.nav-dropdown {
  position: relative;
  padding-bottom: 20px;
  margin-bottom: -20px;
}

.dropdown-menu {
  position: absolute;
  top: calc(100% + 10px);
  left: 50%;
  transform: translateX(-50%) translateY(-10px);
  background: rgba(30, 41, 59, 0.98);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 8px;
  min-width: 150px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  opacity: 0;
  visibility: hidden;
  transition: all 0.2s ease;
  pointer-events: none;
}

.dropdown-menu.show {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(0);
  pointer-events: auto;
}

/* 添加连接区域，让鼠标可以顺利从导航链接移动到下拉菜单 */
.nav-dropdown::before {
  content: '';
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  height: 20px;
  background: transparent;
}

.dropdown-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  color: var(--text-secondary);
  text-decoration: none;
  border-radius: 8px;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.dropdown-item:hover {
  background: rgba(99, 102, 241, 0.1);
  color: var(--text-primary);
}

.dropdown-number {
  width: 28px;
  height: 28px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 0.85rem;
  font-weight: 600;
  flex-shrink: 0;
}

.menu-toggle {
  display: none;
  flex-direction: column;
  gap: 5px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 5px;
}

.menu-toggle span {
  width: 25px;
  height: 2px;
  background: var(--text-primary);
  transition: all 0.3s ease;
}

@media (max-width: 768px) {
  .menu-toggle {
    display: flex;
  }
  
  .nav-links {
    position: fixed;
    top: 70px;
    left: 0;
    right: 0;
    background: rgba(15, 23, 42, 0.98);
    flex-direction: column;
    padding: 20px;
    gap: 12px;
    transform: translateY(-100%);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    align-items: stretch;
    max-height: calc(100vh - 70px);
    overflow-y: auto;
  }
  
  .nav-links.active {
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
  }
  
  .nav-link {
    padding: 12px 16px;
    font-size: 1rem;
  }
  
  .nav-dropdown {
    display: flex;
    flex-direction: column;
  }
  
  .dropdown-menu {
    position: static;
    transform: none;
    margin-top: 8px;
    margin-left: 16px;
    background: rgba(255, 255, 255, 0.05);
    box-shadow: none;
    animation: none;
    opacity: 1;
    visibility: visible;
    display: none;
  }
  
  .dropdown-menu.show {
    display: flex;
  }
  
  .dropdown-item {
    padding: 10px 14px;
    font-size: 0.9rem;
  }
  
  .dropdown-number {
    width: 28px;
    height: 28px;
    font-size: 0.85rem;
  }
}
</style>
