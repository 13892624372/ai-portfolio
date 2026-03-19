<template>
  <section id="contact" class="section contact">
    <div class="container">
      <h2 class="section-title">联系我</h2>
      <p class="section-subtitle">期待与您的合作与交流</p>
      
      <div class="contact-content">
        <div class="contact-info">
          <p class="info-description">
            无论您是有项目合作意向、技术交流需求，还是其他事项，都欢迎与我联系。
            我会尽快回复您的消息。
          </p>
          
          <div class="contact-methods">
            <div class="contact-item">
              <div class="contact-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                  <polyline points="22,6 12,13 2,6"/>
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
            
            <div class="contact-item">
              <div class="contact-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                  <circle cx="12" cy="10" r="3"/>
                </svg>
              </div>
              <div class="contact-detail">
                <span class="contact-label">地址</span>
                <span class="contact-value">陕西省西安市雁塔区</span>
              </div>
            </div>
          </div>
          
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
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
  background: rgba(99, 102, 241, 0.15);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--primary-color);
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
