<template>
  <section id="hero" class="hero">
    <div class="hero-bg">
      <div class="gradient-orb orb-1"></div>
      <div class="gradient-orb orb-2"></div>
      <div class="gradient-orb orb-3"></div>
    </div>

    <!-- 音乐播放器 -->
    <div class="music-player" v-if="showMusicPlayer" ref="musicPlayerRef">
      <!-- 主按钮 -->
      <button class="music-btn" @click="toggleMusicPanel" :class="{ active: showPanel || isPlaying }">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M9 18V5l12-2v13"></path>
          <circle cx="6" cy="18" r="3"></circle>
          <circle cx="18" cy="16" r="3"></circle>
        </svg>
        <span class="music-text">{{ isPlaying ? currentSong.name : '来首歌缓解疲劳？' }}</span>
      </button>

      <!-- 歌曲列表面板 -->
      <div class="music-panel" v-if="showPanel" @click.stop>
        <div class="music-panel-header">
          <span>选择背景音乐</span>
          <button class="close-panel" @click="showPanel = false">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        <div class="volume-tip">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M11 5L6 9H2v6h4l5 4V5z"></path>
            <path d="M19.07 4.93a10 10 0 0 1 0 14.14M15.54 8.46a5 5 0 0 1 0 7.07"></path>
          </svg>
          <span>请注意调节音量</span>
        </div>
        <div class="song-list">
          <div
            v-for="(song, index) in songs"
            :key="index"
            class="song-item"
            :class="{ active: currentIndex === index, playing: currentIndex === index && isPlaying }"
            @click="playSong(index)"
          >
            <div class="song-number">{{ index + 1 }}</div>
            <div class="song-info">
              <div class="song-name">{{ song.name }}</div>
            </div>
            <div class="song-status">
              <svg v-if="currentIndex === index && isPlaying" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                <rect x="6" y="4" width="4" height="16"></rect>
                <rect x="14" y="4" width="4" height="16"></rect>
              </svg>
              <svg v-else width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polygon points="5 3 19 12 5 21 5 3"></polygon>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <audio ref="audioPlayer" @ended="playNext" @timeupdate="updateProgress">
        <source :src="currentSong.url" :type="currentSong.type">
      </audio>
    </div>

    <div class="container">
      <div class="hero-content">
        <div class="hero-badge">
          <span class="badge-dot"></span>
          专注于让AI创造价值
        </div>
        
        <h1 class="hero-title">
          Hey！我是
          <span class="name">田雨</span>
        </h1>
        
        <p class="hero-description">
          技术出身的AI产品经理候选人。我相信，优秀的产品经理不仅要懂用户、懂业务，
          更要懂技术实现的可能性与边界。用工程思维解构需求，用产品思维创造价值，
          在AI时代打造真正解决痛点的产品。
        </p>
        

      </div>
      
      <div class="scroll-indicator">
        <div class="mouse">
          <div class="wheel"></div>
        </div>
        <span>向下滚动</span>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'

const showMusicPlayer = ref(false)
const isPlaying = ref(false)
const audioPlayer = ref(null)
const showPanel = ref(false)
const currentIndex = ref(0)
const musicPlayerRef = ref(null)

// 歌曲列表 - 支持多首歌曲循环播放
const songs = [
  { name: 'Sorry', url: '/ai-portfolio/music/Sorry.mp3', type: 'audio/mpeg' },
  { name: 'Peaches', url: '/ai-portfolio/music/Peaches.mp3', type: 'audio/mpeg' },
  { name: 'The Cure', url: '/ai-portfolio/music/The%20Cure.mp3', type: 'audio/mpeg' },
  { name: 'Dead Man', url: '/ai-portfolio/music/Dead%20Man.mp3', type: 'audio/mpeg' },
  { name: 'Colder', url: '/ai-portfolio/music/Colder.mp3', type: 'audio/mpeg' }
]

const currentSong = computed(() => songs[currentIndex.value])

onMounted(() => {
  // 延迟显示音乐按钮，避免页面加载时过于突兀
  setTimeout(() => {
    showMusicPlayer.value = true
  }, 2000)

  // 点击外部关闭音乐面板
  document.addEventListener('click', handleClickOutside)
})

