<template>
  <section id="skills" class="section skills">
    <div class="container">
      <h2 class="section-title">技术能力</h2>
      <p class="section-subtitle">AI开发与通信技术专业技能</p>
      
      <div class="skills-list">
        <!-- 技能 1 - 前端开发 -->
        <div id="skill1" class="skill-item" @click="openModal('skill1')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);">1</div>
            <div class="skill-info">
              <h3 class="skill-title">前端开发</h3>
              <p class="skill-subtitle">Vue3 + TypeScript + 现代化前端工程化</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 技能 2 - 原生JavaScript与多媒体开发 -->
        <div id="skill2" class="skill-item" @click="openModal('skill2')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #10b981 0%, #34d399 100%);">2</div>
            <div class="skill-info">
              <h3 class="skill-title">原生JavaScript与多媒体开发</h3>
              <p class="skill-subtitle">原生JS + HLS播放 + API集成</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 技能 3 - 部署与DevOps -->
        <div id="skill3" class="skill-item" @click="openModal('skill3')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);">3</div>
            <div class="skill-info">
              <h3 class="skill-title">部署与DevOps</h3>
              <p class="skill-subtitle">GitHub Pages + GitHub Actions + CI/CD</p>
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
          <div class="modal-number" :style="{ background: currentSkill?.gradient }">{{ currentSkill?.number }}</div>
          <div class="modal-title-wrapper">
            <h3 class="modal-title">{{ currentSkill?.title }}</h3>
            <p class="modal-subtitle">{{ currentSkill?.subtitle }}</p>
          </div>
        </div>
        
        <div class="modal-body">
          <p class="modal-description">{{ currentSkill?.description }}</p>
          
          <div class="modal-section" v-if="currentSkill?.details">
            <h4>详细说明</h4>
            <ul>
              <li v-for="(detail, index) in currentSkill.details" :key="index">{{ detail }}</li>
            </ul>
          </div>
          
          <div class="modal-tags">
            <span v-for="(tag, index) in currentSkill?.tags" :key="index" class="tag">{{ tag }}</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

const activeModal = ref(null)

const skillsData = {
  skill1: {
    number: '1',
    title: '前端开发',
    subtitle: 'Vue3 + TypeScript + 现代化前端工程化',
    gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)',
    description: '熟练掌握现代前端技术栈，能够独立开发复杂的单页应用。在AI简历助手和个人作品集项目中深入实践了Vue3生态系统，具备完整的前端工程化能力。',
    details: [
      'Vue3生态系统：熟练使用Composition API、Vue Router、Pinia状态管理，开发AI简历助手和个人作品集网站',
      'TypeScript：在AI简历助手项目中全面使用TS，提升代码质量和可维护性',
      'UI框架：掌握Element Plus组件库，快速构建美观的用户界面',
      '样式技术：熟练使用Tailwind CSS、CSS3、响应式设计，实现现代化UI效果',
      '构建工具：使用Vite进行项目构建，优化开发体验和打包性能',
      'PDF生成：集成html2canvas和jsPDF实现简历PDF导出功能'
    ],
    tags: ['Vue3', 'TypeScript', 'Pinia', 'Element Plus', 'Tailwind CSS', 'Vite']
  },
  skill2: {
    number: '2',
    title: '原生JavaScript与多媒体开发',
    subtitle: '原生JS + HLS播放 + API集成',
    gradient: 'linear-gradient(135deg, #10b981 0%, #34d399 100%)',
    description: '精通原生JavaScript开发，能够处理复杂的DOM操作和多媒体播放需求。在影视网站项目中实现了视频播放、数据源切换、跨域代理等功能。',
    details: [
      '原生JavaScript：开发影视大全网站，实现路由管理、状态管理、事件处理等核心功能',
      'HLS视频播放：集成HLS.js播放器，支持M3U8格式视频的在线播放',
      'API集成：对接多个第三方影视数据源，实现数据聚合和智能切换',
      '跨域处理：使用公共CORS代理解决浏览器跨域限制，确保数据正常获取',
      '本地存储：实现收藏列表和观看历史的本地存储功能',
      '响应式设计：完美适配桌面端和移动端，支持深色主题切换'
    ],
    tags: ['JavaScript', 'HLS.js', 'CORS代理', 'LocalStorage', '响应式设计']
  },
  skill3: {
    number: '3',
    title: '部署与DevOps',
    subtitle: 'GitHub Pages + GitHub Actions + CI/CD',
    gradient: 'linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%)',
    description: '掌握项目部署和持续集成流程，能够将项目部署到多个平台。成功将三个项目从Vercel迁移到GitHub Pages，并配置自动化部署工作流。',
    details: [
      'GitHub Pages：将三个项目成功部署到GitHub Pages，实现静态网站托管',
      'GitHub Actions：配置自动化部署工作流，实现代码推送后自动构建和部署',
      'Vercel部署：熟悉Vercel平台部署，了解Serverless Functions的使用',
      '构建优化：配置Vite构建参数，处理资源路径和base路径配置',
      '版本控制：熟练使用Git进行版本管理，掌握分支管理和代码合并',
      '项目迁移：成功将项目从Vercel迁移到GitHub Pages，更新所有相关配置'
    ],
    tags: ['GitHub Pages', 'GitHub Actions', 'CI/CD', 'Vercel', 'Git', 'Vite构建']
  }
}

const currentSkill = computed(() => {
  return activeModal.value ? skillsData[activeModal.value] : null
})

const openModal = (skillId) => {
  activeModal.value = skillId
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  activeModal.value = null
  document.body.style.overflow = ''
}

// 检查URL hash并自动打开对应的弹窗
onMounted(() => {
  const hash = window.location.hash
  if (hash === '#skill1' || hash === '#skill2' || hash === '#skill3') {
    openModal(hash.replace('#', ''))
  }
  
  // 监听hash变化
  window.addEventListener('hashchange', () => {
    const newHash = window.location.hash
    if (newHash === '#skill1' || newHash === '#skill2' || newHash === '#skill3') {
      openModal(newHash.replace('#', ''))
    }
  })
})
</script>

<style scoped>
.skills {
  background: var(--bg-dark);
}

.skills-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
  margin-top: 48px;
}

.skill-item {
  background: var(--bg-card);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 24px 32px;
  transition: all 0.3s ease;
  scroll-margin-top: 100px;
  cursor: pointer;
}

.skill-item:hover {
  border-color: var(--primary-color);
  box-shadow: 0 10px 40px rgba(99, 102, 241, 0.15);
  transform: translateY(-2px);
}

.skill-header {
  display: flex;
  align-items: center;
  gap: 20px;
}

.skill-number {
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

.skill-info {
  flex: 1;
}

.skill-title {
  font-size: 1.3rem;
  font-weight: 600;
  margin-bottom: 4px;
}

.skill-subtitle {
  color: var(--text-muted);
  font-size: 0.9rem;
}

.expand-icon {
  color: var(--text-muted);
  transition: all 0.3s ease;
}

.skill-item:hover .expand-icon {
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
  .skills {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .skill-item {
    padding: 16px 20px;
  }
  
  .skill-number {
    width: 36px;
    height: 36px;
    font-size: 1rem;
  }
  
  .skill-title {
    font-size: 1rem;
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
