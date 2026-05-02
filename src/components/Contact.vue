<template>
  <section id="contact" class="section contact">
    <div class="container">
      <h2 class="section-title">联系我</h2>
      <p class="section-subtitle">期待与您的合作与交流，我会尽快回复您的消息</p>
      
      <div class="contact-content">
        <div class="contact-info">
          
          <div class="contact-methods">
            <div class="contact-item">
              <div class="contact-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="2" y="4" width="20" height="16" rx="2"/>
                  <path d="M2 6l10 7 10-7"/>
                </svg>
              </div>
              <div class="contact-detail">
                <span class="contact-label">邮箱</span>
                <a href="mailto:13892624372@163.com" class="contact-value">13892624372@163.com</a>
              </div>
            </div>

            <div class="contact-item">
              <div class="contact-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
              </div>
              <div class="contact-detail">
                <span class="contact-label">电话</span>
                <span class="contact-value">+86 13892624372</span>
              </div>
            </div>

            <div class="contact-item contact-item-clickable" @click="openMap">
              <div class="contact-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z"/>
                  <circle cx="12" cy="9" r="2.5"/>
                </svg>
              </div>
              <div class="contact-detail">
                <span class="contact-label">地址</span>
                <span class="contact-value contact-value-link">西安市雁塔区</span>
                <span class="contact-hint">支持点击查看我的详细位置</span>
              </div>
            </div>
          </div>
          
        </div>
      </div>
    </div>
    
    <!-- 地图弹窗 -->
    <div class="map-modal-overlay" v-if="showMap" @click="closeMap">
      <div class="map-modal-content" @click.stop>
        <div class="map-modal-header">
          <h3>我的位置</h3>
          <button class="map-modal-close" @click="closeMap">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        <div class="map-container" ref="mapContainer"></div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const showMap = ref(false)
const mapContainer = ref(null)
let map = null
let marker = null

// 高德地图Key
const MAP_KEY = '1e0d8f4704cf242be33f1a916da8d461'

const openMap = () => {
  showMap.value = true
  // 等待DOM更新后初始化地图
  setTimeout(() => {
    initMap()
  }, 100)
}

const closeMap = () => {
  showMap.value = false
  // 清理地图实例，以便下次重新创建
  if (map) {
    map.destroy()
    map = null
    marker = null
  }
}

const initMap = () => {
  if (!mapContainer.value) return
  
  // 如果地图已存在，先销毁
  if (map) {
    map.destroy()
    map = null
    marker = null
  }
  
  // 检查高德地图API是否已加载
  if (!window.AMap) {
    loadAMapScript().then(() => {
      createMap()
    })
  } else {
    createMap()
  }
}

// 目标地址和坐标（南窑头社区西区的精确坐标）
const TARGET_ADDRESS = '西安市雁塔区南窑头社区西区'
const TARGET_COORDINATES = [108.8795, 34.218] // 南窑头社区西区的精确坐标（向东回调400米）

const loadAMapScript = () => {
  return new Promise((resolve, reject) => {
    if (window.AMap) {
      resolve()
      return
    }
    
    // 使用JSAPI Loader方式加载
    const script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = `https://webapi.amap.com/loader.js`
    script.onerror = reject
    script.onload = () => {
      window.AMapLoader.load({
        key: MAP_KEY,
        version: '2.0',
        plugins: ['AMap.Geocoder', 'AMap.Marker', 'AMap.InfoWindow']
      }).then(() => {
        resolve()
      }).catch(reject)
    }
    document.head.appendChild(script)
  })
}

const createMap = () => {
  if (!mapContainer.value || !window.AMap) {
    console.error('地图容器或AMap未准备好')
    return
  }
  
  try {
    // 创建地图实例，直接使用精确坐标
    map = new window.AMap.Map(mapContainer.value, {
      zoom: 16,
      center: TARGET_COORDINATES,
      viewMode: '2D'
    })
    
    // 添加标记点
    marker = new window.AMap.Marker({
      position: TARGET_COORDINATES,
      title: TARGET_ADDRESS
    })
    
    marker.setMap(map)
    
    // 添加信息窗体
    const infoWindow = new window.AMap.InfoWindow({
      content: `<div style="padding: 8px 12px; font-size: 14px; color: #333;">${TARGET_ADDRESS}</div>`,
      offset: new window.AMap.Pixel(0, -30)
    })
    
    marker.on('click', () => {
      infoWindow.open(map, marker.getPosition())
    })
    
    // 自动打开信息窗体
    infoWindow.open(map, marker.getPosition())
    
  } catch (error) {
    console.error('创建地图时出错:', error)
  }
}

// 清理地图实例
onUnmounted(() => {
  if (map) {
    map.destroy()
    map = null
  }
})
</script>

<style scoped>
.contact {
  background: linear-gradient(180deg, var(--bg-dark) 0%, var(--bg-card) 100%);
}

.contact-content {
  display: flex;
  justify-content: center;
  max-width: 1200px;
  margin: 0 auto;
}

.contact-info {
  text-align: center;
}

.info-description {
  color: var(--text-secondary);
  line-height: 1.8;
  margin-bottom: 40px;
}

.contact-methods {
  margin-bottom: 40px;
  display: flex;
  justify-content: center;
  gap: 40px;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 12px;
}

.contact-icon {
  width: 50px;
  height: 50px;
  background: rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #374151;
}

.contact-detail {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.contact-label {
  font-size: 0.85rem;
  color: var(--text-muted);
  margin-bottom: 2px;
}

.contact-value {
  font-size: 1rem;
  color: var(--text-primary);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s ease;
}

.contact-value:hover {
  color: var(--primary-color);
}

.contact-hint {
  font-size: 0.9rem;
  color: var(--text-muted);
  margin-top: 2px;
}

/* 地图弹窗样式 */
.map-modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}

.map-modal-content {
  background: var(--bg-card);
  border-radius: 16px;
  width: 90%;
  max-width: 800px;
  height: 80vh;
  max-height: 600px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
}

.map-modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  border-bottom: 1px solid var(--border-color);
}

.map-modal-header h3 {
  margin: 0;
  color: var(--text-primary);
  font-size: 1.25rem;
}

.map-modal-close {
  background: none;
  border: none;
  color: var(--text-secondary);
  cursor: pointer;
  padding: 8px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.map-modal-close:hover {
  background: var(--bg-dark);
  color: var(--text-primary);
}

.map-container {
  flex: 1;
  width: 100%;
  min-height: 400px;
}

/* 可点击的地址样式 */
.contact-item-clickable {
  cursor: pointer;
  transition: all 0.3s ease;
}

.contact-item-clickable:hover .contact-icon {
  background: rgba(99, 102, 241, 0.25);
}

.contact-value-link {
  color: var(--primary-color);
  text-decoration: underline;
  text-decoration-color: transparent;
  transition: all 0.3s ease;
}

.contact-value-link:hover {
  text-decoration-color: var(--primary-color);
}

@media (max-width: 968px) {
  .contact-content {
    padding: 0 20px;
  }
}

@media (max-width: 768px) {
  .contact {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .contact-methods {
    flex-direction: column;
    gap: 20px;
    align-items: center;
  }
  
  .contact-item {
    width: 100%;
    max-width: 280px;
    justify-content: flex-start;
  }
  
  .contact-grid {
    grid-template-columns: 1fr;
    gap: 16px;
  }
  
  .contact-card {
    padding: 16px;
  }
  
  .contact-icon {
    width: 44px;
    height: 44px;
  }
  
  .contact-label {
    font-size: 0.8rem;
  }
  
  .contact-value {
    font-size: 0.95rem;
  }
}
</style>
