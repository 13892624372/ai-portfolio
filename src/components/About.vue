<template>
  <section id="about" class="section about">
    <div class="container about-container">
      <!-- 关于我部分 -->
      <h2 class="section-title">关于我</h2>
      <p class="section-subtitle">以技术为根基，以产品思维驱动AI创新</p>

      <div class="about-content">
        <div class="about-image">
          <div class="image-wrapper">
            <img src="/photo/个人网站照片.jpg" alt="田雨" class="profile-photo" />
          </div>
        </div>

        <div class="about-text">
          <h3 class="about-title">我是田雨</h3>
          <p class="about-description">
            软件工程技术专业毕业生，毕业于西安信息职业大学。四年的技术学习让我深入理解软件开发的完整流程，
            从需求分析、架构设计到前后端实现，具备将抽象想法转化为具体产品的工程能力。
          </p>
          <p class="about-description">
            通过自主学习和项目实践，主导完成多个实战项目，涵盖Web应用、AI工具等领域，积累了丰富的项目经验。
            对人工智能保持高度热情，系统学习机器学习、深度学习课程，持续关注GPT、Claude等大模型及AI Agent最新进展。
          </p>
          <p class="about-description">
            我的核心优势在于：既能与开发团队进行深度技术对话，理解实现成本与技术边界；
            又能从用户视角出发，挖掘真实需求并设计产品方案。期待加入贵司，
            用技术背景赋能产品工作，在AI领域创造有价值的产品。
          </p>
        </div>
      </div>
      
      <!-- AI发展史时间轴 -->
      <div class="ai-timeline-section">
        <h2 class="section-title ai-section-title">关于AI</h2>
        <p class="section-subtitle ai-section-subtitle">从图灵测试到智能体时代的技术演进</p>
        
        <div class="timeline-container">
          <div class="timeline-track">
            <div 
              v-for="(event, index) in aiHistoryTimeline" 
              :key="index"
              class="timeline-node"
              :class="{ 'active': activeTimelineIndex === index }"
              @mouseenter="activeTimelineIndex = index"
              @mouseleave="activeTimelineIndex = null"
            >
              <div class="timeline-year">{{ event.year }}</div>
              <div class="timeline-dot" :style="{ '--dot-color': event.color }"></div>
              <div class="timeline-line" v-if="index < aiHistoryTimeline.length - 1"></div>
              <div class="timeline-card">
                <div class="timeline-card-header">
                  <span class="timeline-event">{{ event.event }}</span>
                  <span class="timeline-tag" :style="{ background: event.tagColor }">{{ event.tag }}</span>
                </div>
                <p class="timeline-detail">{{ event.detail }}</p>
                <p class="timeline-quote">"{{ event.quote }}"</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 大模型对比雷达图 -->
      <div class="model-radar-section">
        <h2 class="section-title radar-section-title">主流大模型能力对比</h2>
        <p class="section-subtitle radar-section-subtitle">多维度评估主流AI模型的综合能力</p>
        
        <!-- Tab 按钮组 -->
        <div class="radar-tabs">
          <button 
            v-for="tab in radarTabs" 
            :key="tab.key"
            class="radar-tab"
            @click="openRadarModal(tab.key)"
          >
            {{ tab.label }}
          </button>
        </div>
      </div>
      
    </div>

    <!-- 雷达图弹窗 - 使用 teleport 移到 body 下避免 z-index 嵌套问题 -->
    <teleport to="body">
      <div v-if="showRadarModal" :class="['radar-modal-overlay', { 'closing': isClosingRadarModal }]" @click="closeRadarModal">
        <div class="radar-modal" @click.stop>
          <button class="radar-modal-close" @click="closeRadarModal">&times;</button>
          <h3 class="radar-modal-title">{{ currentRadarTabLabel }}</h3>
          <div class="radar-modal-chart-container">
            <div ref="radarChart" class="radar-chart"></div>
          </div>
          <p class="radar-modal-note">
            * 评分基于 MMLU、C-Eval、SWE-Bench 等公开基准及 API 价格综合评估，仅供能力对比参考
          </p>
        </div>
      </div>
    </teleport>
  </section>
</template>

