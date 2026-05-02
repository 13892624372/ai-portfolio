<template>
  <section class="section about-ai">
    <div class="container">
      <h2 class="section-title">关于AI</h2>
      <p class="section-subtitle">从图灵测试到智能体时代的技术演进</p>
      
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
  </section>
</template>

<script setup>
import { ref } from 'vue'

// 当前激活的时间轴索引
const activeTimelineIndex = ref(null)

// AI发展历史时间轴数据
const aiHistoryTimeline = ref([
  {
    year: '1950',
    event: '图灵测试',
    quote: '机器能思考吗？',
    significance: '起点',
    detail: '艾伦·图灵提出著名的"图灵测试"，为判断机器是否具有智能提供了标准。这是人工智能概念的哲学起点。',
    color: '#667eea',
    tagColor: 'rgba(102, 126, 234, 0.2)',
    tag: '起点'
  },
  {
    year: '1956',
    event: '达特茅斯会议',
    quote: '人工智能概念正式诞生',
    significance: '学科成立',
    detail: '约翰·麦卡锡等科学家首次提出"人工智能"术语，确立了AI作为独立学科的地位。',
    color: '#764ba2',
    tagColor: 'rgba(118, 75, 162, 0.2)',
    tag: '学科成立'
  },
  {
    year: '1997',
    event: '深蓝战胜卡斯帕罗夫',
    quote: '算力首次击败人类',
    significance: '算力突破',
    detail: 'IBM深蓝超级计算机击败国际象棋冠军，证明了暴力计算结合启发式搜索的强大威力。',
    color: '#f093fb',
    tagColor: 'rgba(240, 147, 251, 0.2)',
    tag: '算力突破'
  },
  {
    year: '2012',
    event: 'AlexNet',
    quote: '深度学习时代开启',
    significance: '深度学习',
    detail: 'AlexNet在ImageNet竞赛中获胜，将图像识别错误率大幅降低，开启了深度学习革命。',
    color: '#f5576c',
    tagColor: 'rgba(245, 87, 108, 0.2)',
    tag: '深度学习'
  },
  {
    year: '2016',
    event: 'AlphaGo',
    quote: '攻克围棋堡垒',
    significance: '认知破圈',
    detail: 'DeepMind的AlphaGo击败围棋世界冠军，震惊全球，AI能力获得广泛认知。',
    color: '#4facfe',
    tagColor: 'rgba(79, 172, 254, 0.2)',
    tag: '认知破圈'
  },
  {
    year: '2017',
    event: 'Transformer',
    quote: '大模型技术基石',
    significance: '技术基石',
    detail: 'Google提出Transformer架构，其自注意力机制成为GPT、BERT等大模型的核心技术基础。',
    color: '#00f2fe',
    tagColor: 'rgba(0, 242, 254, 0.2)',
    tag: '技术基石'
  },
  {
    year: '2022',
    event: 'ChatGPT',
    quote: 'AI大众化元年',
    significance: '大众化',
    detail: 'OpenAI发布ChatGPT，两个月用户破1亿，让普通大众第一次直观感受到AI的强大。',
    color: '#43e97b',
    tagColor: 'rgba(67, 233, 123, 0.2)',
    tag: '大众化'
  },
  {
    year: '2024',
    event: 'AI Agent',
    quote: '从对话到行动',
    significance: 'Agent时代',
    detail: 'AI开始具备规划、记忆、工具使用等能力，能够自主完成复杂任务，迈向AGI的重要一步。',
    color: '#38f9d7',
    tagColor: 'rgba(56, 249, 215, 0.2)',
    tag: 'Agent时代'
  },
  {
    year: '2025+',
    event: '多模态+Agent',
    quote: 'AI成为系统',
    significance: '当前趋势',
    detail: '多模态模型展现强大能力，推理成本下降，AI从单点工具演变为智能系统。',
    color: '#fa709a',
    tagColor: 'rgba(250, 112, 154, 0.2)',
    tag: '当前趋势'
  }
])
</script>

