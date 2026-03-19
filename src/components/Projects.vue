<template>
  <section id="projects" class="section projects">
    <div class="container">
      <h2 class="section-title">项目作品</h2>
      <p class="section-subtitle">AI开发与前端工程项目案例</p>
      
      <div class="projects-list">
        <!-- 项目 1 - AI智能简历助手 -->
        <div id="project1" class="project-item" @click="openModal('project1')">
          <div class="project-header">
            <div class="project-number" style="background: linear-gradient(135deg, #ec4899 0%, #f472b6 100%);">1</div>
            <div class="project-info">
              <h3 class="project-title">AI智能简历助手</h3>
              <p class="project-subtitle">基于Vue3 + TypeScript的智能简历生成与优化平台，支持多模板、AI优化、PDF导出</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 2 - 影视大全网站 -->
        <div id="project2" class="project-item" @click="openModal('project2')">
          <div class="project-header">
            <div class="project-number" style="background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);">2</div>
            <div class="project-info">
              <h3 class="project-title">影视大全网站</h3>
              <p class="project-subtitle">基于原生JS的在线影视资源聚合与播放平台，支持多数据源、HLS播放、CORS代理</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 3 - 个人作品集网站 -->
        <div id="project3" class="project-item" @click="openModal('project3')">
          <div class="project-header">
            <div class="project-number" style="background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);">3</div>
            <div class="project-info">
              <h3 class="project-title">个人作品集网站</h3>
              <p class="project-subtitle">基于Vue3的现代化响应式个人展示平台，展示技能、项目经历和作品</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 弹窗 -->
    <div class="modal-overlay" v-if="activeModal" @click="closeModal">
      <div class="modal-content" @click.stop @wheel.stop @touchmove.stop>
        <button class="modal-close" @click="closeModal">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        
        <div class="modal-header">
          <div class="modal-number" :style="{ background: currentProject?.gradient }">{{ currentProject?.number }}</div>
          <div class="modal-title-wrapper">
            <h3 class="modal-title">{{ currentProject?.title }}</h3>
            <p class="modal-subtitle">{{ currentProject?.subtitle }}</p>
          </div>
        </div>
        
        <div class="modal-body">
          <p class="modal-description">{{ currentProject?.description }}</p>
          
          <div class="modal-section" v-if="currentProject?.features">
            <h4>项目功能</h4>
            <ul>
              <li v-for="(feature, index) in currentProject.features" :key="index">{{ feature }}</li>
            </ul>
          </div>
          
          <div class="modal-meta">
            <div class="meta-item">
              <span class="meta-label">技术栈</span>
              <span class="meta-value">{{ currentProject?.techStack }}</span>
            </div>
            <div class="meta-item">
              <span class="meta-label">项目时间</span>
              <span class="meta-value">{{ currentProject?.duration }}</span>
            </div>
          </div>
          
          <div class="modal-tags">
            <span v-for="(tag, index) in currentProject?.tags" :key="index" class="tag">{{ tag }}</span>
          </div>
          
          <div class="modal-actions" v-if="currentProject?.demoUrl">
            <a :href="currentProject.demoUrl" target="_blank" class="btn btn-primary">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                <polyline points="15 3 21 3 21 9"></polyline>
                <line x1="10" y1="14" x2="21" y2="3"></line>
              </svg>
              在线预览
            </a>
            <a v-if="currentProject?.githubUrl" :href="currentProject.githubUrl" target="_blank" class="btn btn-secondary">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
              </svg>
              GitHub
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const activeModal = ref(null)

