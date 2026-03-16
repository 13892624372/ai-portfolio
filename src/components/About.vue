<template>
  <section id="about" class="section about">
    <div class="container">
      <h2 class="section-title">关于我</h2>
      <p class="section-subtitle">致力于AI开发与智能应用解决方案</p>
      
      <div class="about-content">
        <div class="about-image">
          <div class="image-wrapper">
            <img src="/photo.jpg.png" alt="田雨" class="profile-photo" />
          </div>
        </div>
        
        <div class="about-text">
          <h3 class="about-title">我是田雨</h3>
          <p class="about-description">
            2025届软件工程技术专业毕业生，毕业于西安信息职业大学。在校期间系统学习了软件开发的核心技术，
            具备扎实的编程功底和良好的代码规范意识。对人工智能领域充满热情，主动学习了机器学习、深度学习等相关知识。
          </p>
          <p class="about-description">
            善于学习新知识，能快速融入团队并推动项目落地，具有强烈的责任心和团队协作精神。
            目前正积极向AI行业转型，期待在AI产品经理岗位上将技术能力与产品思维相结合，创造用户价值。
          </p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
</script>

<style scoped>
.about {
  background: linear-gradient(180deg, var(--bg-dark) 0%, rgba(30, 41, 59, 0.5) 100%);
}

.about-content {
  display: grid;
  grid-template-columns: 1fr 1.5fr;
  gap: 60px;
  align-items: start;
}

.about-image {
  position: relative;
}

.image-wrapper {
  position: relative;
  display: inline-block;
  border-radius: 20px;
  overflow: hidden;
}

.profile-photo {
  width: 350px;
  height: 450px;
  object-fit: cover;
  border-radius: 20px;
  display: block;
}

.image-wrapper::after {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(
    to bottom,
    transparent 70%,
    var(--bg-primary) 100%
  );
  pointer-events: none;
}

.image-wrapper::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  border-radius: 20px;
  box-shadow: inset 0 0 60px rgba(99, 102, 241, 0.3);
  pointer-events: none;
  z-index: 1;
}

.about-title {
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 20px;
  line-height: 1.4;
}

.about-description {
  color: var(--text-secondary);
  margin-bottom: 16px;
  line-height: 1.8;
}

@media (max-width: 968px) {
  .about-content {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  
  .about-image {
    text-align: center;
  }
  
  .profile-photo {
    width: 280px;
    height: 360px;
  }
}

@media (max-width: 768px) {
  .about {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .about-content {
    gap: 30px;
  }
  
  .profile-photo {
    width: 200px;
    height: 260px;
  }
  
  .about-title {
    font-size: 1.4rem;
  }
  
  .about-text {
    font-size: 0.95rem;
    line-height: 1.7;
  }
  
  .info-item {
    padding: 12px 16px;
  }
  
  .info-label {
    font-size: 0.8rem;
  }
  
  .info-value {
    font-size: 0.95rem;
  }
}
</style>
