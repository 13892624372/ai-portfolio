<template>
  <section id="experience" class="section experience">
    <div class="container">
      <h2 class="section-title">工作经历</h2>
      <p class="section-subtitle">从运营到通信，探索AI产品之路</p>
      
      <div class="timeline-wrapper">
        <div class="timeline-line"></div>
        <div class="timeline-container">
          <div 
            v-for="(job, index) in experiences" 
            :key="job.id"
            class="timeline-item"
            :class="{ 'active': activeIndex === index }"
            @mouseenter="activeIndex = index"
            @mouseleave="activeIndex = null"
          >
            <div class="timeline-dot" :style="{ background: job.gradient }"></div>
            
            <div class="timeline-card">
              <div class="card-compact">
                <div class="company-logo" :style="{ background: job.gradient }">
                  <span>{{ job.companyInitial }}</span>
                </div>
                <div class="compact-info">
                  <h3 class="job-title">{{ job.title }}</h3>
                  <p class="company-name">{{ job.company }}</p>
                  <span class="job-period">{{ job.period }}</span>
                </div>
              </div>
              
              <div class="card-expand" :class="{ 'show': activeIndex === index }">
                <div class="expand-content">
                  <div class="job-meta">
                    <span class="job-location">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                        <circle cx="12" cy="10" r="3"/>
                      </svg>
                      {{ job.location }}
                    </span>
                  </div>
                  
                  <p class="job-description">{{ job.description }}</p>
                  
                  <div class="job-achievements">
                    <h4>主要成就</h4>
                    <ul>
                      <li v-for="achievement in job.achievements" :key="achievement">
                        {{ achievement }}
                      </li>
                    </ul>
                  </div>
                  
                  <div class="job-techs">
                    <span v-for="tech in job.technologies" :key="tech" class="tech-badge">
                      {{ tech }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="education-section">
        <h3 class="education-title">教育背景</h3>
        <div class="education-grid">
          <div v-for="edu in education" :key="edu.id" class="education-card">
            <div class="edu-icon" :style="{ background: edu.gradient }">
              <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M22 10v6M2 10l10-5 10 5-10 5z"/>
                <path d="M6 12v5c3 3 9 3 12 0v-5"/>
              </svg>
            </div>
            <div class="edu-content">
              <h4 class="edu-degree">{{ edu.degree }}</h4>
              <p class="edu-school">{{ edu.school }}</p>
              <p class="edu-major">{{ edu.major }}</p>
              <span class="edu-year">{{ edu.year }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const activeIndex = ref(null)

const experiences = [
  {
    id: 1,
    title: '运营专员',
    company: '汉中市南郑区森森木业有限公司 | 运营部',
    companyInitial: '森',
    period: '2024.11 - 2025.05',
    location: '汉中',
    gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)',
    description: '主要负责公司线上平台的运营和维护，数据的收集及整理，设计和开发数据库表结构，进行数据库查询、插入、更新和删除等。将开发完成的系统程序部署到生产环境中，监测系统运行状态，及时处理系统故障和异常情况。',
    achievements: [
      '完成线上平台运营维护，保障系统稳定运行',
      '设计并开发数据库表结构，优化数据管理流程',
      '实现系统程序部署，提升运维效率',
      '及时处理系统故障，确保业务连续性'
    ],
    technologies: ['数据库设计', '系统运维', '数据管理', '平台运营']
  },
  {
    id: 2,
    title: '5G通信工程师',
    company: '广东南方通信建设有限公司 | 海南项目组',
    companyInitial: '南',
    period: '2025.07 - 2025.12',
    location: '海南',
    gradient: 'linear-gradient(135deg, #10b981 0%, #34d399 100%)',
    description: '华为5G通信工程师，通信行业GC后台，主要负责Excel表格中制作并处理大量数据工参、出报告、并对指标进行审核，以及规划路线和更改路线等工作，出色完成与前后台其他人员地对接工作。',
    achievements: [
      '高效处理大量数据工参，保证数据准确性',
      '完成报告制作与指标审核，提升工作效率',
      '参与路线规划与优化，支持项目实施',
      '与前后台团队紧密协作，确保项目顺利推进'
    ],
    technologies: ['Excel', '数据处理', '5G通信', '报告制作', '团队协作']
  },
  {
    id: 3,
    title: '高中课程顾问',
    company: '高途教育科技集团有限公司',
    companyInitial: '高',
    period: '2025.12 - 2026.01',
    location: '西安',
    gradient: 'linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%)',
    description: '担任高中课程顾问，负责为学生和家长提供专业的课程咨询服务，根据学生的学习情况和需求制定个性化的学习方案，通过精准的需求分析和专业的服务，实现高转化率，达成销售目标。',
    achievements: [
      '实现高转化率， consistently 达成月度销售目标',
      '精准分析学生需求，制定个性化学习方案',
      '建立良好的客户关系，获得高客户满意度',
      '持续优化咨询流程，提升服务效率'
    ],
    technologies: ['客户沟通', '需求分析', '销售转化', '教育咨询', '客户关系管理']
  }
]

const education = [
  {
    id: 1,
    degree: '本科',
    school: '西安信息职业大学',
    major: '软件工程技术',
    year: '2021.09 - 2025.07',
    gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)'
  }
]
</script>

