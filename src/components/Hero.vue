<template>
  <section id="hero" class="hero">
    <!-- 背景图 -->
    <div class="hero-bg-image" ref="heroBgImage"></div>

    <!-- 首页内容层 -->
    <div class="hero-main-content" ref="heroMainContent">
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
        
        <!-- 右下角固定文本 -->
        <div class="hero-welcome">
          <div>Welcome to my</div>
          <div>personal portfolio website.</div>
        </div>
      </div>
    </div>

    <!-- 信念引言层 -->
    <div class="hero-beliefs" ref="heroBeliefs">
      <div class="belief-item">
        <span class="belief-quote">「</span>
        我相信好的产品不是功能堆砌，而是对人性需求的理解。
      </div>
      <div class="belief-item">
        <span class="belief-quote">&#12288;</span>
        我相信技术应该是温暖的，而不是冰冷的。
      </div>
      <div class="belief-item">
        <span class="belief-quote">&#12288;</span>
        我相信一个人最重要的能力，是持续学习。
        <span class="belief-quote">」</span>
      </div>
    </div>

    <!-- 2026年在做的事 -->
    <div class="hero-current" ref="heroCurrent">
      <div class="current-title">” 2026年在做的事</div>
      <div class="current-item">• 正在逐步提升自己并完善个人作品</div>
      <div class="current-item">• 努力寻找属于自己的方向</div>
      <div class="current-item">• 每天都在极力地摆脱床和沙发的绑架....</div>
    </div>

    <!-- 入场动画层 -->
    <div class="intro-overlay" ref="introOverlay">
      <!-- 上幕布 -->
      <div class="curtain-top" ref="curtainTop">
        <div class="curtain-text-top">Welcome in</div>
      </div>
      <!-- 下幕布 -->
      <div class="curtain-bottom" ref="curtainBottom">
        <div class="curtain-text-bottom">Welcome in</div>
      </div>
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
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

// 注册 GSAP 插件
gsap.registerPlugin(ScrollTrigger)

const showMusicPlayer = ref(false)
const isPlaying = ref(false)
const audioPlayer = ref(null)
const showPanel = ref(false)
const currentIndex = ref(0)
const musicPlayerRef = ref(null)

// 入场动画相关引用
const introOverlay = ref(null)
const curtainTop = ref(null)
const curtainBottom = ref(null)
const heroBgImage = ref(null)
const heroMainContent = ref(null)

// 歌曲列表 - 支持多首歌曲循环播放
const songs = [
  { name: 'Sorry', url: '/ai-portfolio/music/Sorry.mp3', type: 'audio/mpeg' },
  { name: 'peaches', url: '/ai-portfolio/music/peaches.mp3', type: 'audio/mpeg' },
  { name: 'the cure', url: '/ai-portfolio/music/the%20cure.mp3', type: 'audio/mpeg' },
  { name: 'Dead man', url: '/ai-portfolio/music/Dead%20man.mp3', type: 'audio/mpeg' },
  { name: 'Colder', url: '/ai-portfolio/music/Colder.mp3', type: 'audio/mpeg' },
  { name: 'Monsters', url: '/ai-portfolio/music/Monsters.mp3', type: 'audio/mpeg' }
]

const currentSong = computed(() => songs[currentIndex.value])

onMounted(() => {
  // 执行入场动画
  initIntroAnimation()

  // 点击外部关闭音乐面板
  document.addEventListener('click', handleClickOutside)

  // GSAP 滚动动画
  initScrollAnimations()

  // 原生滚动监听实现反向视差：背景图向下移动
  initParallaxScroll()
})

