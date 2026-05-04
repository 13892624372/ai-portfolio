<template>
  <section id="dream" class="dream" ref="dreamRef">
    <div class="container">
      <!-- 预留区域 - 待添加内容 -->
    </div>
    
    <!-- 入场动画覆盖层 -->
    <DreamIntroAnimation 
      ref="introAnimationRef"
      :videoSrc="videoSrc"
      @animationComplete="onAnimationComplete"
      @videoReady="onVideoReady"
      @close="onAnimationClose"
    />
  </section>
</template>

<script setup>
import { ref } from 'vue'
import DreamIntroAnimation from './DreamIntroAnimation.vue'

const introAnimationRef = ref(null)

// 视频路径（后续提供）
const videoSrc = ref('')

// 动画完成回调
const onAnimationComplete = () => {
  console.log('Dream 入场动画完成')
}

// 视频准备好回调
const onVideoReady = () => {
  console.log('Dream 视频准备好')
}

// 动画关闭回调
const onAnimationClose = () => {
  console.log('Dream 动画关闭')
}

// 公开方法：点击地球时触发动画
const startAnimation = () => {
  if (introAnimationRef.value) {
    introAnimationRef.value.reset()
    introAnimationRef.value.activate()
  }
}

defineExpose({
  startAnimation
})
</script>

<style scoped>
.dream {
  width: 100vw;
  height: 100vh;
  background: #0a0a0a;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
}

.container {
  width: 100%;
  max-width: 1200px;
  padding: 0 5vw;
}
</style>