<script setup>
import { ref, computed, onMounted, watch, nextTick } from 'vue'
import * as echarts from 'echarts'

// 当前激活的时间轴索引
const activeTimelineIndex = ref(null)

// AI发展历史时间轴数据
const aiHistoryTimeline = ref([
  {
    year: '1950',
    event: '图灵测试',
    quote: '机器能思考吗？——问题被提出',
    significance: '起点',
    detail: '艾伦·图灵发表论文《计算机器与智能》，提出著名的"图灵测试"，为判断机器是否具有智能提供了标准。这是人工智能概念的哲学起点，标志着人类开始严肃思考机器智能的可能性。',
    color: '#667eea',
    tagColor: 'rgba(102, 126, 234, 0.2)',
    tag: '起点'
  },
  {
    year: '1956',
    event: '达特茅斯会议',
    quote: '人工智能概念正式诞生',
    significance: '学科成立',
    detail: '约翰·麦卡锡等科学家在达特茅斯学院召开研讨会，首次提出"人工智能"(Artificial Intelligence)这一术语。会议确立了AI作为独立学科的地位，开启了符号主义AI的黄金时代。',
    color: '#764ba2',
    tagColor: 'rgba(118, 75, 162, 0.2)',
    tag: '学科成立'
  },
  {
    year: '1997',
    event: '深蓝战胜卡斯帕罗夫',
    quote: '算力首次在智力博弈中击败人类',
    significance: '算力突破',
    detail: 'IBM深蓝超级计算机以3.5:2.5击败世界国际象棋冠军卡斯帕罗夫。这是机器首次在复杂智力游戏中战胜人类顶尖选手，证明了暴力计算结合启发式搜索的强大威力。',
    color: '#f093fb',
    tagColor: 'rgba(240, 147, 251, 0.2)',
    tag: '算力突破'
  },
  {
    year: '2012',
    event: 'AlexNet与深度学习爆发',
    quote: 'GPU+大数据让图像识别错误率从26%降至15%',
    significance: '深度学习时代',
    detail: 'Alex Krizhevsky等人设计的AlexNet在ImageNet竞赛中以巨大优势获胜，将图像识别错误率大幅降低。这一突破证明了深度神经网络+GPU训练的可行性，开启了深度学习革命。',
    color: '#f5576c',
    tagColor: 'rgba(245, 87, 108, 0.2)',
    tag: '深度学习'
  },
  {
    year: '2016',
    event: 'AlphaGo战胜李世石',
    quote: '攻克人类智慧最后堡垒——围棋',
    significance: '全球认知破圈',
    detail: 'DeepMind的AlphaGo以4:1击败围棋世界冠军李世石。围棋被视为人类智慧的最后堡垒，其搜索空间远超国际象棋。AlphaGo结合了深度神经网络和蒙特卡洛树搜索，震惊全球。',
    color: '#4facfe',
    tagColor: 'rgba(79, 172, 254, 0.2)',
    tag: '认知破圈'
  },
  {
    year: '2017',
    event: 'Transformer架构诞生',
    quote: 'Google团队的论文奠定大模型基础',
    significance: '技术基石',
    detail: 'Google发布论文《Attention Is All You Need》，提出Transformer架构。这一创新彻底改变了自然语言处理领域，其自注意力机制成为GPT、BERT等大模型的核心技术基础。',
    color: '#00f2fe',
    tagColor: 'rgba(0, 242, 254, 0.2)',
    tag: '技术基石'
  },
  {
    year: '2022',
    event: 'ChatGPT引爆大众认知',
    quote: 'AI从实验室走向每个人',
    significance: '大众化元年',
    detail: 'OpenAI发布ChatGPT，两个月内用户突破1亿，成为史上增长最快的消费级应用。它展示了大型语言模型的惊人能力，让普通大众第一次直观感受到AI的强大，开启了生成式AI时代。',
    color: '#43e97b',
    tagColor: 'rgba(67, 233, 123, 0.2)',
    tag: '大众化'
  },
  {
    year: '2023-2024',
    event: 'AI Agent爆发',
    quote: 'AI不再只会聊天，它会用工具、做计划、自主执行',
    significance: '从对话到行动',
    detail: 'AutoGPT、LangChain等框架兴起，AI Agent成为热点。AI开始具备规划、记忆、工具使用等能力，能够自主完成复杂任务。这标志着AI从"对话"向"行动"的转变，是迈向AGI的重要一步。',
    color: '#38f9d7',
    tagColor: 'rgba(56, 249, 215, 0.2)',
    tag: 'Agent时代'
  },
  {
    year: '2025+',
    event: '多模态 + Agent + 成本下降',
    quote: 'AI从玩具变成工具，从单点变成系统',
    significance: '当前趋势',
    detail: 'GPT-4V、Sora等多模态模型展现强大能力，AI Agent框架日趋成熟，推理成本持续下降。AI正从实验室走向产业应用，从单点工具演变为智能系统，真正开始改变各行各业的工作方式。',
    color: '#fa709a',
    tagColor: 'rgba(250, 112, 154, 0.2)',
    tag: '当前趋势'
  }
])

