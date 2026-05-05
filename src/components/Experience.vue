<template>
  <section id="experience" class="section experience">
    <div class="container">
      <h2 class="section-title">工作经历</h2>
      <p class="section-subtitle">构建产品思维，探索AI之路</p>
      
      <!-- 工作经历卡片网格 -->
      <div class="experience-grid">
        <div
          v-for="job in experiences"
          :key="job.id"
          class="card-3d-wrapper"
          @mousemove="(e) => handleMouseMove(e, job.id)"
          @mouseenter="(e) => handleMouseEnter(e, job.id)"
          @mouseleave="(e) => handleMouseLeave(e, job.id)"
        >
          <div class="card-3d" :ref="el => cardRefs[job.id] = el">
            <div class="card-inner">
              <div class="card-glare" :ref="el => glareRefs[job.id] = el"></div>
              <div class="card-content">
                <AnimatedProfileCard
                  :title="job.title"
                  :company="job.company"
                  :company-initial="job.companyInitial"
                  :period="job.period"
                  :description="job.description"
                  :achievements="job.achievements"
                  :technologies="job.technologies"
                  :gradient="job.gradient"
                  :accent="job.accent"
                  width="100%"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="education-section">
        <h3 class="education-title">教育背景</h3>
        <div class="education-grid">
          <div
            v-for="(edu, index) in education"
            :key="edu.id"
            class="edu-3d-wrapper"
            @mousemove="(e) => handleEduMouseMove(e, edu.id)"
            @mouseenter="(e) => handleEduMouseEnter(e, edu.id)"
            @mouseleave="(e) => handleEduMouseLeave(e, edu.id)"
          >
            <div class="edu-3d" :ref="el => eduCardRefs[edu.id] = el">
              <div class="edu-inner">
                <div class="education-card"
                  :class="{ 'expanded': expandedEduIndex === index }"
                  @click="toggleEduExpand(index)"
                >
                  <div class="edu-header">
                    <div class="edu-icon">
                      <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 3L1 9l4 2.18v6L12 21l7-3.82v-6l2-1.09V17h2V9L12 3z"/>
                        <path d="M12 12l-7-3.82"/>
                        <path d="M12 12l7-3.82"/>
                        <path d="M12 12v9"/>
                      </svg>
                    </div>
                    <div class="edu-content">
                      <h4 class="edu-degree">{{ edu.degree }}</h4>
                      <p class="edu-school">{{ edu.school }}</p>
                      <p class="edu-major">{{ edu.major }}</p>
                      <span class="edu-year">{{ edu.year }}</span>
                    </div>
                    <div class="edu-arrow">
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" :class="{ 'rotated': expandedEduIndex === index }">
                        <polyline points="6 9 12 15 18 9"></polyline>
                      </svg>
                    </div>
                  </div>
                  
                  <div class="edu-expand" :class="{ 'show': expandedEduIndex === index }">
                    <div class="edu-expand-content">
                      <div class="edu-details">
                        <h5 class="details-title">学习经历</h5>
                        <ul class="details-list">
                          <li v-for="detail in edu.details" :key="detail">{{ detail }}</li>
                        </ul>
                      </div>
                      <div class="edu-campus">
                        <h5 class="details-title">校园经历</h5>
                        <ul class="details-list">
                          <li v-for="item in edu.campus" :key="item">{{ item }}</li>
                        </ul>
                      </div>
                      <div class="edu-courses">
                        <h5 class="details-title">主修课程</h5>
                        <div class="course-tags">
                          <span v-for="course in edu.courses" :key="course" class="course-tag">{{ course }}</span>
                        </div>
                      </div>
                      <div class="edu-achievements">
                        <h5 class="details-title">在校成就</h5>
                        <ul class="details-list">
                          <li v-for="achievement in edu.achievements" :key="achievement">{{ achievement }}</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, reactive } from 'vue'
import AnimatedProfileCard from './AnimatedProfileCard.vue'

const expandedEduIndex = ref(null)

const cardRefs = reactive({})
const glareRefs = reactive({})
const isInsideCard = reactive({})

const eduCardRefs = reactive({})
const isInsideEduCard = reactive({})

const handleMouseMove = (e, id) => {
  const wrapper = e.currentTarget
  const rect = wrapper.getBoundingClientRect()
  const x = e.clientX - rect.left
  const y = e.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const calcX = -(y - centerY) / 25
  const calcY = (x - centerX) / 25
  const percentage = (x / rect.width) * 100
  
  const cardRef = cardRefs[id]
  const glareRef = glareRefs[id]
  
  if (cardRef) {
    cardRef.style.transform = `perspective(1200px) rotateX(${calcX}deg) rotateY(${calcY}deg)`
  }
  if (glareRef) {
    glareRef.style.setProperty('--per', `${percentage}%`)
    glareRef.style.opacity = '1'
  }
}