const handleClickOutside = (event) => {
  if (musicPlayerRef.value && !musicPlayerRef.value.contains(event.target) && showPanel.value) {
    showPanel.value = false
  }
}

const toggleMusicPanel = () => {
  showPanel.value = !showPanel.value
}

const playSong = (index) => {
  if (currentIndex.value === index) {
    // 点击当前歌曲，暂停/继续播放
    if (isPlaying.value) {
      // 正在播放，则暂停
      audioPlayer.value.pause()
      isPlaying.value = false
    } else {
      // 已暂停，则继续播放（不重新加载）
      audioPlayer.value.play().catch(err => {
        console.log('音频播放失败:', err)
        isPlaying.value = false
      })
      isPlaying.value = true
    }
  } else {
    // 播放新歌曲
    currentIndex.value = index
    isPlaying.value = true
    // 等待DOM更新后播放
    setTimeout(() => {
      audioPlayer.value.load()
      audioPlayer.value.play().catch(err => {
        console.log('音频播放失败:', err)
        isPlaying.value = false
      })
    }, 0)
  }
}

const playNext = () => {
  // 自动循环播放下一首
  currentIndex.value = (currentIndex.value + 1) % songs.length
  // 使用 nextTick 确保 DOM 更新后再播放
  setTimeout(() => {
    if (audioPlayer.value) {
      audioPlayer.value.load()
      audioPlayer.value.play().catch(err => {
        console.log('自动播放下一首失败:', err)
        isPlaying.value = false
      })
    }
  }, 0)
}

const updateProgress = () => {
  // 可以在这里更新进度条
}

onUnmounted(() => {
  if (audioPlayer.value) {
    audioPlayer.value.pause()
  }
  document.removeEventListener('click', handleClickOutside)
})
</script>

<style scoped>
.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  position: relative;
  overflow: hidden;
  padding-top: 80px;
  background: var(--bg-dark);
}

.hero-bg {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 0;
}

.gradient-orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.5;
}

.orb-1 {
  width: 500px;
  height: 500px;
  background: var(--primary-color);
  top: -200px;
  right: -100px;
  animation: float 8s ease-in-out infinite;
}

.orb-2 {
  width: 400px;
  height: 400px;
  background: var(--secondary-color);
  bottom: -150px;
  left: -100px;
  animation: float 10s ease-in-out infinite reverse;
}

.orb-3 {
  width: 300px;
  height: 300px;
  background: var(--accent-color);
  top: 50%;
  left: 30%;
  transform: translate(-50%, -50%);
  animation: float 12s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0) scale(1); }
  33% { transform: translate(30px, -30px) scale(1.1); }
  66% { transform: translate(-20px, 20px) scale(0.9); }
}

.hero-content {
  position: relative;
  z-index: 1;
  max-width: 800px;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: 30px;
  font-size: 0.9rem;
  color: var(--text-secondary);
  margin-bottom: 24px;
}

.badge-dot {
  width: 8px;
  height: 8px;
  background: #22c55e;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 24px;
}