// 入场动画：5阶段连贯动画
const initIntroAnimation = () => {
  const overlay = introOverlay.value
  const topCurtain = curtainTop.value
  const bottomCurtain = curtainBottom.value
  const bgImage = heroBgImage.value

  if (!overlay || !topCurtain || !bottomCurtain) return

  const tl = gsap.timeline()

  // ========== 初始状态设置 ==========
  gsap.set(overlay, { display: 'flex' })
  // 幕布初始状态：完整显示
  gsap.set(topCurtain, { clipPath: 'inset(0 0 0 0)' })
  gsap.set(bottomCurtain, { clipPath: 'inset(0 0 0 0)' })
  gsap.set('.curtain-text-top', { opacity: 0, clipPath: 'inset(0 100% 0 0)' })
  gsap.set('.curtain-text-bottom', { opacity: 0, clipPath: 'inset(0 100% 0 0)' })
  gsap.set(bgImage, { opacity: 0 })
  gsap.set('.hero-content', { opacity: 0, y: 50 })
  gsap.set('.hero-welcome', { opacity: 0 })
  gsap.set('.scroll-indicator', { opacity: 0 })
  gsap.set('.music-player', { opacity: 0 })

  // ========== 阶段一：手写 "Welcome in" (0 - 1.5s) ==========
  // 上半部分文字从左到右写出
  tl.to('.curtain-text-top', {
    opacity: 1,
    clipPath: 'inset(0 0% 0 0)',
    duration: 0.9,
    ease: 'power2.inOut'
  }, 0)

  // 下半部分文字从左到右写出（稍微延迟）
  tl.to('.curtain-text-bottom', {
    opacity: 1,
    clipPath: 'inset(0 0% 0 0)',
    duration: 0.9,
    ease: 'power2.inOut'
  }, 0.4)

  // 停留 0.3 秒
  // 时间线自然推进到 1.5s

  // ========== 阶段二：幕布上下拉开 + 首页内容渐显 (1.8 - 3.0s) ==========
  // 使用 clip-path 实现幕布从中间向上下拉开的效果
  // 上幕布：从完整显示到只显示上半部分（下半部分被裁剪）
  tl.to(topCurtain, {
    clipPath: 'inset(0 0 100% 0)',
    duration: 1.2,
    ease: 'power3.inOut'
  }, 1.8)

  // 下幕布：从完整显示到只显示下半部分（上半部分被裁剪）
  tl.to(bottomCurtain, {
    clipPath: 'inset(100% 0 0 0)',
    duration: 1.2,
    ease: 'power3.inOut'
  }, 1.8)

  // 背景图在幕布刚开始拉开时就渐显
  tl.to(bgImage, {
    opacity: 1,
    duration: 1.0,
    ease: 'power2.out'
  }, 1.8)

  // 首页主标题与幕布同时开始渐显，持续整个幕布拉开过程
  tl.to('.hero-content', {
    opacity: 1,
    y: 0,
    duration: 1.2,
    ease: 'power2.out'
  }, 1.8)

  // ========== 阶段四：滚动指示器、音乐播放器依次淡入 (2.5 - 3.3s) ==========
  // 滚动指示器
  tl.to('.scroll-indicator', {
    opacity: 1,
    duration: 0.5,
    ease: 'power2.out'
  }, 2.5)

  // 音乐播放器
  tl.to('.music-player', {
    opacity: 1,
    duration: 0.5,
    ease: 'power2.out',
    onComplete: () => {
      showMusicPlayer.value = true
    }
  }, 2.8)

  // ========== 阶段五："Welcome to my..." 最晚淡入 (3.0 - 3.5s) ==========
  tl.to('.hero-welcome', {
    opacity: 1,
    duration: 0.5,
    ease: 'power2.out'
  }, 3.0)

  // 动画完成后隐藏入场层
  tl.set(overlay, { display: 'none' }, 3.5)
}

// 原生滚动监听实现反向视差（仅首页生效）
const initParallaxScroll = () => {
  const bgElement = document.querySelector('.hero-bg-image')
  const heroElement = document.querySelector('.hero')
  if (!bgElement || !heroElement) return

  const handleScroll = () => {
    const scrollY = window.scrollY
    const heroHeight = heroElement.offsetHeight
    
    // 只在首页（Hero区域）内应用视差效果
    if (scrollY <= heroHeight) {
      const bgMove = scrollY * 0.23 // 速度系数 0.2
      bgElement.style.transform = `translateY(${bgMove}px)`
      bgElement.style.opacity = '1'
    } else {
      // 超出首页后隐藏背景图
      bgElement.style.opacity = '0'
    }
  }

  window.addEventListener('scroll', handleScroll, { passive: true })

  // 保存引用以便卸载时移除
  window._parallaxHandler = handleScroll
}

// 初始化滚动动画 - 类 Inversa 效果
const initScrollAnimations = () => {
  // 获取 Hero 元素实际高度
  const heroElement = document.querySelector('.hero')
  const heroHeight = heroElement ? heroElement.offsetHeight : window.innerHeight * 3
  const viewportHeight = window.innerHeight

  // 计算动画比例因子（基于 300vh 高度）
  const heightRatio = heroHeight / viewportHeight

  // 徽章渐显动画
  gsap.fromTo('.hero-badge',
    { opacity: 0, y: 60, filter: 'blur(8px)' },
    {
      opacity: 1,
      y: 0,
      filter: 'blur(0px)',
      duration: 1.2,
      ease: 'power2.out',
      scrollTrigger: {
        trigger: '.hero',
        start: 'top 85%',
        end: 'top 30%',
        toggleActions: 'play none none reverse',
      }
    }
  )

  // 标题渐显动画 - 已移除
  // 描述文字渐显动画 - 已移除
  // Hero 内容随滚动淡出和上浮 - 已移除

  // 滚动指示器淡出
  gsap.to('.scroll-indicator', {
    scrollTrigger: {
      trigger: '.hero',
      start: 'top top',
      end: '20% top',
      scrub: 1,
    },
    opacity: 0,
    y: 30,
    ease: 'none'
  })

  // 背景视差效果已由原生滚动监听实现（initParallaxScroll）
  // 不再使用 ScrollTrigger 控制背景图
  
  // 在 Dream 区域隐藏音乐播放器，其他区域显示
  ScrollTrigger.create({
    trigger: '#dream',
    start: 'top 80%',
    end: 'bottom 20%',
    onEnter: () => {
      gsap.to('.music-player', { opacity: 0, pointerEvents: 'none', duration: 0.3 })
    },
    onLeave: () => {
      gsap.to('.music-player', { opacity: 1, pointerEvents: 'auto', duration: 0.3 })
    },
    onEnterBack: () => {
      gsap.to('.music-player', { opacity: 0, pointerEvents: 'none', duration: 0.3 })
    },
    onLeaveBack: () => {
      gsap.to('.music-player', { opacity: 1, pointerEvents: 'auto', duration: 0.3 })
    }
  })
}

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

  // 移除原生滚动监听
  if (window._parallaxHandler) {
    window.removeEventListener('scroll', window._parallaxHandler)
  }
})
</script>