const projectsData = {
  project1: {
    number: '1',
    title: 'AI智能简历助手',
    subtitle: '基于Vue3 + TypeScript的智能简历生成与优化平台',
    gradient: 'linear-gradient(135deg, #ec4899 0%, #f472b6 100%)',
    description: '一个功能完善的智能化简历生成平台，集成AI技术帮助用户快速创建专业简历。支持多种精美模板、实时预览、智能JD解析、一键PDF导出等功能，提供从编辑到投递的完整简历制作解决方案。',
    features: [
      '可视化编辑器：支持基本信息、工作经历、教育背景、项目经验等模块编辑',
      '多模板系统：提供经典、现代、创意、极简四种专业简历模板',
      'AI智能优化：集成AI服务自动优化简历内容，提升简历质量',
      '实时预览：编辑内容实时同步预览，所见即所得',
      'JD智能解析：解析职位描述，自动提取关键技能要求并匹配简历',
      'PDF导出：基于html2canvas和jsPDF实现高质量PDF导出',
      '数据持久化：使用Pinia状态管理，本地存储简历数据',
      '响应式设计：基于Element Plus和Tailwind CSS，完美适配多端设备'
    ],
    techStack: 'Vue3, TypeScript, Pinia, Element Plus, Tailwind CSS, html2canvas, jsPDF, Vite',
    duration: '2025.03 - 至今',
    tags: ['Vue3', 'TypeScript', 'AI应用', '简历生成', 'PDF导出'],
    demoUrl: 'https://13892624372.github.io/resume/',
    githubUrl: 'https://github.com/13892624372/resume'
  },
  project2: {
    number: '2',
    title: '影视大全网站',
    subtitle: '基于原生JS的在线影视资源聚合与播放平台',
    gradient: 'linear-gradient(135deg, #06b6d4 0%, #0891b2 100%)',
    description: '一个功能完善的在线影视资源聚合平台，整合多个第三方数据源，提供电影、电视剧、综艺、动漫等海量影视内容的搜索、浏览和播放服务。采用原生JavaScript开发，通过公共CORS代理解决跨域问题，部署于GitHub Pages。',
    features: [
      '多数据源支持：支持配置多个影视数据源，自动切换可用源',
      '智能搜索：支持按名称、类型、年份等多维度搜索影视资源',
      '分类浏览：电影、电视剧、综艺、动漫等分类筛选展示',
      '详情展示：展示影视作品的详细信息、剧情简介、演员阵容',
      '在线播放：集成HLS.js播放器，支持M3U8格式视频在线播放',
      '收藏与历史：本地存储收藏列表和观看历史，方便续看',
      'CORS代理方案：使用公共CORS代理服务解决浏览器跨域限制',
      '响应式设计：完美适配桌面端和移动端，支持深色主题'
    ],
    techStack: 'HTML5, CSS3, JavaScript, HLS.js, GitHub Pages, CORS Proxy',
    duration: '2025.03 - 2025.03',
    tags: ['JavaScript', '影视网站', 'HLS播放', 'CORS代理', 'GitHub部署'],
    demoUrl: 'https://13892624372.github.io/FilmHub/',
    githubUrl: 'https://github.com/13892624372/FilmHub'
  },
  project3: {
    number: '3',
    title: '个人作品集网站',
    subtitle: '基于Vue3的现代化响应式个人展示平台',
    gradient: 'linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%)',
    description: '一个精心设计的个人作品集网站，用于展示个人技能、项目经历和专业能力。采用Vue3 + Vite技术栈构建，具有现代化的UI设计、流畅的动画效果和完美的响应式适配。',
    features: [
      '现代化设计：采用深色主题，配合渐变色和毛玻璃效果',
      '项目展示：卡片式项目展示，支持点击查看详细信息和在线预览',
      '技能展示：分类展示技术能力，支持展开查看详细技能点',
      '响应式布局：完美适配桌面端、平板和移动设备',
      '流畅动画：页面滚动、悬停效果、弹窗动画等交互动画',
      '路由集成：支持URL hash路由，可直接分享特定项目',
      'GitHub集成：项目卡片直接链接到GitHub仓库和在线演示',
      '性能优化：基于Vite构建，快速加载和渲染'
    ],
    techStack: 'Vue3, Vite, JavaScript, CSS3, Responsive Design, GitHub Actions',
    duration: '2025.03 - 至今',
    tags: ['Vue3', '个人网站', '响应式设计', '作品集'],
    demoUrl: 'https://13892624372.github.io/ai-portfolio/',
    githubUrl: 'https://github.com/13892624372/ai-portfolio'
  }
}

const currentProject = computed(() => {
  return activeModal.value ? projectsData[activeModal.value] : null
})

const openModal = (projectId) => {
  activeModal.value = projectId
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  activeModal.value = null
  document.body.style.overflow = ''
}

// 检查URL hash并自动打开对应的弹窗
onMounted(() => {
  const hash = window.location.hash
  if (hash === '#project1' || hash === '#project2' || hash === '#project3') {
    openModal(hash.replace('#', ''))
  }
  
  // 监听hash变化
  window.addEventListener('hashchange', () => {
    const newHash = window.location.hash
    if (newHash === '#project1' || newHash === '#project2' || newHash === '#project3') {
      openModal(newHash.replace('#', ''))
    }
  })
})
</script>

<style scoped>
.projects {
  background: var(--bg-dark);
}

.projects-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
  margin-top: 48px;
}

.project-item {
  background: var(--bg-card);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 24px 32px;
  transition: all 0.3s ease;
  scroll-margin-top: 100px;
  cursor: pointer;
}