<style scoped>
.about-ai {
  background: var(--bg-dark);
  position: relative;
  z-index: 20;
  height: 100vh;
  width: 110vw;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.about-ai .container {
  max-width: 1000px;
  width: 100%;
  margin: 0 auto;
  padding: 0 40px;
}

.section-title {
  font-size: 2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 6px;
  color: var(--text-primary);
}

.section-subtitle {
  font-size: 1rem;
  text-align: center;
  color: var(--text-secondary);
  margin-bottom: 30px;
}

/* 横向时间轴容器 */
.timeline-container {
  width: 100%;
  padding: 40px 20px;
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
  max-width: 1100px;
}

/* 彩虹连接线 - 贯穿整个时间轴 */
.timeline-track::before {
  content: '';
  position: absolute;
  top: 50px;
  left: 5%;
  right: 5%;
  height: 3px;
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
  box-shadow: 0 0 15px rgba(99, 102, 241, 0.3);
  z-index: 1;
}

/* 时间轴节点 */
.timeline-node {
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
  padding: 0 15px;
  cursor: pointer;
  transition: all 0.3s ease;
  z-index: 2;
  flex: 1;
  max-width: 120px;
}

.timeline-node:first-child {
  padding-left: 15px;
}

.timeline-node:last-child {
  padding-right: 15px;
}

.timeline-node:hover {
  transform: translateY(-5px);
}

.timeline-node:hover .timeline-dot {
  transform: scale(1.3);
  box-shadow: 0 0 0 3px var(--dot-color), 0 0 20px var(--dot-color);
}

.timeline-node:hover .timeline-year {
  transform: translateY(-3px);
}

/* 年份标签 */
.timeline-year {
  font-size: 1rem;
  font-weight: 700;
  color: #2d2d3a;
  margin-bottom: 12px;
  font-family: 'Courier New', monospace;
  letter-spacing: 1px;
  transition: all 0.3s ease;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
  background: linear-gradient(135deg, #2d2d3a 0%, #4a4a5a 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* 时间节点圆点 */
.timeline-dot {
  width: 18px;
  height: 18px;
  border-radius: 50%;
  background: var(--dot-color);
  border: 4px solid #ffffff;
  box-shadow: 0 0 0 2px var(--dot-color), 0 4px 12px rgba(0, 0, 0, 0.2);
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
  top: 80px;
  left: 50%;
  transform: translateX(-50%) translateY(10px);
  width: 280px;
  background: #ffffff;
  border: 1px solid rgba(0, 0, 0, 0.06);
  border-radius: 16px;
  padding: 18px;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  z-index: 10;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
  pointer-events: none;
}

.timeline-node:hover .timeline-card {
  opacity: 1;
  visibility: visible;
  transform: translateX(-50%) translateY(0);
  box-shadow: 0 15px 45px rgba(0, 0, 0, 0.2);
  pointer-events: auto;
}

.timeline-card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
  padding-bottom: 8px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.timeline-event {
  font-size: 1rem;
  font-weight: 700;
  color: #1a1a2e;
}

.timeline-tag {
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
  color: #1a1a2e;
}

.timeline-detail {
  font-size: 0.85rem;
  color: #4a4a5a;
  line-height: 1.6;
  margin-bottom: 8px;
}

.timeline-quote {
  font-size: 0.8rem;
  color: #5a5a6a;
  font-weight: 500;
  font-style: italic;
  line-height: 1.4;
  margin: 0;
  padding-left: 10px;
  border-left: 2px solid var(--primary-color);
}

@media (max-width: 768px) {
  .about-ai {
    padding-top: 60px;
  }
  
  .section-title {
    font-size: 1.6rem;
  }
  
  .section-subtitle {
    font-size: 0.9rem;
    margin-bottom: 20px;
  }
  
  .timeline-container {
    padding: 30px 10px;
  }
  
  .timeline-year {
    font-size: 0.85rem;
  }
  
  .timeline-dot {
    width: 14px;
    height: 14px;
    border-width: 3px;
  }
  
  .timeline-card {
    width: 240px;
    padding: 14px;
  }
  
  .timeline-event {
    font-size: 0.9rem;
  }
}
</style>
