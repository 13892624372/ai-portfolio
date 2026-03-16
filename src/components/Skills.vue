<template>
  <section id="skills" class="section skills">
    <div class="container">
      <h2 class="section-title">技术能力</h2>
      <p class="section-subtitle">前端开发与工程化实践技能</p>

      <div class="skills-list">
        <!-- 技能 1 - Vue3生态系统 -->
        <div id="skill1" class="skill-item" @click="openModal('skill1')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #42b883 0%, #35495e 100%);">1</div>
            <div class="skill-info">
              <h3 class="skill-title">Vue3生态系统</h3>
              <p class="skill-subtitle">Composition API + Vue Router + Pinia状态管理</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 2 - TypeScript开发 -->
        <div id="skill2" class="skill-item" @click="openModal('skill2')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #3178c6 0%, #235a97 100%);">2</div>
            <div class="skill-info">
              <h3 class="skill-title">TypeScript开发</h3>
              <p class="skill-subtitle">类型系统 + 接口设计 + 代码规范</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 3 - UI框架与样式 -->
        <div id="skill3" class="skill-item" @click="openModal('skill3')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #409eff 0%, #66b1ff 100%);">3</div>
            <div class="skill-info">
              <h3 class="skill-title">UI框架与样式</h3>
              <p class="skill-subtitle">Element Plus + Tailwind CSS + 响应式设计</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 4 - 原生JavaScript开发 -->
        <div id="skill4" class="skill-item" @click="openModal('skill4')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #f7df1e 0%, #e6c200 100%);">4</div>
            <div class="skill-info">
              <h3 class="skill-title">原生JavaScript开发</h3>
              <p class="skill-subtitle">ES6+ + DOM操作 + 事件处理 + 模块化</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 5 - 多媒体与API集成 -->
        <div id="skill5" class="skill-item" @click="openModal('skill5')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);">5</div>
            <div class="skill-info">
              <h3 class="skill-title">多媒体与API集成</h3>
              <p class="skill-subtitle">HLS.js播放 + 第三方API + CORS代理</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 6 - 构建工具与工程化 -->
        <div id="skill6" class="skill-item" @click="openModal('skill6')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #646cff 0%, #8f94fb 100%);">6</div>
            <div class="skill-info">
              <h3 class="skill-title">构建工具与工程化</h3>
              <p class="skill-subtitle">Vite + 模块化 + 代码优化 + 性能调优</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 7 - 部署与CI/CD -->
        <div id="skill7" class="skill-item" @click="openModal('skill7')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #2088ff 0%, #79b8ff 100%);">7</div>
            <div class="skill-info">
              <h3 class="skill-title">部署与CI/CD</h3>
              <p class="skill-subtitle">GitHub Pages + GitHub Actions + 自动化部署</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>

        <!-- 技能 8 - 版本控制与协作 -->
        <div id="skill8" class="skill-item" @click="openModal('skill8')">
          <div class="skill-header">
            <div class="skill-number" style="background: linear-gradient(135deg, #f05032 0%, #ff6b4a 100%);">8</div>
            <div class="skill-info">
              <h3 class="skill-title">版本控制与协作</h3>
              <p class="skill-subtitle">Git + GitHub + 分支管理 + 代码审查</p>
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
    title: 'Vue3生态系统',
    subtitle: 'Composition API + Vue Router + Pinia状态管理',
    gradient: 'linear-gradient(135deg, #42b883 0%, #35495e 100%)',
    description: '深入掌握Vue3生态系统，在AI简历助手和个人作品集两个项目中全面应用。熟练使用Composition API进行逻辑复用，使用Pinia进行状态管理，使用Vue Router实现路由控制。',
    details: [
      'Composition API：使用setup语法糖，实现逻辑复用和代码组织',
      'Vue Router：配置路由守卫、动态路由、嵌套路由，实现SPA导航',
      'Pinia状态管理：在AI简历助手中管理简历数据，实现跨组件状态共享',
      '组件化开发：封装可复用组件，如简历模板组件、技能展示组件',
      '响应式系统：深入理解ref、reactive、computed等响应式API',
      '生命周期：掌握onMounted、onUnmounted等生命周期钩子的使用'
    ],
    tags: ['Vue3', 'Composition API', 'Vue Router', 'Pinia', '组件化', '响应式']
  },
  skill2: {
    number: '2',
    title: 'TypeScript开发',
    subtitle: '类型系统 + 接口设计 + 代码规范',
    gradient: 'linear-gradient(135deg, #3178c6 0%, #235a97 100%)',
    description: '在AI简历助手项目中全面使用TypeScript，提升代码质量和可维护性。掌握类型定义、接口设计、泛型使用等核心特性。',
    details: [
      '类型定义：为简历数据、组件props、API响应定义严格的类型',
      '接口设计：设计Resume、Education、WorkExperience等数据接口',
      '泛型应用：在工具函数和API请求中使用泛型提高代码复用性',
      '类型推断：利用TS的类型推断能力减少冗余类型声明',
      '代码规范：配置tsconfig.json，启用严格模式，提高代码质量',
      '类型安全：在编译阶段捕获类型错误，减少运行时bug'
    ],
    tags: ['TypeScript', '类型系统', '接口', '泛型', '代码规范', '类型安全']
  },
  skill3: {
    number: '3',
    title: 'UI框架与样式',
    subtitle: 'Element Plus + Tailwind CSS + 响应式设计',
    gradient: 'linear-gradient(135deg, #409eff 0%, #66b1ff 100%)',
    description: '熟练使用Element Plus组件库和Tailwind CSS工具类，快速构建美观的用户界面。掌握响应式设计和深色主题实现。',
    details: [
      'Element Plus：使用Form、Table、Dialog、Upload等组件构建简历编辑器',
      'Tailwind CSS：使用工具类快速实现布局、间距、颜色等样式',
      '响应式设计：使用媒体查询和flexbox/grid实现多端适配',
      '深色主题：配置CSS变量，实现深色/浅色主题切换',
      '自定义样式：覆盖组件默认样式，实现个性化UI效果',
      'CSS动画：使用transition和animation实现流畅的交互动画'
    ],
    tags: ['Element Plus', 'Tailwind CSS', '响应式', '深色主题', 'CSS动画', 'UI设计']
  },
  skill4: {
    number: '4',
    title: '原生JavaScript开发',
    subtitle: 'ES6+ + DOM操作 + 事件处理 + 模块化',
    gradient: 'linear-gradient(135deg, #f7df1e 0%, #e6c200 100%)',
    description: '精通原生JavaScript开发，在影视网站项目中从零构建完整应用。掌握ES6+新特性、DOM操作、事件处理和模块化开发。',
    details: [
      'ES6+语法：使用箭头函数、解构赋值、Promise、async/await等现代语法',
      'DOM操作：动态创建元素、修改属性、处理事件冒泡和捕获',
      '事件处理：实现搜索防抖、滚动监听、点击外部关闭等交互',
      '模块化开发：使用ES Module组织代码，实现关注点分离',
      '路由实现：使用hashchange事件实现前端路由，支持浏览器前进后退',
      '状态管理：使用自定义Store模式管理应用状态，实现数据持久化'
    ],
    tags: ['JavaScript', 'ES6+', 'DOM', '事件处理', '模块化', '前端路由']
  },
  skill5: {
    number: '5',
    title: '多媒体与API集成',
    subtitle: 'HLS.js播放 + 第三方API + CORS代理',
    gradient: 'linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%)',
    description: '在影视网站项目中实现视频播放、数据源对接和跨域处理。掌握HLS流媒体播放、RESTful API集成和CORS代理方案。',
    details: [
      'HLS.js集成：集成HLS.js播放器，支持M3U8格式视频在线播放',
      '视频控制：实现播放、暂停、进度控制、全屏等播放器功能',
      'API对接：对接多个第三方影视数据源，实现数据聚合展示',
      'CORS代理：使用公共CORS代理服务解决浏览器跨域限制',
      '数据缓存：使用LocalStorage缓存收藏列表和观看历史',
      '错误处理：实现API请求失败重试、数据源自动切换等容错机制'
    ],
    tags: ['HLS.js', '视频播放', 'RESTful API', 'CORS', 'LocalStorage', '错误处理']
  },
  skill6: {
    number: '6',
    title: '构建工具与工程化',
    subtitle: 'Vite + 模块化 + 代码优化 + 性能调优',
    gradient: 'linear-gradient(135deg, #646cff 0%, #8f94fb 100%)',
    description: '使用Vite构建三个项目，掌握现代前端工程化实践。配置构建优化、代码分割、资源处理等，提升应用性能。',
    details: [
      'Vite配置：配置vite.config.ts，设置base路径、别名、代理等',
      '构建优化：配置代码分割、资源压缩、Tree Shaking等优化选项',
      '路径处理：处理GitHub Pages子路径部署的资源引用问题',
      '环境变量：使用.env配置不同环境的API地址和参数',
      'TypeScript集成：配置tsconfig.json，实现类型检查和编译',
      '开发体验：利用Vite的HMR热更新，提升开发效率'
    ],
    tags: ['Vite', '工程化', '构建优化', '代码分割', 'Tree Shaking', 'HMR']
  },
  skill7: {
    number: '7',
    title: '部署与CI/CD',
    subtitle: 'GitHub Pages + GitHub Actions + 自动化部署',
    gradient: 'linear-gradient(135deg, #2088ff 0%, #79b8ff 100%)',
    description: '掌握项目部署和持续集成流程，成功将三个项目部署到GitHub Pages。配置GitHub Actions实现自动化构建和部署。',
    details: [
      'GitHub Pages：配置静态网站托管，绑定自定义域名（可选）',
      'GitHub Actions：编写workflow文件，实现push触发自动部署',
      '工作流配置：配置checkout、setup-node、build、deploy等步骤',
      '权限管理：配置GITHUB_TOKEN权限，确保部署流程正常运行',
      '多项目部署：管理多个项目的独立部署流程和配置',
      '迁移经验：将项目从Vercel迁移到GitHub Pages，处理路径和配置差异'
    ],
    tags: ['GitHub Pages', 'GitHub Actions', 'CI/CD', '自动化部署', 'Workflow', 'DevOps']
  },
  skill8: {
    number: '8',
    title: '版本控制与协作',
    subtitle: 'Git + GitHub + 分支管理 + 代码审查',
    gradient: 'linear-gradient(135deg, #f05032 0%, #ff6b4a 100%)',
    description: '熟练使用Git进行版本控制，掌握分支管理、代码合并、冲突解决等协作技能。使用GitHub进行代码托管和项目管理。',
    details: [
      'Git基础：掌握add、commit、push、pull、fetch等常用命令',
      '分支管理：使用feature分支开发，master/main分支发布',
      '代码合并：使用merge和rebase整合代码，处理合并冲突',
      '版本回退：使用reset和revert回退错误提交，保持历史清晰',
      'GitHub协作：使用Pull Request进行代码审查，Issues跟踪问题',
      'GitHub Desktop：使用图形化工具简化日常Git操作'
    ],
    tags: ['Git', 'GitHub', '分支管理', '代码合并', '版本控制', '协作开发']
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
  const validSkills = ['#skill1', '#skill2', '#skill3', '#skill4', '#skill5', '#skill6', '#skill7', '#skill8']
  if (validSkills.includes(hash)) {
    openModal(hash.replace('#', ''))
  }

  // 监听hash变化
  window.addEventListener('hashchange', () => {
    const newHash = window.location.hash
    if (validSkills.includes(newHash)) {
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
