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
               @mouseenter="!isMobile && (showSkillsDropdown = true)"
               @mouseleave="!isMobile && (showSkillsDropdown = false)">
            <a href="#skills" @click.prevent="toggleSkillsDropdown" class="nav-link nav-dropdown-toggle">
              <span>技能</span>
              <svg class="dropdown-arrow" :class="{ 'rotated': showSkillsDropdown }" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </a>
            <div class="dropdown-menu" :class="{ 'show': showSkillsDropdown }">
              <a href="#skill1" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #42b883 0%, #35495e 100%);">1</span>
                <span>Vue3生态系统</span>
              </a>
              <a href="#skill2" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #3178c6 0%, #235a97 100%);">2</span>
                <span>TypeScript开发</span>
              </a>
              <a href="#skill3" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #409eff 0%, #66b1ff 100%);">3</span>
                <span>UI框架与样式</span>
              </a>
              <a href="#skill4" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #f7df1e 0%, #e6c200 100%);">4</span>
                <span>原生JavaScript</span>
              </a>
              <a href="#skill5" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);">5</span>
                <span>多媒体与API</span>
              </a>
              <a href="#skill6" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #646cff 0%, #8f94fb 100%);">6</span>
                <span>构建工具</span>
              </a>
              <a href="#skill7" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #2088ff 0%, #79b8ff 100%);">7</span>
                <span>部署与CI/CD</span>
              </a>
              <a href="#skill8" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #f05032 0%, #ff6b4a 100%);">8</span>
                <span>版本控制</span>
              </a>
            </div>
          </div>

          <!-- 项目下拉菜单 -->
          <div class="nav-dropdown"
               @mouseenter="!isMobile && (showProjectsDropdown = true)"
               @mouseleave="!isMobile && (showProjectsDropdown = false)">
            <a href="#projects" @click.prevent="toggleProjectsDropdown" class="nav-link nav-dropdown-toggle">
              <span>项目</span>
              <svg class="dropdown-arrow" :class="{ 'rotated': showProjectsDropdown }" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="6 9 12 15 18 9"></polyline>
              </svg>
            </a>
            <div class="dropdown-menu" :class="{ 'show': showProjectsDropdown }">
              <a href="#project1" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #ec4899 0%, #f472b6 100%);">1</span>
                <span>AI智能简历助手</span>
              </a>
              <a href="#project2" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);">2</span>
                <span>影视大全网站</span>
              </a>
              <a href="#project3" @click="closeMenu" class="dropdown-item">
                <span class="dropdown-number" style="background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);">3</span>
                <span>个人作品集网站</span>
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
const isMobile = ref(false)

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}

const checkMobile = () => {
  isMobile.value = window.innerWidth <= 768
}

const toggleMenu = () => {
  isMenuOpen.value = !isMenuOpen.value
}

const toggleSkillsDropdown = () => {
  if (isMobile.value) {
    showSkillsDropdown.value = !showSkillsDropdown.value
    showProjectsDropdown.value = false
  } else {
    window.location.href = '#skills'
    closeMenu()
  }
}

const toggleProjectsDropdown = () => {
  if (isMobile.value) {
    showProjectsDropdown.value = !showProjectsDropdown.value
    showSkillsDropdown.value = false
  } else {
    window.location.href = '#projects'
    closeMenu()
  }
}

const closeMenu = () => {
  isMenuOpen.value = false
  showSkillsDropdown.value = false
  showProjectsDropdown.value = false
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  window.addEventListener('resize', checkMobile)
  checkMobile()
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  window.removeEventListener('resize', checkMobile)
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
  transform: none;
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
  .navbar {
    max-width: 100vw;
    overflow-x: hidden;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
  }

  .nav-wrapper {
    padding: 0 16px;
  }

  .menu-toggle {
    display: flex;
    position: relative;
    z-index: 1000;
  }

  .nav-links {
    position: fixed;
    top: 70px;
    left: 0;
    width: 100%;
    height: calc(100vh - 70px);
    max-height: calc(100vh - 70px);
    background: rgba(15, 23, 42, 0.98);
    flex-direction: column;
    padding: 20px;
    padding-bottom: 100px;
    gap: 8px;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.3s ease;
    align-items: stretch;
    z-index: 998;
    backdrop-filter: blur(10px);
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
    display: flex;
    overscroll-behavior: contain;
  }
  
  .nav-links.active {
    opacity: 1;
    pointer-events: auto;
  }
  
  .nav-link {
    padding: 10px 16px;
    font-size: 1rem;
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.03);
  }
  
  .nav-dropdown {
    display: flex;
    flex-direction: column;
    padding-bottom: 0;
    margin-bottom: 0;
  }

  .nav-dropdown::before {
    display: none;
  }

  .dropdown-menu {
    position: static;
    transform: none;
    margin-top: 8px;
    margin-left: 0;
    margin-right: 0;
    background: rgba(255, 255, 255, 0.05);
    box-shadow: none;
    animation: none;
    opacity: 1;
    visibility: visible;
    display: none;
    flex-direction: column;
    gap: 6px;
    width: 100%;
    min-width: unset;
    max-width: 100%;
    padding: 8px;
    border-radius: 8px;
    left: auto;
  }

  .dropdown-menu.show {
    display: flex;
    transform: none;
  }

  .dropdown-item {
    padding: 10px 12px;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    gap: 10px;
    background: rgba(255, 255, 255, 0.08);
    border-radius: 6px;
    width: 100%;
    white-space: normal;
    word-break: break-word;
  }

  .dropdown-number {
    width: 28px;
    height: 28px;
    font-size: 0.85rem;
    flex-shrink: 0;
  }

  .nav-dropdown-toggle {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
  }

  .dropdown-arrow {
    transition: transform 0.3s ease;
    flex-shrink: 0;
    margin-left: 8px;
  }

  .dropdown-arrow.rotated {
    transform: rotate(180deg);
  }
}
</style>