<style scoped>
.hero {
  min-height: 270vh;
  display: flex;
  align-items: center;
  position: relative;
  overflow: hidden;
  padding-top: 80px;
  background: var(--bg-dark);
}

/* 首页背景图 - 视差背景层（fixed + 原生滚动监听） */
.hero-bg-image {
  position: fixed;
  top: -75vh;
  left: 0;
  width: 100%;
  height: 210%;
  background-image: url('/photo/OIP.webp');
  background-size: cover;
  background-position: center;
  z-index: 0;
  pointer-events: none;
  will-change: transform;
}

/* Hero 底部渐变遮罩 - 平滑过渡到下方内容 */
.hero::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 6.25vh;
  background: linear-gradient(
    to bottom,
    transparent 0%,
    rgba(10, 10, 10, 0.3) 30%,
    rgba(10, 10, 10, 0.7) 70%,
    var(--bg-dark) 100%
  );
  z-index: 5;
  pointer-events: none;
}

.hero-content {
  position: relative;
  z-index: 0;
  max-width: 600px;
  margin-left: 0;
  margin-right: auto;
  padding-left: 0%;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 30px;
  font-size: 0.9rem;
  color: rgba(255, 255, 255, 0.9);
  margin-bottom: 24px;
  backdrop-filter: blur(10px);
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
  color: #ffffff;
}

.hero-title .name {
  color: #e0e0e0;
  background: none;
  -webkit-background-clip: unset;
  -webkit-text-fill-color: unset;
  background-clip: unset;
}

.job-title {
  color: rgba(255, 255, 255, 0.7);
}

.hero-description {
  font-size: 1.2rem;
  color: rgba(255, 255, 255, 0.8);
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
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.25);
  border-radius: 30px;
  color: #000000;
  font-size: 0.85rem;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(30px) saturate(200%);
  -webkit-backdrop-filter: blur(30px) saturate(200%);
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.2),
    inset 0 1px 0 rgba(255, 255, 255, 0.4),
    inset 0 -1px 0 rgba(255, 255, 255, 0.1);
}

.music-btn:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.4);
  color: #ffffff;
  box-shadow: 
    0 12px 48px rgba(0, 0, 0, 0.25),
    inset 0 1px 0 rgba(255, 255, 255, 0.5),
    inset 0 -1px 0 rgba(255, 255, 255, 0.15);
  transform: translateY(-2px);
}

.music-btn.active {
  background: rgba(255, 255, 255, 0.12);
  border-color: rgba(255, 255, 255, 0.5);
  color: #000000;
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.6),
    inset 0 -1px 0 rgba(255, 255, 255, 0.2);
}

/* 音乐列表面板 - 液态玻璃效果 */
.music-panel {
  position: absolute;
  top: 50px;
  right: 0;
  width: 280px;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.25);
  border-radius: 16px;
  padding: 16px;
  backdrop-filter: blur(30px) saturate(200%);
  -webkit-backdrop-filter: blur(30px) saturate(200%);
  box-shadow: 
    0 8px 32px rgba(0, 0, 0, 0.2),
    inset 0 1px 0 rgba(255, 255, 255, 0.4),
    inset 0 -1px 0 rgba(255, 255, 255, 0.1);
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
  color: #000000;
  font-weight: 500;
}

.volume-tip {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 8px 12px;
  background: rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  margin-bottom: 12px;
  font-size: 0.75rem;
  color: #000000;
}

.volume-tip svg {
  color: #000000;
}

.close-panel {
  background: rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.1);
  color: #000000;
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.close-panel:hover {
  background: rgba(0, 0, 0, 0.1);
  color: #000000;
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
  background: rgba(255, 255, 255, 0.2);
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
  color: rgba(255, 255, 255, 0.9);
}

