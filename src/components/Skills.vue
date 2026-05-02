<template>
  <section id="skills" class="section skills">
    <!-- 业务能力标题 - 定位在5vw -->
    <div class="business-title-wrapper">
      <h2 class="section-title">业务能力</h2>
      <p class="section-subtitle">AI产品与通用产品</p>
    </div>
    
    <!-- 技术能力标题 - 定位在55vw -->
    <div class="tech-title-wrapper">
      <h2 class="section-title">技术能力</h2>
      <p class="section-subtitle">独立交付与工程落地</p>
    </div>
    
    <div class="skills-content">
      <!-- 业务能力区域 (0-55vw) -->
      <div class="business-section">
        <div class="business-columns">
          <!-- 业务能力左列 (0-28vw) -->
          <div class="business-column-left">
            <div 
              v-for="(skill, index) in businessSkillsLeft" 
              :key="index"
              :id="skill.id"
              class="skill-item"
            >
              <div class="skill-main">
                <span class="skill-bullet"></span>
                <span class="skill-text">{{ skill.name }}</span>
              </div>
              <p class="skill-desc">{{ skill.description }}</p>
            </div>
          </div>
          <!-- 业务能力右列 (28-55vw) -->
          <div class="business-column-right">
            <div 
              v-for="(skill, index) in businessSkillsRight" 
              :key="index"
              :id="skill.id"
              class="skill-item"
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

      <!-- 技术技能区域 (55-80vw) -->
      <div class="tech-section">
        <div class="tech-column">
          <div 
            v-for="(skill, index) in techSkills" 
            :key="index"
            :id="skill.id"
            class="skill-item"
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
  </section>
</template>

<script setup>
import { computed } from 'vue'

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
    id: 'skill-gsap',
    name: 'GSAP 动画引擎',
    description: '熟练运用GSAP实现高性能UI动效与复杂交互设计，提升产品视觉体验'
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
  },
  { 
    id: 'skill-apifox',
    name: 'Apifox / 接口测试',
    description: '能够独立完成接口调用、参数校验、返回数据分析及问题定位'
  }
]

// 将业务能力分成两列
const businessSkillsLeft = computed(() => businessSkills.slice(0, 7))
const businessSkillsRight = computed(() => businessSkills.slice(7))
</script>

<style scoped>
.skills {
  background: var(--bg-dark);
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  position: relative;
}

/* 业务能力标题 - 定位在5vw */
.business-title-wrapper {
  position: absolute;
  left: 4vw;
  top: 100px;
  z-index: 10;
}

/* 技术能力标题 - 定位在55vw */
.tech-title-wrapper {
  position: absolute;
  left: 59vw;
  top: 100px;
  z-index: 10;
}

.skills-content {
  display: flex;
  height: 100%;
  width: 100%;
  padding-top: 140px;
}

/* 业务能力区域 (0-55vw) */
.business-section {
  width: 55vw;
  height: 100%;
  padding: 0 10px 0 40px;
  display: flex;
  flex-direction: column;
}

.business-columns {
  display: flex;
  gap: 8px;
  flex: 1;
  overflow: hidden;
}

.business-column-left {
  width: 28vw;
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.business-column-right {
  width: 27vw;
  display: flex;
  flex-direction: column;
  gap: 5px;
}

/* 技术技能区域 (55-80vw) */
.tech-section {
  width: 25vw;
  height: 100%;
  padding: 0 20px 0 40px;
  display: flex;
  flex-direction: column;
  border-left: 1px solid var(--border-color);
}

.tech-column {
  display: flex;
  flex-direction: column;
  gap: 8px;
  flex: 1;
}

/* 标题样式 */
.section-title {
  font-size: 1.6rem;
  font-weight: 700;
  color: var(--text-primary);
  margin: 0 0 4px 0;
}

.section-subtitle {
  font-size: 0.85rem;
  color: var(--text-secondary);
  margin: 0;
}

/* 技能条样式 - 宽度减少1/4 (即75%宽度) */
.skill-item {
  display: flex;
  flex-direction: column;
  gap: 2px;
  padding: 5px 8px;
  background: var(--bg-card);
  border-radius: 6px;
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
  width: 90%;
  position: relative;
  overflow: hidden;
}

/* 液态水晶光泽效果 */
.skill-item::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(
    45deg,
    transparent 30%,
    rgba(99, 102, 241, 0.08) 40%,
    rgba(139, 92, 246, 0.15) 50%,
    rgba(99, 102, 241, 0.08) 60%,
    transparent 70%
  );
  animation: liquidCrystal 8s ease-in-out infinite;
  pointer-events: none;
}

/* 液态水晶流动动画 */
@keyframes liquidCrystal {
  0%, 100% {
    transform: translateX(-30%) translateY(-30%) rotate(0deg);
    opacity: 0.5;
  }
  25% {
    transform: translateX(10%) translateY(10%) rotate(90deg);
    opacity: 0.72;
  }
  50% {
    transform: translateX(-10%) translateY(20%) rotate(180deg);
    opacity: 0.9;
  }
  75% {
    transform: translateX(20%) translateY(-10%) rotate(270deg);
    opacity: 0.72;
  }
}

/* 额外的闪烁效果 */
.skill-item::after {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 50%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.12),
    transparent
  );
  animation: crystalShine 6s ease-in-out infinite;
  pointer-events: none;
}

@keyframes crystalShine {
  0%, 100% {
    left: -100%;
    opacity: 0;
  }
  50% {
    left: 150%;
    opacity: 0.9;
  }
}

.skill-item:hover {
  border-color: var(--primary-color);
  box-shadow: 0 2px 6px rgba(99, 102, 241, 0.12);
}

/* 悬停时增强液态效果 */
.skill-item:hover::before {
  animation-duration: 4s;
  background: linear-gradient(
    45deg,
    transparent 30%,
    rgba(99, 102, 241, 0.12) 40%,
    rgba(139, 92, 246, 0.22) 50%,
    rgba(99, 102, 241, 0.12) 60%,
    transparent 70%
  );
}

.skill-item:hover::after {
  animation-duration: 3s;
}

.skill-main {
  display: flex;
  align-items: center;
  gap: 6px;
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
  font-size: 0.85rem;
  font-weight: 400;
  color: var(--text-primary);
}

.skill-desc {
  font-size: 0.7rem;
  color: var(--text-secondary);
  margin: 0;
  padding-left: 11px;
  line-height: 1.3;
}

/* 响应式 */
@media (max-width: 1200px) {
  .business-columns {
    gap: 6px;
  }
  
  .business-section,
  .tech-section {
    padding: 0 10px;
  }
}
</style>