// 雷达图相关
const currentRadarTab = ref('international')
const showRadarModal = ref(false)
const isClosingRadarModal = ref(false)
const radarChart = ref(null)
let chartInstance = null

const radarTabs = [
  { key: 'international', label: '国际闭源' },
  { key: 'domestic', label: '国产旗舰' },
  { key: 'opensource', label: '开源/特色' }
]

// 计算当前Tab标签
const currentRadarTabLabel = computed(() => {
  const tab = radarTabs.find(t => t.key === currentRadarTab.value)
  return tab ? tab.label : ''
})

// 打开雷达图弹窗
const openRadarModal = (tabKey) => {
  isClosingRadarModal.value = false
  currentRadarTab.value = tabKey
  showRadarModal.value = true
  nextTick(() => {
    initRadarChart()
  })
}

// 关闭雷达图弹窗
const closeRadarModal = () => {
  isClosingRadarModal.value = true
  // 等待动画完成后再关闭
  setTimeout(() => {
    showRadarModal.value = false
    isClosingRadarModal.value = false
    if (chartInstance) {
      chartInstance.dispose()
      chartInstance = null
    }
  }, 300)
}

// 雷达图维度
const radarIndicators = [
  { name: '通用能力', max: 100 },
  { name: '推理深度', max: 100 },
  { name: '多模态理解', max: 100 },
  { name: 'Agent能力', max: 100 },
  { name: '中文能力', max: 100 },
  { name: '成本效率', max: 100 }
]

// 雷达图数据
const radarData = {
  international: [
    { name: 'GPT-5.5 Pro', value: [96, 95, 88, 94, 82, 65], color: '#10a37f' },
    { name: 'Gemini 3.1 Pro', value: [94, 91, 97, 88, 85, 70], color: '#4285f4' },
    { name: 'Claude Opus 4.7', value: [93, 94, 85, 96, 78, 60], color: '#d97757' },
    { name: 'Grok 4.20 v2', value: [89, 88, 82, 90, 75, 75], color: '#1d9bf0' }
  ],
  domestic: [
    { name: '豆包 2.0 Pro', value: [86, 78, 95, 82, 92, 82], color: '#ff6b6b' },
    { name: 'DeepSeek V4 Pro', value: [92, 93, 80, 89, 94, 95], color: '#4ecdc4' },
    { name: 'Qwen3.5-397B', value: [91, 90, 91, 87, 95, 88], color: '#7b68ee' }
  ],
  opensource: [
    { name: 'GLM-5.1', value: [88, 86, 84, 91, 93, 85], color: '#3498db' },
    { name: 'Kimi K2.6', value: [87, 85, 78, 93, 91, 82], color: '#e74c3c' }
  ]
}

// 初始化雷达图
const initRadarChart = () => {
  if (!radarChart.value) return
  
  chartInstance = echarts.init(radarChart.value)
  updateRadarChart()
  
  window.addEventListener('resize', () => {
    chartInstance?.resize()
  })
}

