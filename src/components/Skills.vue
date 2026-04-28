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
              @click="openSkillModal(skill)"
            >
              <div class="skill-main">
                <span class="skill-bullet"></span>
                <span class="skill-text">{{ skill.name }}</span>
                <svg class="skill-arrow" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polyline points="9 18 15 12 9 6"></polyline>
                </svg>
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
              @click="openSkillModal(skill)"
            >
              <div class="skill-main">
                <span class="skill-bullet"></span>
                <span class="skill-text">{{ skill.name }}</span>
                <svg class="skill-arrow" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polyline points="9 18 15 12 9 6"></polyline>
                </svg>
              </div>
              <p class="skill-desc">{{ skill.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 技能详情弹窗 -->
    <div class="skill-modal-overlay" v-if="activeSkill" @click="closeSkillModal">
      <div class="skill-modal-content" :class="{ 'prd-modal': activeSkill.name === 'PRD撰写' }" @click.stop @wheel.stop @touchmove.stop>
        <button class="skill-modal-close" @click="closeSkillModal">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        
        <!-- 普通技能弹窗 -->
        <template v-if="activeSkill.name !== 'PRD撰写'">
          <div class="skill-modal-header">
            <div class="skill-modal-icon">{{ activeSkill.name.charAt(0) }}</div>
            <div class="skill-modal-title-wrapper">
              <h3 class="skill-modal-title">{{ activeSkill.name }}</h3>
            </div>
          </div>
          <div class="skill-modal-body">
            <div class="skill-modal-section">
              <p class="skill-modal-description">{{ activeSkill.description }}</p>
            </div>
          </div>
        </template>
        
        <!-- PRD撰写技能弹窗 - 带导航窗格 -->
        <template v-else>
          <div class="prd-layout">
            <!-- 左侧导航栏 -->
            <div class="prd-nav">
              <div class="prd-nav-header">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <line x1="3" y1="12" x2="21" y2="12"></line>
                  <line x1="3" y1="6" x2="21" y2="6"></line>
                  <line x1="3" y1="18" x2="21" y2="18"></line>
                </svg>
                文档导航
              </div>
              <div class="prd-nav-content">
                <div class="prd-nav-section" v-for="(section, index) in prdNavSections" :key="index">
                  <div 
                    class="prd-nav-title" 
                    :class="{ 'active': activePrdSection === section.id, 'expanded': expandedPrdSections.includes(section.id) }"
                    @click="togglePrdSection(section.id)"
                  >
                    <span class="prd-nav-arrow" v-if="section.children">
                      <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 18 15 12 9 6"></polyline>
                      </svg>
                    </span>
                    <span @click.stop="scrollToPrdSection(section.id)">{{ section.title }}</span>
                  </div>
                  <div class="prd-nav-children" v-if="section.children && expandedPrdSections.includes(section.id)">
                    <div 
                      v-for="(child, childIndex) in section.children" 
                      :key="childIndex"
                      class="prd-nav-child"
                      :class="{ 'active': activePrdSection === child.id }"
                      @click="scrollToPrdSection(child.id)"
                    >
                      {{ child.title }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- 右侧内容区域 -->
            <div class="prd-modal-body prd-modal-body-with-nav" ref="prdContentRef" @scroll="handlePrdScroll">
              <div class="prd-content-wrapper">
                <h1 id="prd-title">AI面试模拟器 产品需求文档</h1>
                <div class="prd-markdown" v-html="activeSkillContent"></div>
              </div>
            </div>
          </div>
        </template>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { marked } from 'marked'

const activeSkill = ref(null)

// PRD文档内容
const prdContent = `**文档基础信息**

| **项目** | **内容** |
| -------- | ---------- |
| 文档版本 | 2.0 |
| 创建日期 | 2026-04-27 |
| 作者 | 田雨 |

**执行摘要**

AI面试模拟器，核心价值：基于用户自己的简历和JD生成个性化面试。v1.0已完成固定岗位流程，v2.0支持用户上传文件，当前卡点在知识库异步处理延迟，预计5月15日解决。成功标准：完成率≥60%，复购率≥30%。需研发支持：工作流循环等待逻辑（0.5人天）。

**术语表**

| 术语 | 说明 |
| ---------- | ---------------------------------- |
| Agent | 面试模拟器本身 |
| Coze | 字节跳动AI智能体平台 |
| RAG | 检索增强生成，减少幻觉 |
| 临时知识库 | 存储当前面试的简历和JD，结束后清空 |
| 对话流 | Coze中强制执行的流程 |
| 幻觉 | 模型编造不存在的内容 |

**1. 项目背景**

问题：通用面试工具无法针对个人简历和JD提问。

目标：用户上传简历+JD，AI自动生成个性化面试。

边界：仅文本交互，不存储用户文件，不保证实际面试通过率。

成本预估：单次面试约2000 tokens，按100 DAU计算，月成本约30元（DeepSeek API）。

**2. 版本规划**

| 版本 | 核心目标 | 状态 | 预计上线 |
| ---- | ------------ | ------ | -------- |
| v1.0 | 固定简历+JD | 已达成 | - |
| v2.0 | 用户上传文件 | 进行中 | 5月20日 |
| v3.0 | 一键生成JD | 规划中 | Q3 |

**3. v1.0核心功能**

固定知识库（简历+JD+题库）

5个问题 + 综合点评

三段落回复（点评→追问→下一个）

**已解决问题：**杜撰内容、不会点评、问题无限、类型单一、知识库名称错误。

**限制：**只能面AI产品经理，别人无法使用。

**4. v2.0核心功能**

用户上传简历+JD（PDF/Word/图片）

临时知识库存储

基于上传内容个性化提问

结束后清空数据

**当前卡点：**知识库写入后异步处理，检索不到内容。备选方案：跳过知识库，直接解析文件文本传给大模型。

**预计解决时间：**5月6日。如超期，启用备选方案。

**5. 技术架构**

Coze + DeepSeek-V3.2 + 对话流模式 + 临时知识库

**6. 资源评估**

| 任务 | 人/天 | 依赖 |
| ------------------ | -------- | -------- |
| 工作流循环等待逻辑 | 0.5 | 无 |
| 文件解析插件接入 | 0.5 | 插件可用 |
| 端到端测试 | 0.5 | 上述完成 |
| 合计 | 1.5人/天 | - |

**7. 用户画像**

已有1-3次面试经历、感受到"通用问题不顶用"、愿意花5-10分钟针对性练习的求职者。

**8. 交互流程**

开始面试 → 上传简历+JD → 开场白（Agent调用工作流输出）→ 自我介绍 → 5轮问答（每轮：点评→自然过渡下一个问题）→ 综合点评 → 结束

**9. 核心成功指标**

| 指标 | 目标值 | 数据来源 |
| ----------------------- | ------ | -------- |
| 完成率（完成5个问题） | ≥60% | 埋点 |
| 复购率（7天内再次使用） | ≥30% | 埋点 |
| 用户主动中断率 | ≤40% | 埋点 |
| 反馈评分（1-5分） | ≥4.0 | 问卷 |

**达标判断：**以上指标连续2个月达标为"成功"，任意指标不达标触发复盘。

**10. 埋点与动作**

| 埋点 | 触发动作 |
| -------------- | -------------------- |
| 上传完成率<50% | 优化引导文案 |
| 完成率<60% | 抽查日志，定位流失点 |
| 中断集中在某题 | 优化该维度Prompt |
| 评分<3分 | 24小时内人工跟进 |

**11. 非功能需求**

首Token ≤3秒，完整开场白 ≤8秒

不得杜撰简历中不存在的内容

用户文件不持久化，用完即删

支持Chrome/Safari/移动端

**12. 风险与降级**

| 风险 | 概率 | 应对 |
| -------------- | ---- | -------------------------- |
| 知识库异步延迟 | 高 | 备选方案：直接解析文本 |
| API限流/超时 | 中 | 提示重试，降级返回兜底话术 |
| 成本超预期 | 低 | DAU超500时申请预算 |

**13. 附录：关键Prompt（精简版）**

文件收集：「用户说开始面试时，检查文件，缺则补，全则调工作流」

开场白：「基于解析内容，输出：资料已收到→面试流程→请自我介绍」

提问：「严格基于文件内容提问，每轮：点评→下一个问题」`

const activeSkillContent = computed(() => {
  if (activeSkill.value && activeSkill.value.name === 'PRD撰写') {
    return marked(prdContent)
  }
  return null
});

// PRD导航数据
const prdNavSections = [
  { id: 'prd-title', title: '文档标题' },
  { 
    id: 'prd-basic', 
    title: '文档基础信息',
    children: [
      { id: 'prd-summary', title: '执行摘要' },
      { id: 'prd-terms', title: '术语表' }
    ]
  },
  { id: 'prd-background', title: '1. 项目背景' },
  { id: 'prd-versions', title: '2. 版本规划' },
  { id: 'prd-v1', title: '3. v1.0核心功能' },
  { id: 'prd-v2', title: '4. v2.0核心功能' },
  { id: 'prd-arch', title: '5. 技术架构' },
  { id: 'prd-resources', title: '6. 资源评估' },
  { id: 'prd-persona', title: '7. 用户画像' },
  { id: 'prd-flow', title: '8. 交互流程' },
  { id: 'prd-metrics', title: '9. 核心成功指标' },
  { id: 'prd-tracking', title: '10. 埋点与动作' },
  { id: 'prd-nfr', title: '11. 非功能需求' },
  { id: 'prd-risks', title: '12. 风险与降级' },
  { id: 'prd-prompts', title: '13. 附录：关键Prompt' }
]

const activePrdSection = ref('prd-title');
const expandedPrdSections = ref(['prd-basic']);
const prdContentRef = ref(null);

const togglePrdSection = (sectionId) => {
  const index = expandedPrdSections.value.indexOf(sectionId);
  if (index > -1) {
    expandedPrdSections.value.splice(index, 1);
  } else {
    expandedPrdSections.value.push(sectionId);
  }
};

const scrollToPrdSection = (sectionId) => {
  const element = document.getElementById(sectionId);
  if (element && prdContentRef.value) {
    const container = prdContentRef.value;
    const elementTop = element.offsetTop;
    const containerHeight = container.clientHeight;
    const elementHeight = element.offsetHeight;
    const scrollPosition = elementTop - (containerHeight / 2) + (elementHeight / 2);
    
    container.scrollTo({
      top: scrollPosition,
      behavior: 'smooth'
    });
    activePrdSection.value = sectionId;
  }
};

const handlePrdScroll = () => {
  if (!prdContentRef.value) return;
  
  const scrollTop = prdContentRef.value.scrollTop;
  const containerHeight = prdContentRef.value.clientHeight;
  const centerPosition = scrollTop + (containerHeight / 2);
  
  let currentSection = 'prd-title';
  
  for (const section of prdNavSections) {
    const element = document.getElementById(section.id);
    if (element) {
      const elementTop = element.offsetTop;
      if (elementTop <= centerPosition) {
        currentSection = section.id;
      }
    }
    
    if (section.children) {
      for (const child of section.children) {
        const childElement = document.getElementById(child.id);
        if (childElement) {
          const childTop = childElement.offsetTop;
          if (childTop <= centerPosition) {
            currentSection = child.id;
          }
        }
      }
    }
  }
  
  activePrdSection.value = currentSection;
};

const businessSkills = [
  { 
    id: 'skill-prd',
    name: 'PRD撰写',
    description: '能输出逻辑清晰、边界明确、可交付开发的PRD',
    hasPrd: true
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

const openSkillModal = (skill) => {
  activeSkill.value = skill;
  document.body.style.overflow = 'hidden';
};

const closeSkillModal = () => {
  activeSkill.value = null;
  document.body.style.overflow = '';
};

// 检查URL hash并自动打开对应技能弹窗
onMounted(() => {
  const hash = window.location.hash
  if (hash && hash.startsWith('#skill-')) {
    const skillId = hash.slice(1) // 去掉 #
    // 查找对应的技能
    const allSkills = [...businessSkills, ...techSkills]
    const skill = allSkills.find(s => s.id === skillId)
    if (skill) {
      // 延迟执行，确保页面已渲染
      setTimeout(() => {
        // 先滚动到技能卡片位置（屏幕正中间）
        const element = document.getElementById(skillId)
        if (element) {
          const elementRect = element.getBoundingClientRect()
          const absoluteElementTop = elementRect.top + window.pageYOffset
          const middle = absoluteElementTop - (window.innerHeight / 2) + (elementRect.height / 2)
          window.scrollTo({
            top: middle,
            behavior: 'smooth'
          })
        }
        // 延迟打开弹窗，等滚动完成后再打开
        setTimeout(() => {
          openSkillModal(skill)
          // 清除URL hash，避免刷新时再次弹出
          history.replaceState(null, null, ' ')
        }, 400)
      }, 100)
    }
  }
})
</script>

<style scoped>
.skills {
  background: var(--bg-dark);
}

/* 两列布局 */
.skills-grid {
  display: flex;
  gap: 40px;
  margin-top: 48px;
  align-items: stretch;
}

.skills-column {
  flex: 1;
  background: var(--bg-card);
  border-radius: 20px;
  border: 1px solid var(--border-color);
  padding: 32px;
}

.column-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 1.4rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 2px solid var(--border-color);
}

.column-icon {
  font-size: 1.6rem;
}

.skills-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.skill-card {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 16px 20px;
  background: var(--bg-dark);
  border-radius: 12px;
  border: 1px solid var(--border-color);
  cursor: pointer;
  transition: all 0.3s ease;
}

.skill-card:hover {
  border-color: var(--primary-color);
  box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
  transform: translateX(4px);
}

.skill-main {
  display: flex;
  align-items: center;
  gap: 12px;
  width: 100%;
}

.skill-desc {
  font-size: 0.8rem;
  color: var(--text-muted);
  margin: 0;
  padding-left: 20px;
  line-height: 1.4;
}

.skill-bullet {
  width: 8px;
  height: 8px;
  background: var(--primary-color);
  border-radius: 50%;
  flex-shrink: 0;
}

.skill-text {
  flex: 1;
  font-size: 1.05rem;
  color: var(--text-secondary);
}

.skill-card:hover .skill-text {
  color: var(--text-primary);
}

.skill-arrow {
  color: var(--text-muted);
  transition: all 0.3s ease;
}

.skill-card:hover .skill-arrow {
  color: var(--primary-color);
  transform: translateX(4px);
}

/* 弹窗样式 */
.skill-modal-overlay {
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
}

.skill-modal-content {
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
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
}

/* PRD弹窗特殊样式 */
.skill-modal-content.prd-modal {
  max-width: 1000px;
  padding: 0;
  overflow: hidden;
}

/* PRD布局 */
.prd-layout {
  display: flex;
  height: 90vh;
  max-height: 800px;
}

/* 左侧导航栏 */
.prd-nav {
  width: 240px;
  background: var(--bg-card);
  border-right: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
}

.prd-nav-header {
  padding: 16px 20px;
  font-weight: 600;
  color: var(--text-primary);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  gap: 8px;
}

.prd-nav-content {
  flex: 1;
  overflow-y: auto;
  padding: 12px 0;
}

.prd-nav-section {
  margin-bottom: 4px;
}

.prd-nav-title {
  padding: 10px 16px 10px 20px;
  cursor: pointer;
  color: var(--text-secondary);
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s ease;
  border-left: 3px solid transparent;
}

.prd-nav-title:hover {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text-primary);
}

.prd-nav-title.active {
  background: rgba(128, 128, 128, 0.2);
  color: var(--text-primary);
  border-left-color: rgba(128, 128, 128, 0.5);
}

.prd-nav-arrow {
  display: flex;
  align-items: center;
  transition: transform 0.2s ease;
}

.prd-nav-title.expanded .prd-nav-arrow {
  transform: rotate(90deg);
}

.prd-nav-children {
  padding-left: 20px;
}

.prd-nav-child {
  padding: 8px 16px 8px 30px;
  cursor: pointer;
  color: var(--text-muted);
  font-size: 0.85rem;
  transition: all 0.2s ease;
  border-left: 3px solid transparent;
}

.prd-nav-child:hover {
  background: rgba(255, 255, 255, 0.03);
  color: var(--text-secondary);
}

.prd-nav-child.active {
  background: rgba(128, 128, 128, 0.15);
  color: var(--text-primary);
  border-left-color: rgba(128, 128, 128, 0.5);
}

/* 右侧内容区域 */
.prd-modal-body-with-nav {
  flex: 1;
  padding: 0;
  overflow-y: auto;
}

.prd-content-wrapper {
  padding: 40px 48px;
  max-width: 800px;
}

/* PRD内容样式 */
.prd-markdown {
  font-size: 0.95rem;
  line-height: 1.8;
  color: var(--text-secondary);
}

.prd-markdown h1 {
  font-size: 1.8rem;
  color: var(--text-primary);
  margin-bottom: 24px;
  padding-bottom: 12px;
  border-bottom: 2px solid var(--border-color);
}

.prd-markdown h2 {
  font-size: 1.3rem;
  color: var(--text-primary);
  margin-top: 32px;
  margin-bottom: 16px;
  padding-bottom: 8px;
  border-bottom: 1px solid var(--border-color);
}

.prd-markdown p {
  margin-bottom: 16px;
}

.prd-markdown ul {
  margin: 16px 0;
  padding-left: 24px;
}

.prd-markdown li {
  margin-bottom: 8px;
}

.prd-markdown strong {
  color: var(--text-primary);
  font-weight: 600;
}

/* 表格样式 - 与项目3保持一致 */
.prd-markdown table {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0;
  background: var(--bg-card);
  border-radius: 8px;
  overflow: hidden;
  font-size: 0.9rem;
}

.prd-markdown th,
.prd-markdown td {
  padding: 12px 16px;
  text-align: left;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.prd-markdown th {
  background: rgba(128, 128, 128, 0.15);
  font-weight: 600;
  color: var(--text-primary);
}

.prd-markdown td {
  color: var(--text-secondary);
}

.prd-markdown tr:last-child td {
  border-bottom: none;
}

.prd-markdown tr:nth-child(even) {
  background: rgba(255, 255, 255, 0.02);
}

/* 内容区滚动条样式 */
.prd-modal-body-with-nav::-webkit-scrollbar {
  width: 6px;
}

.prd-modal-body-with-nav::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.05);
}

.prd-modal-body-with-nav::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.5);
  border-radius: 3px;
}

