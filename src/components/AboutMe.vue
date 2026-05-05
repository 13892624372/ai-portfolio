<template>
  <section id="about" class="section about-me">
    <!-- 动态背景层 -->
    <div class="about-me-bg"></div>
    
    <div class="container about-container">
      <!-- 3D 卡片容器 -->
      <div 
        class="card-3d-wrapper"
        @mousemove="handleMouseMove"
        @mouseleave="handleMouseLeave"
      >
        <div class="card-3d" ref="cardRef">
          <div class="card-inner">
            <div class="card-glare" ref="glareRef"></div>
            <div class="card-content">
              <h2 class="section-title">关于我</h2>
              <p class="section-subtitle" style="margin-bottom: 4px;">以技术为根基，以产品思维驱动AI创新</p>
              <div class="about-content" style="gap: 6px; margin-top: 0;">
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
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import gsap from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

gsap.registerPlugin(ScrollTrigger)

const cardRef = ref(null)
const glareRef = ref(null)
let scrollTriggerInstance = null

// 处理鼠标移动事件
const handleMouseMove = (e) => {
  const wrapper = e.currentTarget
  const rect = wrapper.getBoundingClientRect()
  const x = e.clientX - rect.left
  const y = e.clientY - rect.top
  
  const centerX = rect.width / 2
  const centerY = rect.height / 2
  
  const calcX = -(y - centerY) / 30
  const calcY = (x - centerX) / 30
  const percentage = (x / rect.width) * 100
  
  if (cardRef.value) {
    cardRef.value.style.transform = `perspective(1200px) rotateX(${calcX}deg) rotateY(${calcY}deg)`
  }
  if (glareRef.value) {
    glareRef.value.style.setProperty('--per', `${percentage}%`)
    glareRef.value.style.opacity = '1'
  }
}

// 处理鼠标离开事件
const handleMouseLeave = () => {
  if (cardRef.value) {
    cardRef.value.style.transform = 'perspective(1200px) rotateX(0) rotateY(0)'
  }
  if (glareRef.value) {
    glareRef.value.style.opacity = '0'
  }
}

onMounted(() => {
  // 确保卡片初始状态正确
  if (cardRef.value) {
    cardRef.value.style.transform = 'perspective(1200px) rotateX(0) rotateY(0)'
  }
  
  // 创建滚动触发动画时间线
  const tl = gsap.timeline({
    scrollTrigger: {
      trigger: '.about-me',
      start: 'top 80%',
      toggleActions: 'play none none reverse'
    }
  })

  // 卡片淡入
  tl.from('.about-me .card-3d-wrapper', {
    y: 30,
    opacity: 0,
    duration: 0.8,
    ease: 'power2.out'
  })
  // 标题动画
  .from('.about-me .section-title', {
    y: 30,
    opacity: 0,
    duration: 0.6,
    ease: 'power2.out'
  }, '-=0.4')
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
  }, '-=0.2')
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
  padding: 0;
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

/* 3D 卡片容器 */
.card-3d-wrapper {
  width: 88vw;
  height: 110vh;
  display: flex;
  align-items: stretch;
  justify-content: stretch;
  transform: translateX(-4vw);
}

.card-3d {
  width: 100%;
  height: 100%;
  transform-style: preserve-3d;
}

.card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: 0;
  overflow: visible;
}

.card-glare {
  display: none;
}

.card-content {
  position: relative;
  width: 100%;
  height: 100%;
  background: transparent !important;
  backdrop-filter: none !important;
  -webkit-backdrop-filter: none !important;
  border-radius: 20px;
  border: none !important;
  box-shadow: none !important;
  padding: 0 !important;
  display: flex !important;
  flex-direction: column !important;
  align-items: center !important;
  justify-content: flex-start !important;
  overflow-y: auto;
  padding-top: 25vh !important;
  transform: translateX(-6vw);
}

.about-content {
  display: grid !important;
  grid-template-columns: 1fr 1.5fr !important;
  gap: 4px !important;
  row-gap: 4px !important;
  align-items: flex-start !important;
  justify-items: center !important;
  flex: 1;
  overflow: hidden;
  width: 100%;
  margin-top: 0 !important;
  margin-bottom: 0 !important;
}

