<template>
  <section id="projects" class="section projects">
    <div class="container">
      <h2 class="section-title">项目作品</h2>
      <p class="section-subtitle">AI开发与嵌入式系统项目案例</p>
      
      <div class="projects-list">
        <!-- 项目 1 -->
        <div id="project1" class="project-item" @click="openModal('project1')">
          <div class="project-header">
            <div class="project-number" style="background: linear-gradient(135deg, #ec4899 0%, #f472b6 100%);">1</div>
            <div class="project-info">
              <h3 class="project-title">项目 1</h3>
              <p class="project-subtitle">项目简介描述</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 2 -->
        <div id="project2" class="project-item" @click="openModal('project2')">
          <div class="project-header">
            <div class="project-number" style="background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);">2</div>
            <div class="project-info">
              <h3 class="project-title">项目 2</h3>
              <p class="project-subtitle">项目简介描述</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 3 -->
        <div id="project3" class="project-item" @click="openModal('project3')">
          <div class="project-header">
            <div class="project-number" style="background: linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%);">3</div>
            <div class="project-info">
              <h3 class="project-title">项目 3</h3>
              <p class="project-subtitle">项目简介描述</p>
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
      <div class="modal-content" @click.stop>
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
    title: '个人网站项目',
    subtitle: '基于Vue3的响应式个人作品集网站',
    gradient: 'linear-gradient(135deg, #ec4899 0%, #f472b6 100%)',
    description: '这是一个使用Vue3 + Vite构建的现代化个人网站项目，展示个人技能、工作经历和项目作品。网站采用深色主题设计，具有响应式布局和流畅的动画效果。',
    features: [
      '首页展示：个人简介、职位定位和核心优势',
      '关于页面：教育背景、个人照片和职业目标',
      '技能展示：技术能力分类展示，支持弹窗查看详情',
      '项目作品：项目案例展示，点击可查看完整项目信息',
      '工作经历：时间线形式展示职业发展历程',
      '联系方式：邮箱、电话、地址等联系信息',
      '响应式设计：适配桌面端和移动端设备',
      '流畅动画：页面滚动、悬停、弹窗等交互动画'
    ],
    techStack: 'Vue3, Vite, CSS3, JavaScript, Responsive Design',
    duration: '2025.03 - 至今',
    tags: ['Vue3', '前端开发', '响应式设计', '个人作品']
  },
  project2: {
    number: '2',
    title: '影视大全网站',
    subtitle: '在线影视资源聚合平台',
    gradient: 'linear-gradient(135deg, #06b6d4 0%, #0891b2 100%)',
    description: '一个功能完善的在线影视资源聚合平台，提供电影、电视剧、综艺等多种类型的影视内容搜索和播放服务。采用现代化的前端技术栈，具有响应式设计和流畅的用户体验。',
    features: [
      '影视搜索：支持按名称、类型、年份等多维度搜索影视资源',
      '分类浏览：电影、电视剧、综艺、动漫等分类展示',
      '详情页面：展示影视作品的详细信息、剧情简介、演员阵容',
      '播放功能：集成视频播放器，支持在线观看',
      '收藏功能：用户可以收藏喜欢的影视作品',
      '历史记录：记录用户的观看历史，方便续看',
      '响应式设计：适配桌面端和移动端设备',
      '深色模式：支持亮色/深色主题切换'
    ],
    techStack: 'HTML5, CSS3, JavaScript, Vue3, Video Player API',
    duration: '2025.03 - 2025.03',
    tags: ['Vue3', '影视网站', '响应式设计', '视频播放']
  },
  project3: {
    number: '3',
    title: '项目 3',
    subtitle: '项目简介描述',
    gradient: 'linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%)',
    description: '这里是项目3的详细描述。您可以在此处添加关于该项目的详细介绍，包括项目背景、技术栈、实现功能、项目成果等信息。',
    features: [
      '核心功能1：描述项目的主要功能模块',
      '核心功能2：描述技术实现方案',
      '核心功能3：描述项目亮点和创新点',
      '核心功能4：描述项目成果和收益'
    ],
    techStack: '技术1, 技术2, 技术3, 技术4',
    duration: '2024.06 - 2024.11',
    tags: ['标签1', '标签2', '标签3', '标签4']
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
  background: rgba(30, 41, 59, 0.9);
  border: 1px solid rgba(255, 255, 255, 0.1);
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