// 更新雷达图
const updateRadarChart = () => {
  if (!chartInstance) return
  
  const currentData = radarData[currentRadarTab.value]
  const seriesData = currentData.map(item => ({
    value: item.value,
    name: item.name,
    lineStyle: { color: item.color },
    areaStyle: { 
      color: item.color,
      opacity: 0.15
    },
    itemStyle: { color: item.color },
    symbol: 'circle',
    symbolSize: 8
  }))
  
  const option = {
    backgroundColor: 'transparent',
    tooltip: {
      trigger: 'item',
      backgroundColor: 'rgba(20, 20, 35, 0.95)',
      borderColor: 'rgba(99, 102, 241, 0.3)',
      borderWidth: 1,
      textStyle: {
        color: '#fff',
        fontSize: 14
      },
      formatter: function(params) {
        let html = `<div style="font-weight:700;margin-bottom:8px;font-size:16px;color:${params.color}">${params.name}</div>`
        radarIndicators.forEach((indicator, index) => {
          html += `<div style="display:flex;justify-content:space-between;margin:4px 0;min-width:150px">
            <span style="color:#aaa">${indicator.name}:</span>
            <span style="font-weight:600;color:#fff">${params.value[index]}</span>
          </div>`
        })
        return html
      }
    },
    legend: {
      data: currentData.map(item => item.name),
      bottom: 0,
      textStyle: {
        color: '#e0e0e0',
        fontSize: 13
      },
      itemGap: 20,
      itemWidth: 16,
      itemHeight: 16
    },
    radar: {
      indicator: radarIndicators,
      center: ['50%', '45%'],
      radius: '60%',
      axisName: {
        color: '#b0b0c0',
        fontSize: 13,
        fontWeight: 500
      },
      splitArea: {
        areaStyle: {
          color: ['rgba(99, 102, 241, 0.02)', 'rgba(99, 102, 241, 0.05)', 
                  'rgba(99, 102, 241, 0.08)', 'rgba(99, 102, 241, 0.11)']
        }
      },
      axisLine: {
        lineStyle: {
          color: 'rgba(99, 102, 241, 0.2)'
        }
      },
      splitLine: {
        lineStyle: {
          color: 'rgba(99, 102, 241, 0.15)'
        }
      }
    },
    series: [{
      type: 'radar',
      data: seriesData,
      emphasis: {
        lineStyle: {
          width: 3
        },
        areaStyle: {
          opacity: 0.3
        }
      }
    }]
  }
  
  chartInstance.setOption(option, true)
}
</script>

<style scoped>
.about {
  background: var(--bg-dark);
  position: relative;
  z-index: 20;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

/* About页面使用更宽的容器 */
.about-container {
  max-width: 1400px;
  width: 100%;
}

/* 关于我部分样式 */
.about-content {
  display: grid;
  grid-template-columns: 1fr 1.5fr;
  gap: 60px;
  align-items: start;
  margin-bottom: 80px;
}

.about-image {
  position: relative;
}

.image-wrapper {
  position: relative;
  display: inline-block;
  border-radius: 20px;
  overflow: hidden;
}

.profile-photo {
  width: 350px;
  height: 450px;
  object-fit: cover;
  border-radius: 20px;
  display: block;
}

.image-wrapper::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    to bottom,
    transparent 70%,
    var(--bg-primary) 100%
  );
  pointer-events: none;
}

.image-wrapper::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  border-radius: 20px;
  box-shadow: inset 0 0 60px rgba(99, 102, 241, 0.3);
  pointer-events: none;
  z-index: 1;
}

.about-title {
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 20px;
  line-height: 1.4;
}

.about-description {
  color: var(--text-secondary);
  font-size: 1.1rem;
  margin-bottom: 16px;
  line-height: 1.8;
}