.about-image {
  position: relative;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  margin: 0 !important;
  padding: 0 !important;
}

.image-wrapper {
  position: relative;
  width: 240px;
  height: 300px;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  border: 1px solid rgba(255, 255, 255, 0.1);
  margin: 0 !important;
  padding: 0 !important;
}

.profile-photo {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center top;
  display: block;
  transition: transform 0.5s ease;
  margin: 0 !important;
  padding: 0 !important;
}

.image-wrapper:hover .profile-photo {
  transform: scale(1.03);
}

.about-text {
  display: flex;
  flex-direction: column;
  gap: 6px !important;
  overflow: hidden;
  margin: 0 !important;
  padding: 0 !important;
  max-width: 600px;
  width: 90%;
  transform: translateX(-10vw);
}

.about-title {
  font-size: 1.6rem;
  font-weight: 700;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  margin-bottom: 2px !important;
  margin-top: 0 !important;
  padding: 0 !important;
}

.about-description {
  font-size: 0.95rem;
  line-height: 1.7;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  margin: 0 !important;
  padding: 0 !important;
}

.section-title {
  font-size: 2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 2px !important;
  margin-top: 0 !important;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  flex-shrink: 0;
  background: none;
  -webkit-background-clip: initial;
  -webkit-text-fill-color: initial;
  background-clip: initial;
  padding: 0 !important;
}

.section-subtitle {
  font-size: 1rem;
  text-align: center;
  color: #f0f0f8;
  text-shadow: 0 1px 2px rgba(0,0,0,0.2);
  margin-bottom: 8px !important;
  margin-top: 0 !important;
  flex-shrink: 0;
  padding: 0 !important;
}

/* 1366px - 1440px 笔记本屏幕 */
@media (max-width: 1440px) {
  .about-me {
    width: 100%;
    padding: 60px 0;
  }
  
  .about-container {
    max-width: 1200px;
    width: 90%;
  }
  
  .about-content {
    grid-template-columns: 1fr 2fr;
    gap: 12px;
  }
  
  .image-wrapper {
    width: 220px;
    height: 275px;
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
    margin-bottom: 7px;
  }
  
  .card-content {
    padding: 0 30px;
  }
}

/* 1024px - 1365px 小型笔记本 */
@media (max-width: 1365px) {
  .about-me {
    padding: 50px 0;
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
    width: 200px;
    height: 250px;
  }
  
  .about-description {
    font-size: 0.88rem;
    line-height: 1.6;
  }
  
  .card-content {
    padding: 0 25px;
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
  
  .card-3d-wrapper {
    height: auto;
    min-height: auto;
  }
}

@media (max-width: 768px) {
  .about-me {
    padding: 40px 0;
    height: auto;
    min-height: 100vh;
  }
  
  .about-container {
    width: 100%;
    padding: 0 16px;
  }
  
  .about-content {
    grid-template-columns: 1fr !important;
    gap: 20px !important;
    row-gap: 20px !important;
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
  
  .card-content {
    padding: 15px 20px;
    border-radius: 16px;
    transform: none !important;
    padding-top: 15px !important;
  }
  
  .about-text {
    transform: none !important;
    width: 100% !important;
    max-width: 100% !important;
  }
  
  .card-3d-wrapper {
    height: auto;
    transform: none !important;
    width: 100%;
  }
  
  /* 移动端禁用 3D 效果 */
  .card-3d {
    transform: none !important;
  }
  
  .card-glare {
    display: none;
  }
  
  .image-wrapper {
    width: 180px;
    height: 225px;
  }
}

/* 小屏手机 < 375px */
@media (max-width: 375px) {
  .about-me {
    padding: 30px 0;
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
  
  .card-content {
    padding: 15px;
  }
}

/* 大屏设备 > 1920px */
@media (min-width: 1920px) {
  .about-me {
    padding: 100px 0;
  }
  
  .about-container {
    max-width: 1600px;
  }
  
  .about-content {
    grid-template-columns: 1fr 2.5fr;
    gap: 80px;
  }
  
  .image-wrapper {
    width: 300px;
    height: 375px;
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
  
  .card-content {
    padding: 40px 50px;
  }
}
</style>