.song-item:hover {
  background: rgba(255, 255, 255, 0.15);
}

.song-item.active {
  background: rgba(255, 255, 255, 0.1);
}

.song-item.playing {
  background: rgba(255, 255, 255, 0.2);
  color: #ffffff;
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
  color: #000000;
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
  top: 30vh;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: rgba(255, 255, 255, 0.7);
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

/* 入场动画样式 */
.intro-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  /* 背景色由上下幕布各自设置 */
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 99999; /* 确保是整个网站最高层级 */
  flex-direction: column;
  pointer-events: none; /* 允许点击穿透到下方 */
}

.intro-content {
  position: relative;
}

.typewriter-container {
  font-size: 4rem;
  font-weight: 300;
  color: #ffffff;
  letter-spacing: 0.1em;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

.typewriter-text {
  display: inline;
}

.cursor {
  display: inline;
  color: #ffffff;
  animation: blink 1s infinite;
}

@keyframes blink {
  0%, 50% { opacity: 1; }
  51%, 100% { opacity: 0; }
}

.split-line {
  position: absolute;
  top: 50%;
  left: 0;
  width: 0;
  height: 2px;
  background: linear-gradient(90deg, transparent, #ffffff, transparent);
  transform: translateY(-50%);
}

/* 幕布样式 */
.curtain-top,
.curtain-bottom {
  position: absolute;
  left: 0;
  width: 100%;
  height: 50%;
  background: #000000;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.curtain-top {
  top: 0;
  align-items: flex-end;
  padding-bottom: 0;
}

.curtain-bottom {
  bottom: 0;
  align-items: flex-start;
  padding-top: 0;
}

.curtain-text-top,
.curtain-text-bottom {
  font-family: 'Caveat', 'Ma Shan Zheng', cursive;
  font-size: 6rem;
  color: #ffffff;
  letter-spacing: 0.15em;
  font-weight: 400;
  white-space: nowrap;
}

.curtain-text-top {
  transform: translateY(50%);
  clip-path: inset(0 100% 0 0);
}

.curtain-text-bottom {
  transform: translateY(-50%);
  clip-path: inset(0 100% 0 0);
}

/* z-index 层级 */
/* .hero 的基础样式已在上面定义，这里只添加 z-index 相关 */

.hero-bg-image {
  position: fixed;
  top: -75vh;
  left: 0;
  width: 100%;
  height: 210%;
  z-index: 1;
  background-image: url('/photo/OIP.webp');
  background-size: cover;
  background-position: center;
  pointer-events: none;
  will-change: transform;
}

.hero-main-content {
  position: absolute;
  top: 25vh;
  left: 0;
  width: 100%;
  height: auto;
  z-index: 5;
  transform: translateY(-50%);
}

/* 信念引言层 */
.hero-beliefs {
  position: absolute;
  top: 150vh;
  left: 0;
  width: 100%;
  z-index: 5;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  padding-left: 5%;
  gap: 24px;
}

.belief-item {
  font-size: 1.5rem;
  color: rgba(255, 255, 255, 0.95);
  line-height: 1.6;
  max-width: 800px;
  font-weight: 400;
  letter-spacing: 0.02em;
}

.belief-quote {
  font-size: 2rem;
  color: rgba(255, 255, 255, 0.6);
  margin-right: 8px;
  font-family: Georgia, serif;
}

.intro-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 99999; /* 确保是整个网站最高层级 */
}

.curtain-top,
.curtain-bottom {
  z-index: 99999; /* 确保是整个网站最高层级 */
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
}

/* 首页内固定位置欢迎文本（固定在首页80vh位置） */
.hero-welcome {
  position: absolute;
  top: 70vh;
  right: 50px;
  font-size: 3rem;
  font-weight: 500;
  color: rgba(255, 255, 255, 0.9);
  z-index: 100;
  pointer-events: none;
  letter-spacing: 0.05em;
  text-align: right;
  line-height: 1.3;
}

/* 2026年在做的事 */
.hero-current {
  position: absolute;
  top: 230vh;
  left: 75%;
  z-index: 5;
  text-align: left;
  max-width: 500px;
}

.current-title {
  font-size: 1.8rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.95);
  margin-bottom: 16px;
  letter-spacing: 0.02em;
}

.current-item {
  font-size: 1.1rem;
  color: rgba(255, 255, 255, 0.85);
  line-height: 1.8;
  margin-bottom: 8px;
  font-weight: 400;
}

@media (max-width: 768px) {
  .hero-welcome {
    top: 70%;
    right: 20px;
    font-size: 0.85rem;
  }

  .hero-current {
    top: 230vh;
    left: 5%;
    max-width: 280px;
  }

  .current-title {
    font-size: 1.2rem;
  }

  .current-item {
    font-size: 0.9rem;
  }
}
</style>