const handleMouseEnter = (e, id) => {
  isInsideCard[id] = true
}

const handleMouseLeave = (e, id) => {
  isInsideCard[id] = false
  
  setTimeout(() => {
    if (!isInsideCard[id]) {
      const cardRef = cardRefs[id]
      const glareRef = glareRefs[id]
      
      if (cardRef) {
        cardRef.style.transform = 'perspective(1200px) rotateX(0) rotateY(0)'
      }
      if (glareRef) {
        glareRef.style.opacity = '0'
      }
    }
  }, 100)
}

const handleEduMouseMove = (e, id) => {
  const wrapper = e.currentTarget
  const rect = wrapper.getBoundingClientRect()
  const x = e.clientX - rect.left
  const y = e.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const calcX = -(y - centerY) / 50
  const calcY = (x - centerX) / 50
  
  const cardRef = eduCardRefs[id]
  
  if (cardRef) {
    cardRef.style.transform = `perspective(1200px) rotateX(${calcX}deg) rotateY(${calcY}deg)`
  }
}

const handleEduMouseEnter = (e, id) => {
  isInsideEduCard[id] = true
}

const handleEduMouseLeave = (e, id) => {
  isInsideEduCard[id] = false
  
  setTimeout(() => {
    if (!isInsideEduCard[id]) {
      const cardRef = eduCardRefs[id]
      
      if (cardRef) {
        cardRef.style.transform = 'perspective(1200px) rotateX(0) rotateY(0)'
      }
    }
  }, 100)
}

const toggleEduExpand = (index) => {
  expandedEduIndex.value = expandedEduIndex.value === index ? null : index
}

const experiences = [
  {
    id: 1,
    title: '实习产品助理',
    company: '汉中市南郑区森森木业有限公司 | 产品部',
    companyInitial: '森',
    period: '2024.11 - 2025.05',
    location: '汉中',
    gradient: 'linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%)',
    accent: '#d1d5db',
    description: '负责产品需求分析、跨部门协作、成本收益测算、选品上市跟进、数据报表输出、竞品分析、用户反馈管理及产品文档维护等全流程产品工作。',
    achievements: [
      '需求分析：收集并梳理用户与业务需求，输出可执行的产品方案',
      '跨部门对接：协同其他部门，推动需求落地',
      '成本与收益测算：参与产品定价、成本评估与收益预测',
      '选品及上市跟进：参与选品决策，发售后持续监控核心数据指标',
      '数据报表与汇报：定期输出数据报表，向团队汇报产品表现与迭代方向',
      '竞品分析：定期跟踪竞品动态，输出分析报告',
      '用户反馈管理：收集并整理用户反馈，驱动产品优化',
      '文档维护：维护PRD、功能说明等产品文档'
    ],
    technologies: ['需求分析', '跨部门协作', '数据分析', '竞品分析', 'PRD撰写', '用户研究']
  },
  {
    id: 2,
    title: '5G通信数据分析工程师',
    company: '广东南方通信建设有限公司 | 海南项目组',
    companyInitial: '南',
    period: '2025.07 - 2025.12',
    location: '海南',
    gradient: 'linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%)',
    accent: '#d1d5db',
    description: '负责通信测试数据的清洗、整理与结构化处理，分析测试结果识别异常指标，输出评估报告，与前后台团队协作推动项目交付。',
    achievements: [
      '负责通信测试数据的清洗、整理与结构化处理',
      '分析测试结果，识别异常指标与不合格点',
      '根据数据标准输出评估报告，给出合格/不合格结论',
      '与前台测试团队协作，根据数据反馈推动测试方案优化',
      '协同后台团队完成项目整体交付',
      '参与测试路径的规划与设计，提升数据采集效率',
      '负责数据归档、汇总统计，并定期输出数据汇报'
    ],
    technologies: ['数据分析', 'Excel', '5G通信', '报告撰写', '数据清洗', '团队协作']
  },
  {
    id: 3,
    title: '高中课程顾问',
    company: '高途教育科技集团有限公司',
    companyInitial: '高',
    period: '2025.12 - 2026.01',
    location: '西安',
    gradient: 'linear-gradient(135deg, #f9fafb 0%, #f3f4f6 100%)',
    accent: '#d1d5db',
    description: '负责客户的需求分析，精准识别核心痛点，挖掘用户潜在需求，制定个性化方案，通过专业沟通建立客户关系，协调多方信息推动转化，持续优化流程，以结果为导向达成目标。',
    achievements: [
      '负责客户的需求分析，精准识别核心痛点',
      '挖掘用户潜在需求，引导并匹配最合适的课程方案',
      '根据当前情况制定个性化方案，提升匹配度与信任感',
      '通过沟通与深入交流，建立良好的客户关系',
      '协调多方信息，推动从咨询到成交的转化',
      '持续优化流程与服务，提升效率与客户满意度',
      '实现高转化率并达成月目标'
    ],
    technologies: ['需求分析', '用户挖掘', '销售转化', '客户关系', '流程优化', '教育咨询']
  }
]

