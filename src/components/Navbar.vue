<template>
  <nav class="navbar" :class="{ 'scrolled': isScrolled, 'hidden': isHidden }">
    <div class="container">
      <div class="nav-wrapper">
        <a href="#" class="logo">
          <span class="logo-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
              <path d="M2 17l10 5 10-5"></path>
              <path d="M2 12l10 5 10-5"></path>
            </svg>
          </span>
          <span class="logo-text">个人作品网站</span>
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
            <div class="dropdown-menu skills-dropdown" :class="{ 'show': showSkillsDropdown }">
              <div class="dropdown-section">
                <div class="dropdown-section-title">业务能力 · AI产品与通用产品</div>
                <a href="#skill-prd" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>PRD撰写</span>
                </a>
                <a href="#skill-prototype" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>原型 / 脑图 / 流程图</span>
                </a>
                <a href="#skill-metrics" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>数据指标体系建设</span>
                </a>
                <a href="#skill-ai-metrics" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>AI产品评估指标体系</span>
                </a>
                <a href="#skill-prompt" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>结构化Prompt工程</span>
                </a>
                <a href="#skill-rag" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>RAG / 微调 / Agent搭建</span>
                </a>
                <a href="#skill-llm-boundary" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>大模型能力边界判断</span>
                </a>
                <a href="#skill-coze" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>Coze工作流 & 知识库</span>
                </a>
                <a href="#skill-requirement" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>用户需求分析与真伪判断</span>
                </a>
                <a href="#skill-competitor" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>竞品分析与功能拆解</span>
                </a>
                <a href="#skill-cost" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>业务目标与成本收益分析</span>
                </a>
                <a href="#skill-info-arch" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>页面优先级与信息层级设计</span>
                </a>
                <a href="#skill-ai-optimize" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>AI产品指标优化闭环</span>
                </a>
                <a href="#skill-lifecycle" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>产品全生命周期落地能力</span>
                </a>
              </div>
              <div class="dropdown-section">
                <div class="dropdown-section-title">技术能力 · 独立交付与工程落地</div>
                <a href="#skill-mvp" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>独立实现MVP（Trae / Cursor）</span>
                </a>
                <a href="#skill-frontend" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>Vue / React / TypeScript</span>
                </a>
                <a href="#skill-html-css" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>HTML / CSS</span>
                </a>
                <a href="#skill-deploy" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>GitHub Pages / Vercel部署</span>
                </a>
                <a href="#skill-api" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>前后端联调与异常沟通</span>
                </a>
                <a href="#skill-apifox" @click="closeMenu" class="dropdown-item">
                  <span class="dropdown-bullet">•</span>
                  <span>Apifox / 接口测试</span>
                </a>
              </div>
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
              <a href="#project1" @click.prevent="openProjectModal('project1')" class="dropdown-item">
                <span class="dropdown-number">1</span>
                <span>AI智能简历助手</span>
              </a>
              <a href="#project2" @click.prevent="openProjectModal('project2')" class="dropdown-item">
                <span class="dropdown-number">2</span>
                <span>影视大全网站</span>
              </a>
              <a href="#project3" @click.prevent="openProjectModal('project3')" class="dropdown-item">
                <span class="dropdown-number">3</span>
                <span>AI面试模拟器+PRD</span>
              </a>
              <a href="#project4" @click.prevent="openProjectModal('project4')" class="dropdown-item">
                <span class="dropdown-number">4</span>
                <span>用户反馈数据看板</span>
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

const emit = defineEmits(['openProject'])

const isScrolled = ref(false)
const isMenuOpen = ref(false)
const showSkillsDropdown = ref(false)
const showProjectsDropdown = ref(false)
const isMobile = ref(false)
const isHidden = ref(true) // 默认隐藏，在首页时隐藏

const handleScroll = () => {
  const scrollY = window.scrollY
  isScrolled.value = scrollY > 50
  
  // 获取 Hero 和 About 元素
  const heroElement = document.querySelector('.hero')
  const aboutElement = document.querySelector('#about')
  
  if (heroElement && aboutElement) {
    const heroHeight = heroElement.offsetHeight
    const aboutTop = aboutElement.getBoundingClientRect().top
    
    // 当 About 区域触碰到视口顶部时显示导航栏
    // 或者滚动超过 Hero 高度时也显示
    if (aboutTop <= 0 || scrollY >= heroHeight - 100) {
      isHidden.value = false
    } else {
      isHidden.value = true
    }
  }
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

const openProjectModal = (projectId) => {
  // 先定位到项目区域
  window.location.href = `#${projectId}`
  // 关闭菜单
  closeMenu()
  // 触发事件通知父组件打开弹窗
  emit('openProject', projectId)
}

// 点击外部关闭菜单
const handleClickOutside = (event) => {
  if (isMobile.value && isMenuOpen.value) {
    const nav = document.querySelector('.navbar')
    if (nav && !nav.contains(event.target)) {
      closeMenu()
    }
  }
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  window.addEventListener('resize', checkMobile)
  document.addEventListener('click', handleClickOutside)
  checkMobile()
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  window.removeEventListener('resize', checkMobile)
  document.removeEventListener('click', handleClickOutside)
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
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  padding: 15px 0;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.navbar.hidden {
  transform: translateY(-100%);
  opacity: 0;
  pointer-events: none;
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
  width: 36px;
  height: 36px;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--text-secondary);
  transition: all 0.3s ease;
}

.logo:hover .logo-icon {
  border-color: var(--primary-color);
  color: var(--primary-color);
}

.logo-text {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--text-primary);
  white-space: nowrap;
}

.logo-text {
  color: var(--text-primary);
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
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid var(--border-color);
  border-radius: 12px;
  padding: 8px;
  min-width: 150px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
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
  background: var(--bg-hover);
  color: var(--text-primary);
}

.dropdown-number {
  width: 28px;
  height: 28px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  color: var(--text-primary);
  font-size: 0.85rem;
  font-weight: 600;
  flex-shrink: 0;
}

/* 技能下拉菜单分组样式 */
.skills-dropdown {
  min-width: 320px;
  max-height: 70vh;
  overflow-y: auto;
  padding: 12px;
}

.dropdown-section {
  margin-bottom: 12px;
}

.dropdown-section:last-child {
  margin-bottom: 0;
}

.dropdown-section-title {
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding: 8px 16px;
  margin-bottom: 4px;
  border-bottom: 1px solid var(--border-color);
}

.dropdown-bullet {
  color: var(--primary-color);
  font-size: 1.2rem;
  line-height: 1;
  margin-right: 4px;
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
    z-index: 1000;
  }

  .nav-wrapper {
    padding: 0 16px;
  }

  .menu-toggle {
    display: flex;
    position: relative;
    z-index: 1002;
  }

  .nav-links {
    position: fixed;
    top: 70px;
    left: 0;
    width: 100%;
    height: calc(100vh - 70px);
    max-height: calc(100vh - 70px);
    background: rgba(255, 255, 255, 0.98);
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
    display: none;
    overscroll-behavior: contain;
  }

  .nav-links.active {
    opacity: 1;
    pointer-events: auto;
    display: flex;
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

  .skills-dropdown {
    min-width: 100%;
    max-height: 60vh;
  }

  .dropdown-section-title {
    font-size: 0.7rem;
    padding: 6px 12px;
  }

  .dropdown-bullet {
    font-size: 1rem;
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