<style scoped>
.experience {
  background: var(--bg-dark);
}

.timeline-wrapper {
  position: relative;
  margin-bottom: 80px;
  padding: 40px 0;
}

.timeline-line {
  position: absolute;
  top: 80px;
  left: 50%;
  transform: translateX(-50%);
  width: 80%;
  height: 3px;
  background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
  border-radius: 3px;
}

.timeline-container {
  display: flex;
  justify-content: center;
  gap: 60px;
  position: relative;
  z-index: 1;
}

.timeline-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  width: 280px;
}

.timeline-dot {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  border: 4px solid var(--bg-dark);
  box-shadow: 0 0 0 3px var(--primary-color);
  margin-bottom: 20px;
  transition: all 0.3s ease;
}

.timeline-item:hover .timeline-dot {
  transform: scale(1.3);
  box-shadow: 0 0 0 4px var(--primary-color), 0 0 20px rgba(99, 102, 241, 0.5);
}

.timeline-card {
  background: var(--bg-card);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  overflow: hidden;
  transition: all 0.3s ease;
  width: 100%;
}

.timeline-item:hover .timeline-card {
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.card-compact {
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 14px;
}

.company-logo {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 1rem;
  flex-shrink: 0;
}

.compact-info {
  flex: 1;
  min-width: 0;
}

.job-title {
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 2px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.company-name {
  color: var(--text-secondary);
  font-size: 0.85rem;
  margin-bottom: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.job-period {
  font-size: 0.75rem;
  color: var(--text-muted);
}

.card-expand {
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.4s ease, opacity 0.3s ease;
  opacity: 0;
}

.card-expand.show {
  max-height: 500px;
  opacity: 1;
}

.expand-content {
  padding: 0 20px 20px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 16px;
}

.job-meta {
  margin-bottom: 12px;
}

.job-location {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.85rem;
  color: var(--text-muted);
}

.job-description {
  color: var(--text-secondary);
  line-height: 1.6;
  margin-bottom: 16px;
  font-size: 0.85rem;
}

.job-achievements {
  margin-bottom: 16px;
}

.job-achievements h4 {
  font-size: 0.85rem;
  font-weight: 600;
  margin-bottom: 8px;
  color: var(--text-primary);
}

.job-achievements ul {
  list-style: none;
  padding: 0;
}

.job-achievements li {
  position: relative;
  padding-left: 14px;
  margin-bottom: 4px;
  color: var(--text-secondary);
  font-size: 0.8rem;
  line-height: 1.4;
}

.job-achievements li::before {
  content: '';
  position: absolute;
  left: 0;
  top: 5px;
  width: 4px;
  height: 4px;
  background: var(--primary-color);
  border-radius: 50%;
}

.job-techs {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.tech-badge {
  padding: 4px 10px;
  background: rgba(99, 102, 241, 0.15);
  color: var(--primary-color);
  border-radius: 16px;
  font-size: 0.75rem;
  font-weight: 500;
}

.education-section {
  margin-bottom: 60px;
}

.education-title {
  text-align: center;
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 32px;
}

.education-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
}

.education-card {
  display: flex;
  align-items: flex-start;
  gap: 20px;
  background: var(--bg-card);
  padding: 24px;
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.edu-icon {
  width: 56px;
  height: 56px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  flex-shrink: 0;
}

.edu-degree {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 4px;
}

.edu-school {
  color: var(--text-secondary);
  font-size: 0.95rem;
  margin-bottom: 2px;
}

.edu-major {
  color: var(--text-muted);
  font-size: 0.85rem;
  margin-bottom: 8px;
}

.edu-year {
  font-size: 0.8rem;
  color: var(--primary-color);
  font-weight: 500;
}

@media (max-width: 768px) {
  .timeline-line {
    display: none;
  }
  
  .timeline-container {
    flex-direction: column;
    align-items: center;
    gap: 20px;
  }
  
  .timeline-item {
    width: 100%;
    max-width: 100%;
  }
  
  .timeline-card {
    width: 100%;
  }
  
  .card-compact {
    padding: 16px;
  }
  
  .company-logo {
    width: 40px;
    height: 40px;
    font-size: 0.9rem;
  }
  
  .job-title {
    font-size: 0.95rem;
  }
  
  .company-name {
    font-size: 0.8rem;
  }
  
  .job-period {
    font-size: 0.7rem;
  }
  
  .expand-content {
    padding: 0 16px 16px;
  }
  
  .job-description {
    font-size: 0.9rem;
  }
  
  .job-achievements h4 {
    font-size: 0.9rem;
  }
  
  .job-achievements li {
    font-size: 0.85rem;
  }
  
  .tech-badge {
    font-size: 0.75rem;
    padding: 4px 10px;
  }
  
  .education-grid {
    grid-template-columns: 1fr;
  }
  
  .education-card {
    padding: 20px;
  }
}
</style>