.prd-modal-body-with-nav::-webkit-scrollbar-thumb:hover {
  background: rgba(128, 128, 128, 0.7);
}

/* 导航栏滚动条样式 */
.prd-nav-content::-webkit-scrollbar {
  width: 4px;
}

.prd-nav-content::-webkit-scrollbar-track {
  background: transparent;
}

.prd-nav-content::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.3);
  border-radius: 2px;
}

/* 响应式：小屏幕隐藏导航 */
@media (max-width: 768px) {
  .prd-layout {
    flex-direction: column;
  }
  
  .prd-nav {
    width: 100%;
    max-height: 200px;
    border-right: none;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  }
  
  .prd-content-wrapper {
    padding: 24px;
  }
}

.skill-modal-close {
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

.skill-modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  color: var(--text-primary);
}

.skill-modal-header {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-bottom: 32px;
  padding-bottom: 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.skill-modal-icon {
  width: 70px;
  height: 70px;
  border-radius: 16px;
  background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.8rem;
  font-weight: 700;
  flex-shrink: 0;
}

.skill-modal-title-wrapper {
  flex: 1;
}

.skill-modal-title {
  font-size: 2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin: 0;
}

.skill-modal-body {
  color: var(--text-secondary);
}

.skill-modal-description {
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: 32px;
}

.skill-modal-section {
  margin-bottom: 32px;
}

.skill-modal-section h4 {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.skill-modal-section ul {
  list-style: none;
  padding: 0;
}

.skill-modal-section li {
  padding: 12px 0;
  padding-left: 24px;
  position: relative;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  color: var(--text-secondary);
}

.skill-modal-section li::before {
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

/* 弹窗滚动条 */
.skill-modal-content::-webkit-scrollbar {
  width: 8px;
}

.skill-modal-content::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.05);
  border-radius: 4px;
}

.skill-modal-content::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.5);
  border-radius: 4px;
}

