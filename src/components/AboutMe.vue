<template>
  <section id="about" class="section about-me">
    <!-- 动态背景层 -->
    <div class="about-me-bg"></div>
    
    <div class="container about-container">
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
    </div>
  </section>
</template>

<script setup>
import { onMounted, onUnmounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

let scrollTriggerInstance = null

onMounted(() => {
  // 创建滚动触发动画时间线
  const tl = gsap.timeline({
    scrollTrigger: {
      trigger: '.about-me',
      start: 'top 80%',
      toggleActions: 'play none none reverse'
    }
  })

  // 标题动画
  tl.from('.about-me .section-title', {
    y: 30,
    opacity: 0,
    duration: 0.6,
    ease: 'power2.out'
  })
  // 副标题动画
  .from('.about-me .section-subtitle', {
    y: 30,
    opacity: 0,
    duration: 0.6,
    ease: 'power2.out'
  }, '-=0.4')
  // 照片从左滑入
  .from('.about-me .about-image', {
    x: -50,
    opacity: 0,
    duration: 0.8,
    ease: 'power2.out'
  }, '-=0.4')
  // 名字标题
  .from('.about-me .about-title', {
    y: 40,
    opacity: 0,
    duration: 0.6,
    ease: 'power2.out'
  }, '-=0.5')
  // 描述文字逐段上滑
  .from('.about-me .about-description', {
    y: 30,
    opacity: 0,
    duration: 0.6,
    stagger: 0.15,
    ease: 'power2.out'
  }, '-=0.4')

  scrollTriggerInstance = tl.scrollTrigger
})

onUnmounted(() => {
  if (scrollTriggerInstance) {
    scrollTriggerInstance.kill()
  }
})
</script>

<style scoped>
.about-me {
  position: relative;
  z-index: 20;
  width: 80vw;
  height: 100vh;
  overflow: hidden;
  padding-top: 180px;
}

/* 动态背景层 */
.about-me-bg {
  position: absolute;
  top: -10%;
  left: -10%;
  width: 120%;
  height: 120%;
  background: center center / cover no-repeat;
  background-image: url('../../public/photo/Aboutme.jpg');
  animation: windEffect 8s ease-in-out infinite;
  z-index: -2;
}

/* 风吹动效果动画 */
@keyframes windEffect {
  0%, 100% {
    transform: scale(1) translate(0, 0);
  }
  25% {
    transform: scale(1.02) translate(-1%, 0.5%);
  }
  50% {
    transform: scale(1.01) translate(0.5%, -0.5%);
  }
  75% {
    transform: scale(1.03) translate(-0.5%, 0.5%);
  }
}

.about-me::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.3);
  z-index: -1;
}

.about-container {
  max-width: 1400px;
  width: 80%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.about-content {
  display: grid;
  grid-template-columns: 1fr 1.5fr;
  gap: 1px;
  align-items: start;
  flex: 1;
  overflow: hidden;
}

.about-image {
  position: relative;
  display: flex;
  align-items: flex-start;
  justify-content: center;
}

.image-wrapper {
  position: relative;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
  max-height: calc(100vh - 250px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.profile-photo {
  width: 100%;
  max-width: 280px;
  height: auto;
  max-height: calc(100vh - 250px);
  object-fit: contain;
  display: block;
  transition: transform 0.5s ease;
}

.image-wrapper:hover .profile-photo {
  transform: scale(1.03);
}

.about-text {
  display: flex;
  flex-direction: column;
  gap: 12px;
  overflow: hidden;
}

.about-title {
  font-size: 1.6rem;
  font-weight: 700;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  margin-bottom: 6px;
}

.about-description {
  font-size: 0.95rem;
  line-height: 1.7;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  margin: 0;
}

.section-title {
  font-size: 2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 6px;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  flex-shrink: 0;
  background: none;
  -webkit-background-clip: initial;
  -webkit-text-fill-color: initial;
  background-clip: initial;
}

.section-subtitle {
  font-size: 1rem;
  text-align: center;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  margin-bottom: 24px;
  flex-shrink: 0;
}

/* 1366px - 1440px 笔记本屏幕 */
@media (max-width: 1440px) {
  .about-me {
    width: 100%;
    padding-top: 120px;
  }
  
  .about-container {
    max-width: 1200px;
    width: 90%;
  }
  
  .about-content {
    grid-template-columns: 1fr 2fr;
    gap: 40px;
  }
  
  .image-wrapper {
    max-height: calc(100vh - 280px);
  }
  
  .profile-photo {
    max-width: 240px;
    max-height: calc(100vh - 280px);
  }
  
  .about-title {
    font-size: 1.5rem;
  }
  
  .about-description {
    font-size: 0.9rem;
    line-height: 1.65;
  }
  
  .section-title {
    font-size: 1.8rem;
  }
  
  .section-subtitle {
    font-size: 0.95rem;
  }
}

/* 1024px - 1365px 小型笔记本 */
@media (max-width: 1365px) {
  .about-me {
    padding-top: 100px;
    height: auto;
    min-height: 100vh;
  }
  
  .about-container {
    width: 92%;
  }
  
  .about-content {
    grid-template-columns: 1fr 1.8fr;
    gap: 30px;
  }
  
  .image-wrapper {
    max-height: calc(100vh - 300px);
  }
  
  .profile-photo {
    max-width: 220px;
    max-height: calc(100vh - 300px);
  }
  
  .about-description {
    font-size: 0.88rem;
    line-height: 1.6;
  }
}

@media (max-width: 1024px) {
  .about-content {
    grid-template-columns: 1fr;
    gap: 24px;
  }
  
  .about-image {
    display: none;
  }
  
  .about-text {
    text-align: center;
  }
}

@media (max-width: 768px) {
  .about-me {
    padding-top: 60px;
    padding-bottom: 40px;
  }
  
  .about-container {
    width: 100%;
    padding: 0 16px;
  }
  
  .about-title {
    font-size: 1.3rem;
  }
  
  .about-description {
    font-size: 0.9rem;
    line-height: 1.6;
    text-align: left;
  }
  
  .section-title {
    font-size: 1.6rem;
    background: none;
    -webkit-background-clip: initial;
    -webkit-text-fill-color: initial;
    background-clip: initial;
  }
  
  .section-subtitle {
    font-size: 0.9rem;
  }
}

/* 小屏手机 < 375px */
@media (max-width: 375px) {
  .about-me {
    padding-top: 40px;
  }
  
  .about-title {
    font-size: 1.2rem;
  }
  
  .about-description {
    font-size: 0.85rem;
    line-height: 1.55;
  }
  
  .section-title {
    font-size: 1.4rem;
  }
  
  .section-subtitle {
    font-size: 0.85rem;
  }
}

/* 大屏设备 > 1920px */
@media (min-width: 1920px) {
  .about-me {
    padding-top: 200px;
  }
  
  .about-container {
    max-width: 1600px;
  }
  
  .about-content {
    grid-template-columns: 1fr 2.5fr;
    gap: 80px;
  }
  
  .profile-photo {
    width: 360px;
    height: 460px;
  }
  
  .about-title {
    font-size: 2rem;
  }
  
  .about-description {
    font-size: 1.1rem;
    line-height: 1.8;
  }
  
  .section-title {
    font-size: 2.5rem;
  }
  
  .section-subtitle {
    font-size: 1.2rem;
  }
}
</style>