const education = [
  {
    id: 1,
    degree: '本科',
    school: '西安信息职业大学',
    major: '软件工程技术',
    year: '2021.09 - 2025.07',
    gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)',
    details: [
      '积极利用在线学习平台，拓展自己的知识领域。通过系统的课程学习和互动交流，深入掌握了该领域的专业知识和技能',
      '利用视频会议、在线文档等方式，高效地进行沟通和任务分配。充分发挥自己的专业优势，通过深入调研和分析，提出了创新性的方案',
      '活跃于多个专业社交平台，在这些平台上，积极分享自己的见解和经验，与同行们进行深入的交流和探讨',
      '通过与不同背景的人互动，不断学习新的观点和理念，丰富了自己的知识体系，为未来的职业发展奠定了良好的基础'
    ],
    campus: [
      '参与国旗护卫队，负责周一升旗仪式，协助护旗、升旗等',
      '协助校学生会主讲人策划校内科普宣传活动',
      '加入校足球队并协助训练赛开展',
      '负责校园志愿巡逻，维护学校安全，提高志愿者服务水平和素质',
      '担任班干部，组织多次活动，多次协助老师完成测试和录入信息等'
    ],
    courses: [
       'Python','Java','Web前端开发',
      'MySQL数据库管理及应用','数据结构',
      'Linux操作系统', '树莓派系统设计与应用', '嵌入式系统设计与应用',
      '计算机视觉', '算法设计与分析',
    ],
    achievements: [
      '系统学习软件开发核心技术，包括前端开发、后端开发、数据库设计等',
      '积极参与课程项目和实验，培养扎实的编程能力和问题解决能力',
      '主动学习人工智能相关知识，包括机器学习、深度学习等前沿技术',
      '具备良好的代码规范和团队协作能力'
    ]
  }
]
</script>

<style scoped>
.experience {
  background: var(--bg-dark);
  padding: 80px 0;
}

.experience-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
  margin-bottom: 80px;
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;
}

/* 3D卡片样式 */
.card-3d-wrapper {
  width: 100%;
  height: 100%;
  perspective: 1200px;
}

.card-3d {
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  will-change: transform;
}

.card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 24px;
  overflow: hidden;
}

.card-glare {
  display: none;
}

.card-content {
  position: relative;
  width: 100%;
  height: 100%;
  padding: 0;
}

/* 教育背景3D卡片样式 */
.edu-3d-wrapper {
  width: 100%;
  height: 100%;
  perspective: 1200px;
}

.edu-3d {
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
  will-change: transform;
}

.edu-inner {
  position: relative;
  width: 100%;
  height: 100%;
}

@media (max-width: 1024px) {
  .experience-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .experience-grid {
    grid-template-columns: 1fr;
  }
}

/* 教育背景样式保持不变 */
.education-section {
  margin-top: 60px;
}

.education-title {
  font-size: 1.8rem;
  font-weight: 600;
  text-align: center;
  margin-bottom: 40px;
  color: var(--text-primary);
}

.education-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 24px;
  max-width: 800px;
  margin: 0 auto;
}

.education-card {
  position: relative;
  background: 
    radial-gradient(circle at 20% 30%, rgba(240, 240, 245, 0.6) 0%, transparent 25%),
    radial-gradient(circle at 80% 20%, rgba(235, 235, 240, 0.5) 0%, transparent 20%),
    radial-gradient(circle at 60% 80%, rgba(245, 245, 250, 0.55) 0%, transparent 22%),
    radial-gradient(circle at 30% 70%, rgba(230, 230, 235, 0.45) 0%, transparent 18%),
    #fafafa;
  border-radius: 16px;
  padding: 24px;
  border: 1px solid rgba(200, 200, 210, 0.4);
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.04),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  cursor: pointer;
  transition: all 0.3s ease;
  overflow: hidden;
}

