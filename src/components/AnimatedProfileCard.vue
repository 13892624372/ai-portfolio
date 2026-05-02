<template>
  <div
    ref="cardHolderRef"
    class="reveal-card-container"
    @mouseenter="reveal"
    @mouseleave="conceal"
    :style="containerStyles"
  >
    <!-- 基础层 -->
    <div class="card-base">
      <slot name="base">
        <div class="default-base">
          <div class="company-avatar" :style="{ background: gradient }">
            <span>{{ companyInitial }}</span>
          </div>
          <div class="base-content">
            <h3 class="job-title">{{ title }}</h3>
            <p class="company-name">{{ company }}</p>
            <span class="job-period">{{ period }}</span>
          </div>
        </div>
      </slot>
    </div>

    <!-- 遮罩层 -->
    <div
      ref="overlayRef"
      class="card-overlay"
      :class="overlayClass"
    >
      <slot name="overlay">
        <div class="default-overlay">
          <h4 class="overlay-title">{{ title }}</h4>
          <p class="overlay-company">{{ company }}</p>
          <div class="overlay-divider"></div>
          <p class="overlay-description">{{ description }}</p>
          <div v-if="achievements.length" class="overlay-achievements">
            <h5>主要成就</h5>
            <ul>
              <li v-for="(item, idx) in achievements.slice(0, 3)" :key="idx">
                {{ item }}
              </li>
            </ul>
          </div>
          <div v-if="technologies.length" class="overlay-techs">
            <span v-for="(tech, idx) in technologies.slice(0, 4)" :key="idx" class="tech-tag">
              {{ tech }}
            </span>
          </div>
        </div>
      </slot>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import gsap from 'gsap'

const props = defineProps({
  title: {
    type: String,
    default: ''
  },
  company: {
    type: String,
    default: ''
  },
  companyInitial: {
    type: String,
    default: ''
  },
  period: {
    type: String,
    default: ''
  },
  description: {
    type: String,
    default: ''
  },
  achievements: {
    type: Array,
    default: () => []
  },
  technologies: {
    type: Array,
    default: () => []
  },
  gradient: {
    type: String,
    default: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)'
  },
  accent: {
    type: String,
    default: '#6366f1'
  },
  width: {
    type: String,
    default: '320px'
  }
})

const cardHolderRef = ref(null)
const overlayRef = ref(null)

const containerStyles = computed(() => ({
  '--accent-color': props.accent,
  width: props.width
}))

const overlayClass = computed(() => 'overlay-accent')

const startClip = 'circle(40px at 48px 48px)'
const expandClip = 'circle(150% at 48px 48px)'

onMounted(() => {
  if (overlayRef.value) {
    gsap.set(overlayRef.value, { clipPath: startClip })
  }
})

const reveal = () => {
  if (overlayRef.value) {
    gsap.to(overlayRef.value, {
      clipPath: expandClip,
      duration: 0.8,
      ease: 'expo.inOut'
    })
  }
}

const conceal = () => {
  if (overlayRef.value) {
    gsap.to(overlayRef.value, {
      clipPath: startClip,
      duration: 1,
      ease: 'expo.out(1, 1)'
    })
  }
}
</script>

<style scoped>
.reveal-card-container {
  position: relative;
  overflow: hidden;
  border-radius: 24px;
  border: 2px solid var(--accent-color);
  cursor: pointer;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  background: var(--bg-card, #ffffff);
}

.reveal-card-container:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

/* 基础层 */
.card-base {
  position: relative;
  z-index: 1;
  background: transparent;
  padding: 32px;
  min-height: 373px;
}

.default-base {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 20px;
}

.company-avatar {
  width: 80px;
  height: 80px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2rem;
  font-weight: 600;
  color: white;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.base-content {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.job-title {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--text-primary, #1f2937);
  line-height: 1.3;
}

.company-name {
  font-size: 0.95rem;
  color: var(--text-secondary, #6b7280);
  line-height: 1.4;
}

.job-period {
  font-size: 0.85rem;
  color: var(--text-muted, #9ca3af);
  font-weight: 500;
}

/* 遮罩层 */
.card-overlay {
  position: absolute;
  inset: 0;
  z-index: 2;
  will-change: clip-path;
}

.overlay-accent {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.5);
  box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.6);
  color: #1f2937;
}

.default-overlay {
  padding: 32px;
  height: 100%;
  display: flex;
  flex-direction: column;
  overflow-y: auto;
}

.overlay-title {
  font-size: 1.4rem;
  font-weight: 600;
  margin-bottom: 6px;
  color: #1f2937;
}

.overlay-company {
  font-size: 1rem;
  opacity: 0.9;
  margin-bottom: 16px;
  color: #374151;
}

.overlay-divider {
  height: 1px;
  background: rgba(0, 0, 0, 0.1);
  margin-bottom: 16px;
}

.overlay-description {
  font-size: 1rem;
  line-height: 1.6;
  opacity: 0.95;
  margin-bottom: 16px;
  color: #374151;
}

.overlay-achievements {
  margin-bottom: 16px;
}

.overlay-achievements h5 {
  font-size: 0.95rem;
  font-weight: 600;
  margin-bottom: 8px;
  opacity: 0.9;
  color: #1f2937;
}

.overlay-achievements ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.overlay-achievements li {
  font-size: 0.9rem;
  line-height: 1.5;
  opacity: 0.85;
  margin-bottom: 6px;
  padding-left: 14px;
  position: relative;
  color: #4b5563;
}

.overlay-achievements li::before {
  content: '•';
  position: absolute;
  left: 0;
  opacity: 0.7;
  color: #6b7280;
}

.overlay-techs {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: auto;
}

.tech-tag {
  font-size: 0.85rem;
  padding: 4px 10px;
  background: rgba(0, 0, 0, 0.08);
  border-radius: 12px;
  color: #374151;
  font-weight: 500;
}

/* 滚动条样式 */
.default-overlay::-webkit-scrollbar {
  width: 4px;
}

.default-overlay::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.1);
}

.default-overlay::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
}
</style>