.hero-title .name {
  background: var(--gradient-1);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.job-title {
  color: var(--accent-color);
}

.hero-description {
  font-size: 1.2rem;
  color: var(--text-secondary);
  max-width: 600px;
  margin-bottom: 32px;
  line-height: 1.8;
}

/* 音乐播放器 */
.music-player {
  position: fixed;
  top: 100px;
  right: 40px;
  z-index: 100;
  animation: fadeInRight 0.5s ease;
}

@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(20px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.music-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: 30px;
  color: var(--text-muted);
  font-size: 0.85rem;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
  opacity: 0.7;
}

.music-btn:hover {
  border-color: var(--primary-color);
  color: var(--text-secondary);
  box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
  opacity: 1;
}

.music-btn.active {
  background: rgba(99, 102, 241, 0.1);
  border-color: var(--primary-color);
  color: var(--primary-color);
}

/* 音乐列表面板 */
.music-panel {
  position: absolute;
  top: 50px;
  right: 0;
  width: 280px;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: 16px;
  padding: 16px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
  animation: slideDown 0.3s ease;
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.music-panel-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  font-size: 0.9rem;
  color: var(--text-primary);
  font-weight: 500;
}

.volume-tip {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 12px;
  background: rgba(99, 102, 241, 0.05);
  border-radius: 8px;
  margin-bottom: 12px;
  font-size: 0.75rem;
  color: var(--text-muted);
}

.volume-tip svg {
  color: var(--primary-color);
}

.close-panel {
  background: none;
  border: none;
  color: var(--text-muted);
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.close-panel:hover {
  background: var(--bg-dark);
  color: var(--text-primary);
}

.song-list {
  display: flex;
  flex-direction: column;
  gap: 4px;
  max-height: 300px;
  overflow-y: auto;
}

.song-list::-webkit-scrollbar {
  width: 4px;
}

.song-list::-webkit-scrollbar-thumb {
  background: var(--border-color);
  border-radius: 2px;
}

.song-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 12px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.song-item:hover {
  background: var(--bg-dark);
}

.song-item.active {
  background: var(--bg-dark);
}

.song-item.playing {
  background: rgba(99, 102, 241, 0.1);
}

.song-number {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: 6px;
  font-size: 0.75rem;
  color: var(--text-muted);
  flex-shrink: 0;
}

.song-item.active .song-number {
  background: var(--primary-color);
  border-color: var(--primary-color);
  color: white;
}

.song-info {
  flex: 1;
  min-width: 0;
}

.song-name {
  font-size: 0.85rem;
  color: var(--text-secondary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.song-item.active .song-name {
  color: var(--text-primary);
}

.song-status {
  color: var(--text-muted);
  display: flex;
  align-items: center;
}

.song-item.playing .song-status {
  color: var(--primary-color);
}

.music-btn.playing {
  background: rgba(99, 102, 241, 0.1);
  border-color: var(--primary-color);
  color: var(--primary-color);
}

.music-text {
  white-space: nowrap;
}

@media (max-width: 768px) {
  .music-player {
    top: 80px;
    right: 20px;
  }

  .music-text {
    display: none;
  }

  .music-btn {
    padding: 10px;
  }

  .music-panel {
    width: 260px;
    right: -10px;
  }
}

.scroll-indicator {
  position: absolute;
  right: 60px;
  top: 45%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: var(--text-muted);
  font-size: 0.85rem;
}

.mouse {
  width: 24px;
  height: 40px;
  border: 2px solid var(--text-muted);
  border-radius: 12px;
  position: relative;
}

.wheel {
  width: 4px;
  height: 8px;
  background: var(--text-muted);
  border-radius: 2px;
  position: absolute;
  top: 8px;
  left: 50%;
  transform: translateX(-50%);
  animation: scroll 1.5s infinite;
}

@keyframes scroll {
  0% { opacity: 1; transform: translateX(-50%) translateY(0); }
  100% { opacity: 0; transform: translateX(-50%) translateY(12px); }
}

@media (max-width: 768px) {
  .hero {
    padding: 80px 0 40px;
    min-height: 100vh;
    min-height: 100dvh;
    display: flex;
    align-items: flex-start;
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .hero .container {
    width: 100%;
    max-width: 100vw;
    padding: 0 16px;
    margin: 0;
  }
  
  .hero-content {
    padding: 0;
    max-width: 100%;
    width: 100%;
  }
  
  .hero-badge {
    font-size: 0.8rem;
    padding: 6px 12px;
    margin-bottom: 16px;
  }
  
  .hero-title {
    font-size: 1.8rem;
    line-height: 1.3;
    margin-bottom: 16px;
    word-wrap: break-word;
  }
  
  .hero-title br {
    display: block;
  }
  
  .hero-description {
    font-size: 0.95rem;
    line-height: 1.7;
    max-width: 100%;
    width: 100%;
    margin-bottom: 24px;
    word-wrap: break-word;
  }
  
  .scroll-indicator {
    display: none;
  }
  
  .gradient-orb {
    opacity: 0.3;
    max-width: 100vw;
  }
  
  .orb-1 {
    width: 250px;
    height: 250px;
    top: -80px;
    right: -80px;
  }
  
  .orb-2 {
    width: 200px;
    height: 200px;
    bottom: -60px;
    left: -60px;
  }
  
  .orb-3 {
    width: 150px;
    height: 150px;
    left: 20%;
  }
}
</style>