/* AI发展史时间轴样式 */
.ai-timeline-section {
  padding-top: 80px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

/* 大模型雷达图样式 */
.model-radar-section {
  padding-top: 40px;
  margin-top: 20px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.radar-section-title {
  margin-top: 0;
  color: #2d2d3a;
  background: none;
  -webkit-background-clip: unset;
  -webkit-text-fill-color: unset;
  background-clip: unset;
}

.radar-section-subtitle {
  margin-bottom: 40px;
  color: #4a4a5a;
}

/* Tab 切换样式 */
.radar-tabs {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-bottom: 40px;
  flex-wrap: wrap;
}

.radar-tab {
  padding: 14px 32px;
  border: 1px solid rgba(200, 200, 220, 0.5);
  border-radius: 30px;
  background: linear-gradient(
    135deg,
    rgba(240, 240, 245, 0.7) 0%,
    rgba(220, 220, 230, 0.4) 100%
  );
  color: #2d2d3a;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow:
    0 4px 20px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  position: relative;
  overflow: hidden;
}

.radar-tab::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(
    90deg,
    transparent,
    rgba(255, 255, 255, 0.5),
    transparent
  );
  transition: left 0.6s ease;
}

.radar-tab:hover::before {
  left: 100%;
}

.radar-tab:hover {
  background: linear-gradient(
    135deg,
    rgba(250, 250, 255, 0.85) 0%,
    rgba(230, 230, 240, 0.5) 100%
  );
  border-color: rgba(180, 180, 200, 0.7);
  transform: translateY(-3px) scale(1.02);
  box-shadow:
    0 8px 30px rgba(99, 102, 241, 0.12),
    inset 0 1px 0 rgba(255, 255, 255, 0.9);
}

.radar-tab:active {
  transform: translateY(-1px) scale(0.98);
  box-shadow:
    0 4px 15px rgba(99, 102, 241, 0.08),
    inset 0 1px 0 rgba(255, 255, 255, 0.7);
}

/* 雷达图弹窗样式 */
.radar-modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0);
  backdrop-filter: blur(0px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  padding: 20px;
  animation: radarOverlayFadeIn 0.4s ease forwards;
}

@keyframes radarOverlayFadeIn {
  from {
    background: rgba(0, 0, 0, 0);
    backdrop-filter: blur(0px);
  }
  to {
    background: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(8px);
  }
}

.radar-modal-overlay.closing {
  animation: radarOverlayFadeOut 0.3s ease forwards;
}

@keyframes radarOverlayFadeOut {
  from {
    background: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(8px);
  }
  to {
    background: rgba(0, 0, 0, 0);
    backdrop-filter: blur(0px);
  }
}

.radar-modal {
  background: #ffffff;
  border-radius: 24px;
  padding: 40px;
  width: 100%;
  max-width: 700px;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3);
  opacity: 0;
  transform: translateX(100px);
  animation: radarModalSlideIn 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

