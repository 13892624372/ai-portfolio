<template>
  <section class="section model-radar">
    <div class="container radar-container">
      <h2 class="section-title">主流大模型能力对比</h2>
      <p class="section-subtitle">多维度评估主流AI模型的综合能力</p>
      
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
import { ref, computed, nextTick } from 'vue'
import * as echarts from 'echarts'

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
.model-radar {
  background: var(--bg-dark);
  position: relative;
  z-index: 20;
  width: 80vw;
  height: 100vh;
  overflow: hidden;
}

.radar-container {
  height: 100%;
  display: flex;
  flex-direction: column;
  padding-top: 80px;
}

.section-title {
  font-size: 2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 6px;
  color: #2d2d3a;
  background: none;
  -webkit-background-clip: unset;
  -webkit-text-fill-color: unset;
  background-clip: unset;
  flex-shrink: 0;
  margin-top: 10vh;
}

.section-subtitle {
  font-size: 1rem;
  text-align: center;
  color: #4a4a5a;
  margin-bottom: 40px;
  flex-shrink: 0;
}

/* Tab 切换样式 */
.radar-tabs {
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-wrap: wrap;
  flex: 1;
  align-items: center;
}

.radar-tab {
  padding: 16px 40px;
  border: 1px solid rgba(200, 200, 220, 0.5);
  border-radius: 30px;
  background: linear-gradient(
    135deg,
    rgba(240, 240, 245, 0.7) 0%,
    rgba(220, 220, 230, 0.4) 100%
  );
  color: #2d2d3a;
  font-size: 1.1rem;
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

@media (max-width: 768px) {
  .model-radar {
    padding-top: 60px;
  }
  
  .section-title {
    font-size: 1.6rem;
  }
  
  .section-subtitle {
    font-size: 0.9rem;
    margin-bottom: 40px;
  }
  
  .radar-tabs {
    gap: 12px;
  }
  
  .radar-tab {
    padding: 12px 24px;
    font-size: 0.95rem;
  }
  
  .radar-modal {
    padding: 30px 20px;
  }
  
  .radar-modal .radar-chart {
    height: 350px;
  }
}
</style>
