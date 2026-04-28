<template>
  <section id="skills" class="section skills">
    <div class="container">
      <h2 class="section-title">技术能力</h2>
      <p class="section-subtitle">产品思维与技术落地的双重能力</p>

      <div class="skills-grid">
        <!-- 左列：业务技能 -->
        <div class="skills-column">
          <h3 class="column-title">业务能力 · AI产品与通用产品</h3>
          <div class="skills-list">
            <div 
              v-for="(skill, index) in businessSkills" 
              :key="index"
              :id="skill.id"
              class="skill-card"
            >
              <div class="skill-main">
                <span class="skill-bullet"></span>
                <span class="skill-text">{{ skill.name }}</span>
              </div>
              <p class="skill-desc">{{ skill.description }}</p>
            </div>
          </div>
        </div>

        <!-- 右列：技术技能 -->
        <div class="skills-column">
          <h3 class="column-title">技术能力 · 独立交付与工程落地</h3>
          <div class="skills-list">
            <div 
              v-for="(skill, index) in techSkills" 
              :key="index"
              :id="skill.id"
              class="skill-card"
            >
              <div class="skill-main">
                <span class="skill-bullet"></span>
                <span class="skill-text">{{ skill.name }}</span>
              </div>
              <p class="skill-desc">{{ skill.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>


  </section>
</template>

<script setup>
const businessSkills = [
  { 
    id: 'skill-prd',
    name: 'PRD撰写',
    description: '能输出逻辑清晰、边界明确、可交付开发的PRD'
  },
  { 
    id: 'skill-prototype',
    name: '原型 / 脑图 / 流程图',
    description: '能快速完成产品结构、流程、界面的可视化表达（Axure、Xmind、ProcessOn）'
  },
  { 
    id: 'skill-metrics',
    name: '数据指标体系建设',
    description: '能围绕拉新、活跃、留存、转化构建产品数据闭环'
  },
  { 
    id: 'skill-ai-metrics',
    name: 'AI产品评估指标体系',
    description: '掌握准确率、精确率、召回率、幻觉率、对齐度等模型与业务指标'
  },
  { 
    id: 'skill-prompt',
    name: '结构化Prompt工程',
    description: '能输出稳定、可控的结构化Prompt，直接提升AI功能质量'
  },
  { 
    id: 'skill-rag',
    name: 'RAG / 微调 / 幻觉控制 / Agent搭建',
    description: '能区分RAG与微调适用场景，优先低成本可落地方案，并具备Agent搭建能力'
  },
  { 
    id: 'skill-llm-boundary',
    name: '大模型能力边界判断',
    description: '能判断什么时候用大模型、什么时候不用，避免无效投入'
  },
  { 
    id: 'skill-coze',
    name: 'Coze工作流 & 知识库搭建',
    description: '能基于Coze快速搭建智能体工作流与知识库，验证AI产品形态'
  },
  { 
    id: 'skill-requirement',
    name: '用户需求分析与真伪判断',
    description: '能从场景、痛点、收益三维度判断需求真伪，避免做无效功能'
  },
  { 
    id: 'skill-competitor',
    name: '竞品分析与功能拆解',
    description: '能通过竞品分析快速拆解功能逻辑，转化为产品方案'
  },
  { 
    id: 'skill-cost',
    name: '业务目标与成本收益分析',
    description: '能平衡商业目标与技术成本，避免为做AI而做AI'
  },
  { 
    id: 'skill-info-arch',
    name: '页面优先级与信息层级设计',
    description: '能根据用户核心任务设计信息权重，提升功能可发现性'
  },
  { 
    id: 'skill-ai-optimize',
    name: 'AI产品指标优化闭环',
    description: '能通过badcase收集、Prompt迭代、RAG策略优化持续提升效果'
  },
  { 
    id: 'skill-lifecycle',
    name: '产品全生命周期落地能力',
    description: '具备从0到1的产品孵化能力，以及从1到n的持续迭代与规模化能力'
  }
]

const techSkills = [
  { 
    id: 'skill-mvp',
    name: '独立实现MVP（Trae / Cursor）',
    description: '能借助AI工具不依赖后端独立完成产品原型开发'
  },
  { 
    id: 'skill-frontend',
    name: 'Vue / React / TypeScript',
    description: '具备现代前端框架开发能力，能独立完成功能页面'
  },
  { 
    id: 'skill-html-css',
    name: 'HTML / CSS',
    description: '扎实的页面结构与样式实现能力'
  },
  { 
    id: 'skill-deploy',
    name: 'GitHub Pages / Vercel部署',
    description: '熟悉从代码提交到自动化部署的完整流程'
  },
  { 
    id: 'skill-api',
    name: '前后端联调与异常沟通',
    description: '能与开发高效对齐需求边界与异常逻辑'
  }
]


</script>

<style scoped>
.skills {
  background: var(--bg-dark);
}

/* 两列布局 */
.skills-grid {
  display: flex;
  gap: 24px;
  margin-top: 32px;
  align-items: stretch;
}

.skills-column {
  flex: 1;
  background: var(--bg-card);
  border-radius: 16px;
  border: 1px solid var(--border-color);
  padding: 24px;
}

.column-title {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 2px solid var(--border-color);
}

.column-icon {
  font-size: 1.4rem;
}

.skills-list {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.skill-card {
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 8px 12px;
  background: var(--bg-dark);
  border-radius: 6px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
}

.skill-card:hover {
  border-color: var(--primary-color);
  box-shadow: 0 2px 6px rgba(99, 102, 241, 0.1);
}

.skill-main {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 100%;
}

.skill-desc {
  font-size: 0.7rem;
  color: var(--text-muted);
  margin: 0;
  padding-left: 14px;
  line-height: 1.3;
}

.skill-bullet {
  width: 5px;
  height: 5px;
  background: var(--primary-color);
  border-radius: 50%;
  flex-shrink: 0;
}

.skill-text {
  flex: 1;
  font-size: 0.9rem;
  color: var(--text-secondary);
}

.skill-card:hover .skill-text {
  color: var(--text-primary);
}

/* 响应式 */
@media (max-width: 968px) {
  .skills-grid {
    flex-direction: column;
    gap: 20px;
  }
  
  .skills-column {
    padding: 20px;
  }
  
  .column-title {
    font-size: 1.1rem;
    margin-bottom: 16px;
    padding-bottom: 12px;
  }
}

@media (max-width: 768px) {
  .skills {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .skills-grid {
    margin-top: 24px;
  }
  
  .column-title {
    font-size: 1rem;
  }
  
  .skill-text {
    font-size: 0.85rem;
  }
  
  .skill-card {
    padding: 8px 12px;
    gap: 2px;
  }
  
  .skill-desc {
    font-size: 0.7rem;
  }
}
</style>