@keyframes radarModalSlideIn {
  from {
    opacity: 0;
    transform: translateX(100px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.radar-modal-overlay.closing .radar-modal {
  animation: radarModalSlideOut 0.3s cubic-bezier(0.4, 0, 0.2, 1) forwards;
}

@keyframes radarModalSlideOut {
  from {
    opacity: 1;
    transform: translateX(0);
  }
  to {
    opacity: 0;
    transform: translateX(100px);
  }
}

.radar-modal-close {
  position: absolute;
  top: 20px;
  right: 25px;
  width: 36px;
  height: 36px;
  border: none;
  background: rgba(0, 0, 0, 0.08);
  border-radius: 50%;
  font-size: 24px;
  color: #666;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.radar-modal-close:hover {
  background: rgba(0, 0, 0, 0.15);
  color: #333;
  transform: rotate(90deg);
}

.radar-modal-title {
  text-align: center;
  font-size: 1.5rem;
  font-weight: 700;
  color: #2d2d3a;
  margin-bottom: 30px;
  margin-top: 0;
}

.radar-modal-chart-container {
  width: 100%;
  padding: 20px;
  background: rgba(20, 20, 35, 0.05);
  border-radius: 16px;
}

.radar-modal .radar-chart {
  width: 100%;
  height: 450px;
}

.radar-modal-note {
  text-align: center;
  color: #888;
  font-size: 0.8rem;
  margin-top: 20px;
  margin-bottom: 0;
  font-style: italic;
}

.ai-section-title {
  margin-top: 0;
}

.ai-section-subtitle {
  margin-bottom: 50px;
}

/* 横向时间轴容器 */
.timeline-container {
  width: 100%;
  overflow: visible;
  padding: 80px 20px 120px;
}

/* 时间轴轨道 */
.timeline-track {
  display: flex;
  align-items: flex-start;
  justify-content: center;
  gap: 0;
  padding: 0;
  position: relative;
  margin: 0 auto;
  max-width: 1200px;
}

/* 彩虹连接线 - 贯穿整个时间轴 */
.timeline-track::before {
  content: '';
  position: absolute;
  top: 63px;
  left: 10%;
  right: 10%;
  height: 4px;
  background: linear-gradient(90deg, 
    #667eea 0%, 
    #764ba2 12%, 
    #f093fb 24%, 
    #f5576c 36%, 
    #4facfe 48%, 
    #00f2fe 60%, 
    #43e97b 72%, 
    #38f9d7 84%, 
    #fa709a 100%
  );
  border-radius: 2px;
  box-shadow: 0 0 20px rgba(99, 102, 241, 0.3);
  z-index: 1;
}

/* 时间轴节点 */
.timeline-node {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  padding: 0 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  z-index: 2;
  flex: 1;
  max-width: 140px;
}

.timeline-node:first-child {
  padding-left: 25px;
}

.timeline-node:last-child {
  padding-right: 25px;
}

.timeline-node:hover {
  transform: translateY(-8px);
}

.timeline-node:hover .timeline-dot {
  transform: scale(1.4);
  box-shadow: 0 0 0 4px var(--dot-color), 0 0 30px var(--dot-color), 0 0 60px var(--dot-color);
}

.timeline-node:hover .timeline-year {
  transform: translateY(-5px);
  text-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* 年份标签 */
.timeline-year {
  font-size: 1.3rem;
  font-weight: 900;
  color: #2d2d3a;
  margin-bottom: 20px;
  font-family: 'Courier New', monospace;
  letter-spacing: 2px;
  transition: all 0.3s ease;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  background: linear-gradient(135deg, #2d2d3a 0%, #4a4a5a 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* 时间节点圆点 */
.timeline-dot {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: var(--dot-color);
  border: 5px solid #ffffff;
  box-shadow: 0 0 0 3px var(--dot-color), 0 6px 20px rgba(0, 0, 0, 0.25);
  transition: all 0.3s ease;
  z-index: 3;
}

/* 移除原来的连接线样式 */
.timeline-line {
  display: none;
}

/* 时间轴卡片 */
.timeline-card {
  position: absolute;
  top: 100px;
  left: 50%;
  transform: translateX(-50%) translateY(10px);
  width: 380px;
  background: #ffffff;
  border: 2px solid rgba(0, 0, 0, 0.08);
  border-radius: 20px;
  padding: 28px;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  z-index: 10;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
  pointer-events: none;
}

.timeline-node:hover .timeline-card {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(0);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
  pointer-events: auto;
}

.timeline-card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.timeline-event {
  font-size: 1.2rem;
  font-weight: 700;
  color: #1a1a2e;
}

.timeline-tag {
  padding: 6px 14px;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
  color: #1a1a2e;
}

.timeline-detail {
  font-size: 0.95rem;
  color: #4a4a5a;
  line-height: 1.7;
  margin-bottom: 12px;
}

.timeline-quote {
  font-size: 0.95rem;
  color: #4a4a5a;
  font-weight: 500;
  font-style: italic;
  line-height: 1.5;
  margin-bottom: 10px;
  padding-left: 12px;
  border-left: 3px solid var(--primary-color);
}

.timeline-significance {
  font-size: 0.9rem;
  color: #6a6a7a;
  font-weight: 600;
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
  position: absolute;
  top: 20px;
  right: 20px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: var(--text-secondary);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  z-index: 10;
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  color: var(--text-primary);
}

.modal-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 32px;
  padding-bottom: 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-icon {
  width: 60px;
  height: 60px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  flex-shrink: 0;
}

.modal-title {
  font-size: 1.8rem;
  font-weight: 600;
  margin-bottom: 4px;
}

.modal-subtitle {
  color: var(--text-muted);
  font-size: 1rem;
}

/* 信息网格 */
.info-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.info-item {
  background: rgba(255, 255, 255, 0.05);
  padding: 16px 20px;
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.info-label {
  font-size: 0.85rem;
  color: var(--text-muted);
}

.info-value {
  font-size: 1rem;
  font-weight: 500;
}

/* 时间轴样式 */
.timeline {
  position: relative;
  padding-left: 30px;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 2px;
  background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%);
}

.timeline-item {
  position: relative;
  padding-bottom: 24px;
  padding-left: 24px;
}

.timeline-item:last-child {
  padding-bottom: 0;
}

.timeline-marker {
  position: absolute;
  left: -36px;
  top: 0;
  width: 46px;
  height: 46px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
}

.timeline-year {
  color: white;
  font-weight: 700;
  font-size: 0.7rem;
}

.timeline-content {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  padding: 16px 20px;
}

.timeline-title {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 6px;
}

.timeline-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.5;
}

/* 大模型列表 */
.models-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.model-detail-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  padding: 20px;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.model-detail-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 12px;
}

.model-detail-icon {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 0.85rem;
  flex-shrink: 0;
}

.model-detail-name {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 2px;
}

.model-detail-company {
  font-size: 0.85rem;
  color: var(--text-muted);
}

.model-detail-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.6;
  margin-bottom: 12px;
}

.model-detail-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.model-detail-tag {
  padding: 4px 12px;
  background: rgba(99, 102, 241, 0.15);
  color: var(--primary-color);
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 500;
}

/* 智能体列表 */
.agents-list {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.agent-detail-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  padding: 24px;
  text-align: center;
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.agent-detail-icon {
  font-size: 2.5rem;
  margin-bottom: 12px;
}

.agent-detail-name {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 8px;
}

.agent-detail-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.5;
}

@media (max-width: 968px) {
  .about-content {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  
  .about-image {
    text-align: center;
  }
  
  .profile-photo {
    width: 280px;
    height: 360px;
  }
  
  .about-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .agents-list {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .about {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .about-content {
    gap: 30px;
    margin-bottom: 60px;
  }
  
  .profile-photo {
    width: 200px;
    height: 260px;
  }
  
  .about-title {
    font-size: 1.4rem;
  }
  
  .about-text {
    font-size: 0.95rem;
    line-height: 1.7;
  }
  
  .ai-timeline-section {
    padding-top: 50px;
  }

  .timeline-container {
    padding: 60px 10px 100px;
  }

  .timeline-track {
    padding: 0;
    max-width: 100%;
  }

  .timeline-track::before {
    left: 5%;
    right: 5%;
    top: 58px;
    height: 3px;
  }

  .timeline-node {
    padding: 0 8px;
    max-width: none;
    flex: 1;
  }

  .timeline-node:first-child {
    padding-left: 8px;
  }

  .timeline-node:last-child {
    padding-right: 8px;
  }

  .timeline-year {
    font-size: 0.9rem;
    margin-bottom: 16px;
    letter-spacing: 0.5px;
  }

  .timeline-dot {
    width: 16px;
    height: 16px;
    border: 3px solid #ffffff;
  }

  .timeline-card {
    width: 280px;
    padding: 18px;
    top: 85px;
  }

  .timeline-event {
    font-size: 0.95rem;
  }

  .timeline-detail {
    font-size: 0.85rem;
  }

  .timeline-quote {
    font-size: 0.8rem;
  }

  /* 雷达图移动端样式 */
  .model-radar-section {
    padding-top: 30px;
    margin-top: 15px;
  }

  .radar-tabs {
    gap: 10px;
    margin-bottom: 30px;
  }

  .radar-tab {
    padding: 10px 20px;
    font-size: 0.9rem;
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
  }

  .radar-modal {
    padding: 30px 20px;
    border-radius: 20px;
  }

  .radar-modal-close {
    top: 15px;
    right: 15px;
    width: 32px;
    height: 32px;
    font-size: 20px;
  }

  .radar-modal-title {
    font-size: 1.2rem;
    margin-bottom: 20px;
  }

  .radar-modal-chart-container {
    padding: 15px;
  }

  .radar-modal .radar-chart {
    height: 350px;
  }

  .radar-modal-note {
    font-size: 0.75rem;
    padding: 0 10px;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .timeline {
    padding-left: 20px;
  }

  .timeline-marker {
    left: -26px;
    width: 36px;
    height: 36px;
  }

  .timeline-year {
    font-size: 0.6rem;
  }
}
</style>
