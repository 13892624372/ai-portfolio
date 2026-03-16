<template>
  <section id="about" class="section about">
    <div class="container">
      <h2 class="section-title">关于</h2>
      <p class="section-subtitle">探索技术与智能的无限可能</p>
      
      <!-- 关于我 -->
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
      
      <!-- 关于AI -->
      <div class="ai-section">
        <h3 class="ai-title">
          <span class="ai-icon">🤖</span>
          关于AI
        </h3>
        <p class="ai-intro">
          人工智能正在重塑我们的世界。从早期的专家系统到如今的生成式AI，
          这项技术经历了数十年的发展，正在以惊人的速度改变着各行各业。
        </p>
        
        <!-- AI发展史时间轴 -->
        <div class="timeline-section">
          <h4 class="subsection-title">AI发展史</h4>
          <div class="timeline">
            <div class="timeline-item" v-for="(event, index) in aiTimeline" :key="index">
              <div class="timeline-marker" :style="{ background: event.gradient }">
                <span class="timeline-year">{{ event.year }}</span>
              </div>
              <div class="timeline-content">
                <h5 class="timeline-title">{{ event.title }}</h5>
                <p class="timeline-desc">{{ event.description }}</p>
              </div>
            </div>
          </div>
        </div>
        
        <!-- 主流大模型 -->
        <div class="models-section">
          <h4 class="subsection-title">主流大语言模型</h4>
          <div class="models-grid">
            <div class="model-card" v-for="(model, index) in llmModels" :key="index">
              <div class="model-header">
                <div class="model-icon" :style="{ background: model.gradient }">
                  {{ model.icon }}
                </div>
                <div class="model-info">
                  <h5 class="model-name">{{ model.name }}</h5>
                  <span class="model-company">{{ model.company }}</span>
                </div>
              </div>
              <p class="model-desc">{{ model.description }}</p>
              <div class="model-tags">
                <span class="model-tag" v-for="(tag, tagIndex) in model.tags" :key="tagIndex">
                  {{ tag }}
                </span>
              </div>
            </div>
          </div>
        </div>
        
        <!-- AI智能体 -->
        <div class="agents-section">
          <h4 class="subsection-title">AI智能体生态</h4>
          <div class="agents-grid">
            <div class="agent-card" v-for="(agent, index) in aiAgents" :key="index">
              <div class="agent-icon">{{ agent.icon }}</div>
              <h5 class="agent-name">{{ agent.name }}</h5>
              <p class="agent-desc">{{ agent.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

// AI发展史时间轴数据
const aiTimeline = ref([
  {
    year: '1956',
    title: '人工智能诞生',
    description: '达特茅斯会议召开，约翰·麦卡锡首次提出"人工智能"概念，标志着AI学科的正式诞生。',
    gradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
  },
  {
    year: '1966',
    title: 'ELIZA聊天机器人',
    description: '世界上第一个聊天机器人ELIZA诞生，能够模拟心理治疗师进行对话。',
    gradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)'
  },
  {
    year: '1997',
    title: '深蓝战胜卡斯帕罗夫',
    description: 'IBM深蓝计算机击败国际象棋世界冠军卡斯帕罗夫，成为首个在标准比赛中击败世界冠军的计算机系统。',
    gradient: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)'
  },
  {
    year: '2011',
    title: 'IBM Watson',
    description: 'Watson在智力竞赛节目《危险边缘》中击败人类冠军，展示了自然语言理解和知识推理能力。',
    gradient: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)'
  },
  {
    year: '2012',
    title: '深度学习革命',
    description: 'AlexNet在ImageNet竞赛中以压倒性优势获胜，深度学习开始引领AI发展新方向。',
    gradient: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)'
  },
  {
    year: '2016',
    title: 'AlphaGo击败李世石',
    description: 'DeepMind的AlphaGo以4:1战胜围棋世界冠军李世石，标志着AI在复杂策略游戏中的突破。',
    gradient: 'linear-gradient(135deg, #30cfd0 0%, #330867 100%)'
  },
  {
    year: '2020',
    title: 'GPT-3发布',
    description: 'OpenAI发布GPT-3，拥有1750亿参数，展现出强大的文本生成和理解能力，开启大模型时代。',
    gradient: 'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)'
  },
  {
    year: '2022',
    title: 'ChatGPT现象',
    description: 'ChatGPT发布，两个月内用户突破1亿，成为历史上增长最快的消费级应用，引发全球AI热潮。',
    gradient: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)'
  },
  {
    year: '2023',
    title: '多模态AI爆发',
    description: 'GPT-4、DALL-E 3、Midjourney等多模态AI工具涌现，AI能力从文本扩展到图像、音频、视频。',
    gradient: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)'
  },
  {
    year: '2024',
    title: 'AI Agent元年',
    description: 'AI智能体技术快速发展，能够自主规划、使用工具、完成复杂任务，向通用人工智能迈进。',
    gradient: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)'
  }
])