.project-item:hover {
  border-color: var(--primary-color);
  box-shadow: 0 10px 40px rgba(99, 102, 241, 0.15);
  transform: translateY(-2px);
}

.project-header {
  display: flex;
  align-items: center;
  gap: 20px;
}

.project-number {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.3rem;
  font-weight: 700;
  flex-shrink: 0;
}

.project-info {
  flex: 1;
}

.project-title {
  font-size: 1.3rem;
  font-weight: 600;
  margin-bottom: 4px;
}

.project-subtitle {
  color: var(--text-muted);
  font-size: 0.9rem;
}

.expand-icon {
  color: var(--text-muted);
  transition: all 0.3s ease;
}

.project-item:hover .expand-icon {
  color: var(--text-primary);
  transform: translateX(5px);
}

/* 弹窗样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(5px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  padding: 20px;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.modal-content {
  background: var(--bg-card);
  border-radius: 24px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  width: 100%;
  max-width: 800px;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  padding: 40px;
  padding-top: 80px;
  animation: slideUp 0.3s ease;
  overscroll-behavior: contain;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.modal-close {
  position: fixed;
  top: calc(5vh + 20px);
  right: calc(50% - 400px + 20px);
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  z-index: 2001;
  backdrop-filter: blur(10px);
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  color: var(--text-primary);
}

.modal-header {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-bottom: 32px;
  padding-bottom: 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-number {
  width: 70px;
  height: 70px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.8rem;
  font-weight: 700;
  flex-shrink: 0;
}

.modal-title {
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 8px;
}

.modal-subtitle {
  color: var(--text-muted);
  font-size: 1.1rem;
}

.modal-body {
  color: var(--text-secondary);
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: 32px;
}

.modal-section {
  margin-bottom: 32px;
}

.modal-section h4 {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.modal-section ul {
  list-style: none;
  padding: 0;
}

.modal-section li {
  padding: 12px 0;
  padding-left: 24px;
  position: relative;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.modal-section li::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 8px;
  height: 8px;
  background: var(--primary-color);
  border-radius: 50%;
}

.modal-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 32px;
  margin-bottom: 32px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 12px;
}

.meta-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.meta-label {
  font-size: 0.85rem;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.meta-value {
  font-size: 1rem;
  color: var(--text-primary);
  font-weight: 500;
}

.modal-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.tag {
  padding: 10px 20px;
  background: rgba(99, 102, 241, 0.1);
  border: 1px solid rgba(99, 102, 241, 0.3);
  border-radius: 20px;
  font-size: 0.9rem;
  color: var(--primary-color);
}

.modal-actions {
  display: flex;
  gap: 16px;
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
  border: none;
}

.btn-primary {
  background: var(--gradient-1);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.1);
  color: var(--text-primary);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-2px);
}

/* 滚动条样式 */
.modal-content::-webkit-scrollbar {
  width: 8px;
}

.modal-content::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 4px;
}

.modal-content::-webkit-scrollbar-thumb {
  background: rgba(99, 102, 241, 0.5);
  border-radius: 4px;
}

.modal-content::-webkit-scrollbar-thumb:hover {
  background: rgba(99, 102, 241, 0.7);
}

@media (max-width: 768px) {
  .projects {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .project-item {
    padding: 16px 20px;
  }
  
  .project-number {
    width: 36px;
    height: 36px;
    font-size: 1rem;
  }
  
  .project-title {
    font-size: 1rem;
  }
  
  .project-subtitle {
    font-size: 0.85rem;
  }
  
  .modal-overlay {
    padding: 0;
    align-items: flex-end;
  }
  
  .modal-content {
    width: 100%;
    max-width: 100%;
    height: 90vh;
    max-height: 90vh;
    margin: 0;
    border-radius: 20px 20px 0 0;
    padding: 60px 20px 20px;
  }
  
  .modal-close {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 36px;
    height: 36px;
  }
  
  .modal-header {
    flex-direction: column;
    text-align: center;
    gap: 12px;
    margin-bottom: 20px;
  }
  
  .modal-number {
    width: 50px;
    height: 50px;
    font-size: 1.3rem;
  }
  
  .modal-title {
    font-size: 1.3rem;
  }
  
  .modal-subtitle {
    font-size: 0.9rem;
  }
  
  .modal-meta {
    flex-direction: column;
    gap: 12px;
  }
  
  .modal-section h3 {
    font-size: 1rem;
  }
  
  .modal-section p,
  .modal-section li {
    font-size: 0.9rem;
  }
  
  .tech-tag {
    font-size: 0.8rem;
    padding: 4px 10px;
  }
}
</style>
