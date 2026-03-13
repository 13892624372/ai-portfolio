<template>
  <section id="skills" class="section skills">
    <div class="container">
      <h2 class="section-title">技术能力</h2>
      <p class="section-subtitle">AI开发与通信技术专业技能</p>
      
      <div class="skills-list">
        <!-- 技能 1 -->
        <div id="skill1" class="skill-item" @click="openModal('skill1')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);">1</div>
            <div class="skill-info">
              <h3 class="skill-title">技能 1</h3>
              <p class="skill-subtitle">核心能力描述</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 技能 2 -->
        <div id="skill2" class="skill-item" @click="openModal('skill2')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #10b981 0%, #34d399 100%);">2</div>
            <div class="skill-info">
              <h3 class="skill-title">技能 2</h3>
              <p class="skill-subtitle">核心能力描述</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 技能 3 -->
        <div id="skill3" class="skill-item" @click="openModal('skill3')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);">3</div>
            <div class="skill-info">
              <h3 class="skill-title">技能 3</h3>
              <p class="skill-subtitle">核心能力描述</p>
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
    title: '技能 1',
    subtitle: '核心能力描述',
    gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)',
    description: '这里是技能1的详细描述。您可以在此处添加关于该技能的详细介绍，包括技术栈、应用场景、掌握程度等信息。',
    details: [
      '详细说明点1：描述该技能的具体应用场景',
      '详细说明点2：描述掌握程度和实际经验',
      '详细说明点3：描述相关的项目经历',
      '详细说明点4：描述学习路径和成长历程'
    ],
    tags: ['标签1', '标签2', '标签3', '标签4']
  },
  skill2: {
    number: '2',
    title: '技能 2',
    subtitle: '核心能力描述',
    gradient: 'linear-gradient(135deg, #10b981 0%, #34d399 100%)',
    description: '这里是技能2的详细描述。您可以在此处添加关于该技能的详细介绍，包括技术栈、应用场景、掌握程度等信息。',
    details: [
      '详细说明点1：描述该技能的具体应用场景',
      '详细说明点2：描述掌握程度和实际经验',
      '详细说明点3：描述相关的项目经历',
      '详细说明点4：描述学习路径和成长历程'
    ],
    tags: ['标签1', '标签2', '标签3', '标签4']
  },
  skill3: {
    number: '3',
    title: '技能 3',
    subtitle: '核心能力描述',
    gradient: 'linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%)',
    description: '这里是技能3的详细描述。您可以在此处添加关于该技能的详细介绍，包括技术栈、应用场景、掌握程度等信息。',
    details: [
      '详细说明点1：描述该技能的具体应用场景',
      '详细说明点2：描述掌握程度和实际经验',
      '详细说明点3：描述相关的项目经历',
      '详细说明点4：描述学习路径和成长历程'
    ],
    tags: ['标签1', '标签2', '标签3', '标签4']
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