// 主流大语言模型数据
const llmModels = ref([
  {
    name: 'GPT-4o',
    company: 'OpenAI',
    icon: 'GPT',
    description: 'OpenAI最新旗舰模型，支持文本、图像、音频多模态输入，在推理、编程、创意写作方面表现卓越。',
    gradient: 'linear-gradient(135deg, #10a37f 0%, #0d8c6d 100%)',
    tags: ['多模态', '推理强', '代码生成']
  },
  {
    name: 'Claude 3.5',
    company: 'Anthropic',
    icon: 'C3.5',
    description: 'Anthropic推出的Claude 3.5 Sonnet在多项基准测试中超越GPT-4，特别擅长长文本理解和安全对话。',
    gradient: 'linear-gradient(135deg, #d4a574 0%, #c9956c 100%)',
    tags: ['长文本', '安全性高', '推理强']
  },
  {
    name: 'Gemini 1.5',
    company: 'Google',
    icon: 'G1.5',
    description: 'Google DeepMind推出的多模态大模型，支持100万token上下文窗口，在数学和科学推理方面表现突出。',
    gradient: 'linear-gradient(135deg, #4285f4 0%, #34a853 100%)',
    tags: ['超长上下文', '多模态', '科学推理']
  },
  {
    name: 'Llama 3',
    company: 'Meta',
    icon: 'L3',
    description: 'Meta开源的大语言模型，性能接近闭源模型，支持商业使用，推动开源AI生态发展。',
    gradient: 'linear-gradient(135deg, #0668e1 0%, #0081fb 100%)',
    tags: ['开源', '可商用', '性能强']
  },
  {
    name: 'Kimi K1.5',
    company: '月之暗面',
    icon: 'Kimi',
    description: '国产大模型代表，支持超长上下文（200万字），在中文理解和长文档处理方面表现优异。',
    gradient: 'linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%)',
    tags: ['超长上下文', '中文强', '国产']
  },
  {
    name: '文心一言',
    company: '百度',
    icon: '文心',
    description: '百度推出的知识增强大语言模型，深度融合中文知识图谱，在中文场景下表现优秀。',
    gradient: 'linear-gradient(135deg, #2932e1 0%, #4b5bff 100%)',
    tags: ['中文强', '知识增强', '国产']
  }
])

// AI智能体数据
const aiAgents = ref([
  {
    name: 'AutoGPT',
    icon: '🤖',
    description: '能够自主分解任务、调用工具、执行复杂工作流的AI智能体，实现真正的自动化。'
  },
  {
    name: 'Devin',
    icon: '👨‍💻',
    description: '首个AI软件工程师，能够端到端完成软件开发任务，包括编码、调试、部署。'
  },
  {
    name: 'Manus',
    icon: '🧠',
    description: '通用型AI智能体，能够处理各种复杂任务，从数据分析到内容创作无所不能。'
  },
  {
    name: 'Copilot',
    icon: '✈️',
    description: 'GitHub Copilot等编程助手，深度集成开发环境，提供智能代码补全和建议。'
  },
  {
    name: 'Siri/小爱',
    icon: '📱',
    description: '智能语音助手，集成在手机和智能家居中，提供便捷的语音交互体验。'
  },
  {
    name: '智能客服',
    icon: '💬',
    description: '企业级AI客服系统，能够理解用户意图，提供7x24小时的智能服务支持。'
  }
])
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

/* AI部分样式 */
.ai-section {
  margin-top: 80px;
  padding-top: 60px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.ai-title {
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
}

.ai-icon {
  font-size: 2.2rem;
}

.ai-intro {
  color: var(--text-secondary);
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: 40px;
  max-width: 800px;
}

.subsection-title {
  font-size: 1.5rem;
  font-weight: 600;
  margin: 40px 0 24px;
  color: var(--text-primary);
}

/* 时间轴样式 */
.timeline {
  position: relative;
  padding-left: 30px;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 2px;
  background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%);
}

.timeline-item {
  position: relative;
  padding-bottom: 32px;
  padding-left: 24px;
}

.timeline-item:last-child {
  padding-bottom: 0;
}

.timeline-marker {
  position: absolute;
  left: -36px;
  top: 0;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
}

.timeline-year {
  color: white;
  font-weight: 700;
  font-size: 0.75rem;
}

.timeline-content {
  background: var(--bg-card);
  border-radius: 16px;
  padding: 20px 24px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.timeline-title {
  font-size: 1.2rem;
  font-weight: 600;
  margin-bottom: 8px;
  color: var(--text-primary);
}

.timeline-desc {
  color: var(--text-secondary);
  font-size: 0.95rem;
  line-height: 1.6;
}

/* 大模型卡片样式 */
.models-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
}

.model-card {
  background: var(--bg-card);
  border-radius: 16px;
  padding: 24px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
}

.model-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
  border-color: var(--primary-color);
}

.model-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 16px;
}

.model-icon {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 0.9rem;
}

.model-info {
  flex: 1;
}

.model-name {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 4px;
}

.model-company {
  font-size: 0.85rem;
  color: var(--text-muted);
}

.model-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.6;
  margin-bottom: 16px;
}

.model-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.model-tag {
  padding: 4px 12px;
  background: rgba(99, 102, 241, 0.15);
  color: var(--primary-color);
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 500;
}

/* AI智能体样式 */
.agents-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.agent-card {
  background: var(--bg-card);
  border-radius: 16px;
  padding: 24px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  text-align: center;
  transition: all 0.3s ease;
}

.agent-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
  border-color: var(--secondary-color);
}

.agent-icon {
  font-size: 3rem;
  margin-bottom: 16px;
}

.agent-name {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 8px;
}

.agent-desc {
  color: var(--text-secondary);
  font-size: 0.9rem;
  line-height: 1.5;
}

@media (max-width: 968px) {
  .models-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .agents-grid {
    grid-template-columns: repeat(2, 1fr);
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
  
  .ai-section {
    margin-top: 60px;
    padding-top: 40px;
  }
  
  .ai-title {
    font-size: 1.6rem;
  }
  
  .subsection-title {
    font-size: 1.3rem;
  }
  
  .timeline {
    padding-left: 20px;
  }
  
  .timeline-marker {
    left: -26px;
    width: 40px;
    height: 40px;
  }
  
  .timeline-year {
    font-size: 0.65rem;
  }
  
  .models-grid,
  .agents-grid {
    grid-template-columns: 1fr;
    gap: 16px;
  }
  
  .model-card,
  .agent-card {
    padding: 20px;
  }
}
</style>
