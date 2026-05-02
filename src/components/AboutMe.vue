<template>
  <section id="about" class="section about-me">
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
</script>

<style scoped>
.about-me {
  background: var(--bg-dark);
  position: relative;
  z-index: 20;
  width: 80vw;
  height: 100vh;
  overflow: hidden;
  padding-top: 180px;
}

.about-container {
  max-width: 1400px;
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.about-content {
  display: grid;
  grid-template-columns: 1fr 1.5fr;
  gap: 40px;
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
  max-height: calc(100vh - 200px);
}

.profile-photo {
  width: 280px;
  height: 360px;
  object-fit: cover;
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
  color: var(--text-primary);
  margin-bottom: 6px;
}

.about-description {
  font-size: 0.95rem;
  line-height: 1.7;
  color: var(--text-secondary);
  margin: 0;
}

.section-title {
  font-size: 2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 6px;
  color: var(--text-primary);
  flex-shrink: 0;
}

.section-subtitle {
  font-size: 1rem;
  text-align: center;
  color: var(--text-secondary);
  margin-bottom: 24px;
  flex-shrink: 0;
}

@media (max-width: 1024px) {
  .about-content {
    grid-template-columns: 1fr;
    gap: 24px;
  }
  
  .about-image {
    display: none;
  }
}

@media (max-width: 768px) {
  .about-me {
    padding-top: 60px;
  }
  
  .about-title {
    font-size: 1.3rem;
  }
  
  .about-description {
    font-size: 0.9rem;
    line-height: 1.6;
  }
  
  .section-title {
    font-size: 1.6rem;
  }
  
  .section-subtitle {
    font-size: 0.9rem;
  }
}
</style>