.education-card::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: 
    radial-gradient(circle at 15% 20%, rgba(180, 185, 190, 0.3) 0%, transparent 35%),
    radial-gradient(circle at 85% 75%, rgba(170, 175, 180, 0.25) 0%, transparent 30%),
    radial-gradient(circle at 50% 50%, rgba(160, 165, 170, 0.2) 0%, transparent 40%),
    radial-gradient(circle at 30% 80%, rgba(190, 195, 200, 0.22) 0%, transparent 28%),
    radial-gradient(circle at 70% 25%, rgba(175, 180, 185, 0.28) 0%, transparent 32%);
  animation: inkFloat 12s ease-in-out infinite;
  pointer-events: none;
}

@keyframes inkFloat {
  0%, 100% {
    transform: translate(0, 0) rotate(0deg);
    opacity: 0.7;
  }
  25% {
    transform: translate(8%, 5%) rotate(1.5deg);
    opacity: 1;
  }
  50% {
    transform: translate(-5%, -8%) rotate(-1.5deg);
    opacity: 0.85;
  }
  75% {
    transform: translate(5%, 8%) rotate(1deg);
    opacity: 0.95;
  }
}

.education-card::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 20% 15%, rgba(200, 200, 205, 0.4) 0%, transparent 25%),
    radial-gradient(circle at 80% 85%, rgba(190, 190, 195, 0.35) 0%, transparent 28%),
    radial-gradient(circle at 45% 55%, rgba(210, 210, 215, 0.3) 0%, transparent 32%),
    radial-gradient(circle at 65% 30%, rgba(185, 185, 190, 0.38) 0%, transparent 26%);
  animation: inkDiffuse 18s ease-in-out infinite;
  pointer-events: none;
}

@keyframes inkDiffuse {
  0%, 100% {
    opacity: 0.6;
    transform: scale(1);
  }
  25% {
    opacity: 0.9;
    transform: scale(1.05);
  }
  50% {
    opacity: 0.75;
    transform: scale(1.15);
  }
  75% {
    opacity: 0.95;
    transform: scale(1.08);
  }
}

.education-card:hover {
  background: 
    radial-gradient(circle at 20% 30%, rgba(245, 245, 250, 0.7) 0%, transparent 25%),
    radial-gradient(circle at 80% 20%, rgba(240, 240, 245, 0.6) 0%, transparent 20%),
    radial-gradient(circle at 60% 80%, rgba(250, 250, 255, 0.65) 0%, transparent 22%),
    radial-gradient(circle at 30% 70%, rgba(235, 235, 240, 0.55) 0%, transparent 18%),
    #ffffff;
  box-shadow:
    0 12px 40px rgba(0, 0, 0, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.9);
  transform: translateY(-2px);
}

.education-card:hover::before {
  animation-duration: 10s;
}

.education-card:hover::after {
  animation-duration: 15s;
}

.edu-header {
  display: flex;
  align-items: center;
  gap: 16px;
}

.edu-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #374151;
  background: rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.1);
  flex-shrink: 0;
}

.edu-content {
  flex: 1;
}

.edu-degree {
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 4px;
}

.edu-school {
  font-size: 0.95rem;
  color: var(--text-secondary);
  margin-bottom: 2px;
}

.edu-major {
  font-size: 0.9rem;
  color: var(--text-muted);
  margin-bottom: 4px;
}

.edu-year {
  font-size: 0.85rem;
  color: var(--primary-color);
  font-weight: 500;
}

.edu-arrow {
  color: var(--text-muted);
  transition: transform 0.3s ease;
}

.edu-arrow.rotated {
  transform: rotate(180deg);
}

.edu-expand {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.3s ease;
}

.edu-expand.show {
  max-height: 1000px;
}

.edu-expand-content {
  padding-top: 20px;
  border-top: 1px solid var(--border-color);
  margin-top: 16px;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
}

@media (max-width: 768px) {
  .edu-expand-content {
    grid-template-columns: 1fr;
  }
}

.details-title {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 10px;
}

.details-list {
  list-style: none;
  padding: 0;
}

.details-list li {
  font-size: 0.85rem;
  color: var(--text-secondary);
  line-height: 1.6;
  margin-bottom: 6px;
  padding-left: 16px;
  position: relative;
}

.details-list li::before {
  content: '•';
  position: absolute;
  left: 0;
  color: var(--primary-color);
}

.course-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.course-tag {
  font-size: 0.75rem;
  padding: 4px 10px;
  background: var(--bg-hover);
  border-radius: 12px;
  color: var(--text-secondary);
}
</style>