.skill-modal-content::-webkit-scrollbar-thumb:hover {
  background: rgba(128, 128, 128, 0.7);
}

/* 响应式 */
@media (max-width: 968px) {
  .skills-grid {
    flex-direction: column;
    gap: 24px;
  }
  
  .skills-column {
    padding: 24px;
  }
}

@media (max-width: 768px) {
  .skills {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .column-title {
    font-size: 1.2rem;
  }
  
  .skill-text {
    font-size: 0.95rem;
  }
  
  .skill-card {
    padding: 14px 16px;
  }
  
  .skill-modal-overlay {
    padding: 0;
    align-items: flex-end;
  }
  
  .skill-modal-content {
    width: 100%;
    max-width: 100%;
    height: 90vh;
    max-height: 90vh;
    margin: 0;
    border-radius: 20px 20px 0 0;
    padding: 60px 20px 20px;
  }
  
  .skill-modal-close {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 36px;
    height: 36px;
  }
  
  .skill-modal-header {
    flex-direction: column;
    text-align: center;
    gap: 12px;
    margin-bottom: 20px;
  }
  
  .skill-modal-icon {
    width: 50px;
    height: 50px;
    font-size: 1.3rem;
  }
  
  .skill-modal-title {
    font-size: 1.3rem;
  }
  
  .skill-modal-section h4 {
    font-size: 1rem;
  }
  
  .skill-modal-section li {
    font-size: 0.9rem;
  }
}
</style>
