<template>
  <section id="hero" class="hero">
    <div class="hero-bg">
      <div class="gradient-orb orb-1"></div>
      <div class="gradient-orb orb-2"></div>
      <div class="gradient-orb orb-3"></div>
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
          <br />
          <span class="job-title">AI产品工程师</span>
        </h1>
        
        <p class="hero-description">
          2025届软件工程技术专业毕业生，毕业于西安信息职业大学。拥有扎实的编程基础，
          精通Python、C语言等主流开发技术，具备完整的前后端开发能力。在校期间系统学习过
          机器学习与深度学习相关课程，对AI技术充满热情。目前正积极向AI行业转型，
          致力于将软件工程技术与人工智能相结合，在产品经理岗位上创造用户价值。
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
