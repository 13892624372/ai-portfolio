<template>
  <section id="projects" class="section projects">
    <div class="container">
      <h2 class="section-title">项目作品</h2>
      <p class="section-subtitle">产品思维与技术实践</p>
      
      <div class="projects-list">
        <!-- 项目 1 - AI智能简历助手 -->
        <div id="project1" class="project-item" @click="openModal('project1')">
          <div class="project-header">
            <div class="project-number">1</div>
            <div class="project-info">
              <h3 class="project-title">AI智能简历助手</h3>
              <p class="project-subtitle">基于Vue3 + TypeScript的智能简历生成与优化平台，支持多模板、AI优化、PDF导出</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 2 - 影视大全网站 -->
        <div id="project2" class="project-item" @click="openModal('project2')">
          <div class="project-header">
            <div class="project-number">2</div>
            <div class="project-info">
              <h3 class="project-title">影视大全网站</h3>
              <p class="project-subtitle">基于原生JS的在线影视资源聚合与播放平台，支持多数据源、HLS播放、CORS代理</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 3 - AI面试模拟器 -->
        <div id="project3" class="project-item" @click="openModal('project3')">
          <div class="project-header">
            <div class="project-number">3</div>
            <div class="project-info">
              <h3 class="project-title">AI面试模拟器+PRD</h3>
              <p class="project-subtitle">上传你的简历和JD，体验个性化AI面试。基于Coze + DeepSeek + RAG搭建，支持自定义简历和岗位JD，动态生成面试问题</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
        
        <!-- 项目 4 - 模拟器配套数据看板 -->
        <div id="project4" class="project-item" @click="openModal('project4')">
          <div class="project-header">
            <div class="project-number">4</div>
            <div class="project-info">
              <h3 class="project-title">模拟器配套数据看板</h3>
              <p class="project-subtitle">AI面试模拟器用户反馈数据分析可视化平台，实时展示用户满意度、NPS值、用户画像等多维度数据</p>
            </div>
            <div class="expand-icon">
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
              </svg>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 弹窗 -->
    <div class="modal-overlay" v-if="activeModal" @click="closeModal">
      <div class="modal-content" @click.stop @wheel.stop @touchmove.stop>
        <button class="modal-close" @click="closeModal">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </button>
        
        <div class="modal-header">
          <div class="modal-number">{{ currentProject?.number }}</div>
          <div class="modal-title-wrapper">
            <h3 class="modal-title">{{ currentProject?.title }}</h3>
            <p class="modal-subtitle">{{ currentProject?.subtitle }}</p>
          </div>
        </div>
        
        <div class="modal-body">
          <p class="modal-description">{{ currentProject?.description }}</p>
          
          <div class="modal-section" v-if="currentProject?.features">
            <h4>项目功能</h4>
            <ul>
              <li v-for="(feature, index) in currentProject.features" :key="index">{{ feature }}</li>
            </ul>
          </div>
          
          <div class="modal-meta">
            <div class="meta-item">
              <span class="meta-label">技术栈</span>
              <span class="meta-value">{{ currentProject?.techStack }}</span>
            </div>
            <div class="meta-item">
              <span class="meta-label">项目时间</span>
              <span class="meta-value">{{ currentProject?.duration }}</span>
            </div>
          </div>
          
          <div class="modal-tags">
            <span v-for="(tag, index) in currentProject?.tags" :key="index" class="tag">{{ tag }}</span>
          </div>
          
          <div class="modal-actions">
            <!-- 项目1、2、3的按钮 -->
            <template v-if="currentProject?.number === '1'">
              <button @click="openProject1" class="btn btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                  <polyline points="15 3 21 3 21 9"></polyline>
                  <line x1="10" y1="14" x2="21" y2="3"></line>
                </svg>
                在线预览
              </button>
            </template>
            <template v-else-if="currentProject?.number === '2'">
              <button @click="openProject2" class="btn btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                  <polyline points="15 3 21 3 21 9"></polyline>
                  <line x1="10" y1="14" x2="21" y2="3"></line>
                </svg>
                在线预览
              </button>
            </template>
            <template v-else-if="currentProject?.number === '3'">
              <button @click="openChatSDK" class="btn btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                </svg>
                开始面试
              </button>
              <button @click="openEmptyModal" class="btn btn-secondary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                  <polyline points="14 2 14 8 20 8"></polyline>
                  <line x1="16" y1="13" x2="8" y2="13"></line>
                  <line x1="16" y1="17" x2="8" y2="17"></line>
                  <polyline points="10 9 9 9 8 9"></polyline>
                </svg>
                查看PRD
              </button>
            </template>
            <template v-else-if="currentProject?.number === '4'">
              <button @click="openDashboard" class="btn btn-primary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                  <line x1="3" y1="9" x2="21" y2="9"></line>
                  <line x1="9" y1="21" x2="9" y2="9"></line>
                </svg>
                查看数据看板
              </button>
              <a href="https://github.com/13892624372/dashboard" target="_blank" class="btn btn-secondary">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                </svg>
                GitHub
              </a>
            </template>
            <a v-if="currentProject?.githubUrl" :href="currentProject.githubUrl" target="_blank" class="btn btn-secondary">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
              </svg>
              GitHub
            </a>
          </div>
          

        </div>
      </div>
    </div>
    
    <!-- 面试助手弹窗 -->
    <div class="interview-modal-overlay" v-if="showInterviewIframe" @click="closeInterview">
      <div class="interview-modal-content" :class="{ 'fullscreen': isFullscreen }" @click.stop @wheel.stop @touchmove.stop>
        <div class="interview-modal-actions">
          <button class="interview-modal-btn" @click="toggleFullscreen" :title="isFullscreen ? '退出全屏' : '全屏'">
            <svg v-if="!isFullscreen" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/>
            </svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3"/>
            </svg>
          </button>
          <button class="interview-modal-btn" @click="closeInterview" title="关闭">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        
        <div class="interview-modal-header">
          <h3>AI面试模拟器</h3>
          <p>上传简历和JD即可体验AI面试</p>
        </div>
        
        <div class="interview-modal-body">
          <div class="ai-interview-iframe-wrapper">
            <iframe
              src="https://www.coze.cn/store/agent/7632215391754436660?bot_id=true&hide_nav=true"
              class="ai-interview-iframe"
              frameborder="0"
              allow="microphone"
              sandbox="allow-scripts allow-same-origin allow-forms allow-popups allow-popups-to-escape-sandbox"
            ></iframe>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 项目1弹窗 -->
    <div class="interview-modal-overlay" v-if="showProject1" @click="closeProject1">
      <div class="interview-modal-content" :class="{ 'fullscreen': isProject1Fullscreen }" @click.stop @wheel.stop @touchmove.stop>
        <div class="interview-modal-actions">
          <button class="interview-modal-btn" @click="toggleProject1Fullscreen" :title="isProject1Fullscreen ? '退出全屏' : '全屏'">
            <svg v-if="!isProject1Fullscreen" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/>
            </svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3"/>
            </svg>
          </button>
          <button class="interview-modal-btn" @click="closeProject1" title="关闭">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        
        <div class="interview-modal-header">
          <h3>AI智能简历助手</h3>
          <p>基于Vue3 + TypeScript的智能简历生成与优化平台</p>
        </div>
        
        <div class="interview-modal-body">
          <div class="ai-interview-iframe-wrapper">
            <iframe
              src="https://13892624372.github.io/resume/"
              class="ai-interview-iframe"
              frameborder="0"
            ></iframe>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 项目2弹窗 -->
    <div class="interview-modal-overlay" v-if="showProject2" @click="closeProject2">
      <div class="interview-modal-content" :class="{ 'fullscreen': isProject2Fullscreen }" @click.stop @wheel.stop @touchmove.stop>
        <div class="interview-modal-actions">
          <button class="interview-modal-btn" @click="toggleProject2Fullscreen" :title="isProject2Fullscreen ? '退出全屏' : '全屏'">
            <svg v-if="!isProject2Fullscreen" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/>
            </svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3"/>
            </svg>
          </button>
          <button class="interview-modal-btn" @click="closeProject2" title="关闭">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        
        <div class="interview-modal-header">
          <h3>影视大全网站</h3>
          <p>基于原生JS的在线影视资源聚合与播放平台</p>
        </div>
        
        <div class="interview-modal-body">
          <div class="ai-interview-iframe-wrapper">
            <iframe
              src="https://13892624372.github.io/FilmHub/"
              class="ai-interview-iframe"
              frameborder="0"
            ></iframe>
          </div>
        </div>
      </div>
    </div>

    <!-- Chat SDK 弹窗 -->
    <div class="interview-modal-overlay" v-if="showChatSDK" @click="closeChatSDK">
      <div class="interview-modal-content chat-sdk-modal" @click.stop @wheel.stop @touchmove.stop>
        <div class="interview-modal-actions" :class="{ 'floating': isChatFullscreen }">
          <button class="interview-modal-btn" @click="toggleChatFullscreen" :title="isChatFullscreen ? '退出全屏' : '全屏'">
            <svg v-if="!isChatFullscreen" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/>
            </svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3"/>
            </svg>
          </button>
          <button class="interview-modal-btn" @click="closeChatSDK" title="关闭">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>

        <div v-if="!isChatFullscreen" class="interview-modal-header">
          <h3>AI面试模拟器</h3>
          <p>上传你的简历和JD，体验个性化AI面试</p>
        </div>

        <div class="chat-sdk-container" :class="{ 'fullscreen': isChatFullscreen }" ref="chatContainerRef"></div>
      </div>
    </div>

    <!-- 数据看板弹窗 -->
    <div class="interview-modal-overlay" v-if="showDashboard" @click="closeDashboard">
      <div class="interview-modal-content dashboard-modal" :class="{ 'fullscreen': isDashboardFullscreen }" @click.stop @wheel.stop @touchmove.stop>
        <div class="interview-modal-actions" :class="{ 'floating': isDashboardFullscreen }">
          <button class="interview-modal-btn" @click="toggleDashboardFullscreen" :title="isDashboardFullscreen ? '退出全屏' : '全屏'">
            <svg v-if="!isDashboardFullscreen" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/>
            </svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3"/>
            </svg>
          </button>
          <button class="interview-modal-btn" @click="closeDashboard" title="关闭">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>

        <div v-if="!isDashboardFullscreen" class="interview-modal-header">
          <h3>用户反馈数据看板</h3>
          <p>AI面试模拟器用户反馈数据分析可视化平台</p>
        </div>

        <div class="dashboard-container" :class="{ 'fullscreen': isDashboardFullscreen }">
          <iframe
            src="https://13892624372.github.io/dashboard/"
            class="dashboard-iframe"
            frameborder="0"
          ></iframe>
        </div>
      </div>
    </div>

    <!-- PRD文档弹窗 -->
    <div class="interview-modal-overlay" v-if="showEmptyModal" @click="closeEmptyModal">
      <div class="interview-modal-content prd-modal-content" :class="{ 'fullscreen': isEmptyFullscreen }" @click.stop @wheel.stop @touchmove.stop>
        <div class="interview-modal-actions">
          <button class="interview-modal-btn" @click="toggleEmptyFullscreen" :title="isEmptyFullscreen ? '退出全屏' : '全屏'">
            <svg v-if="!isEmptyFullscreen" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3H5a2 2 0 0 0-2 2v3m18 0V5a2 2 0 0 0-2-2h-3m0 18h3a2 2 0 0 0 2-2v-3M3 16v3a2 2 0 0 0 2 2h3"/>
            </svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M8 3v3a2 2 0 0 1-2 2H3m18 0h-3a2 2 0 0 1-2-2V3m0 18v-3a2 2 0 0 1 2-2h3M3 16h3a2 2 0 0 1 2 2v3"/>
            </svg>
          </button>
          <button class="interview-modal-btn" @click="closeEmptyModal" title="关闭">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        
        <div class="interview-modal-header">
          <h3>AI面试模拟器 - PRD文档</h3>
          <p>产品需求文档 v1.0</p>
        </div>
        
        <div class="prd-layout">
          <!-- 左侧导航栏 -->
          <div class="prd-nav">
            <div class="prd-nav-header">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <line x1="3" y1="12" x2="21" y2="12"></line>
                <line x1="3" y1="6" x2="21" y2="6"></line>
                <line x1="3" y1="18" x2="21" y2="18"></line>
              </svg>
              文档导航
            </div>
            <div class="prd-nav-content">
              <div class="prd-nav-section" v-for="(section, index) in prdNavSections" :key="index">
                <div 
                  class="prd-nav-title" 
                  :class="{ 'active': activeSection === section.id, 'expanded': expandedSections.includes(section.id) }"
                  @click="toggleSection(section.id)"
                >
                  <span class="prd-nav-arrow" v-if="section.children">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <polyline points="9 18 15 12 9 6"></polyline>
                    </svg>
                  </span>
                  <span @click.stop="scrollToSection(section.id)">{{ section.title }}</span>
                </div>
                <div class="prd-nav-children" v-if="section.children && expandedSections.includes(section.id)">
                  <div 
                    v-for="(child, childIndex) in section.children" 
                    :key="childIndex"
                    class="prd-nav-child"
                    :class="{ 'active': activeSection === child.id }"
                    @click="scrollToSection(child.id)"
                  >
                    {{ child.title }}
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 右侧内容区域 -->
          <div class="prd-modal-body prd-modal-body-with-nav" ref="prdContentRef" @scroll="handlePrdScroll">
            <div class="prd-content">
              <h1 id="prd-title">AI面试模拟器 产品需求文档</h1>
              
              <h2 id="prd-basic">文档基础信息</h2>
            <table>
              <tr><td>文档版本</td><td>1.0</td></tr>
              <tr><td>创建日期</td><td>2026-04-27</td></tr>
              <tr><td>作者</td><td>田雨</td></tr>
            </table>

            <h2 id="prd-summary">执行摘要</h2>
            <p>本产品是一个AI面试模拟器，核心价值是"基于用户自己的简历和JD生成个性化面试"。v1.0已验证固定岗位流程可行，v2.0支持用户上传自定义文件，v3.0规划一键生成。当前卡点在知识库异步处理导致的检索延迟，预计2周内解决。成功标准：完成率≥60%，满意度≥80%。</p>

            <h2 id="prd-terms">术语表</h2>
            <table>
              <tr><th>术语</th><th>说明</th></tr>
              <tr><td>Agent</td><td>智能体，基于大模型构建的自动化对话程序</td></tr>
              <tr><td>Coze</td><td>字节跳动旗下的AI智能体开发平台</td></tr>
              <tr><td>DeepSeek-V3.2</td><td>深度求索公司开发的大语言模型</td></tr>
              <tr><td>RAG</td><td>检索增强生成，从知识库中检索相关内容再生成回答</td></tr>
              <tr><td>知识库</td><td>Coze平台中的向量数据库</td></tr>
              <tr><td>对话流</td><td>Coze中的流程编排模式</td></tr>
              <tr><td>工作流</td><td>Coze中的自动化流程</td></tr>
            </table>

            <h2 id="prd-competitor">竞品分析与差异化</h2>
            <h3>竞品概览</h3>
            <table>
              <tr><th>竞品</th><th>核心能力</th><th>主要局限</th></tr>
              <tr><td>FinalRound AI</td><td>真实面试录音分析</td><td>收费高，面向海外</td></tr>
              <tr><td>Yoodli</td><td>AI教练+肢体语音分析</td><td>功能臃肿，学习成本高</td></tr>
              <tr><td>OfferBot</td><td>题库式面试模拟</td><td>问题固定，无法个性化</td></tr>
            </table>

            <h3>差异化优势</h3>
            <ol>
              <li><strong>简单直接</strong>：上传简历、上传JD、开始面试，三步完成</li>
              <li><strong>真正个性化</strong>：基于用户上传内容动态生成问题，非固定题库</li>
              <li><strong>求职者视角</strong>：帮用户练习而非被评价，无压力</li>
              <li><strong>低成本</strong>：完全免费，技术栈轻量</li>
              <li><strong>流程可控</strong>：固定5个问题、5个维度，体验一致</li>
            </ol>

            <h2 id="prd-background">项目背景</h2>
            <p><strong>核心问题</strong>：市面上面试工具多为通用模板，无法针对个人简历和岗位个性化提问。</p>
            <p><strong>核心目标</strong>：打造能根据用户简历和目标岗位JD，自动生成个性化面试问题的AI Agent。</p>
            <p><strong>需求范围</strong>：v1.0固定场景 → v2.0自定义文件 → v3.0一键生成。</p>

            <h2 id="prd-versions">版本迭代</h2>
            <table>
              <tr><th>版本</th><th>核心目标</th><th>状态</th></tr>
              <tr><td>V1.0</td><td>固定简历+固定JD，跑通面试流程</td><td>已达成</td></tr>
              <tr><td>V2.0</td><td>用户上传自己的简历和JD</td><td>进行中</td></tr>
              <tr><td>V3.0</td><td>输入岗位名称，系统自动生成JD</td><td>规划中</td></tr>
            </table>

            <h2 id="prd-v1">v1.0版本详情</h2>
            <h3 id="prd-v1-scope">功能范围</h3>
            <ul>
              <li>固定知识库：预先上传个人简历、AI产品经理JD、面试题库</li>
              <li>开场白：自我介绍→5个问题→综合点评</li>
              <li>三段落回复：点评→追问/过渡→下一个问题</li>
              <li>5问题固定：覆盖5个能力维度</li>
              <li>结束点评：优势、待提升、匹配度评估</li>
            </ul>

            <h3 id="prd-v1-tech">技术架构</h3>
            <p>平台：Coze | 大模型：DeepSeek-V3.2 | 知识库：Coze知识库（RAG） | 模式：自主规划模式</p>

            <h3 id="prd-v1-issues">问题及解决方案</h3>
            <table>
              <tr><th>序号</th><th>问题</th><th>解决方案</th></tr>
              <tr><td>1</td><td>AI会杜撰简历中不存在的项目</td><td>加入「系统硬指令」，强制要求先检索知识库再提问</td></tr>
              <tr><td>2</td><td>AI不会点评，直接连续问下一个问题</td><td>设计「三段落结构」prompt：点评→追问/过渡→下一个问题</td></tr>
              <tr><td>3</td><td>问题数量无限，不会主动结束</td><td>固定5个问题，第5问后强制输出综合点评</td></tr>
              <tr><td>4</td><td>问题类型单一，只问技术问题</td><td>设计5维度覆盖：项目经历、技能匹配、解决问题、学习能力、岗位动机</td></tr>
              <tr><td>5</td><td>知识库名称写错导致检索失败</td><td>统一命名规范，Prompt中引用名称与实际一致</td></tr>
            </table>

            <h3 id="prd-v1-limit">v1.0限制</h3>
            <ol>
              <li>只能面试AI产品经理岗位</li>
              <li>简历和JD是写死的</li>
              <li>别人无法使用（绑定个人账号知识库）</li>
            </ol>

            <h2 id="prd-v2">v2.0版本详情</h2>
            <h3 id="prd-v2-goal">核心目标</h3>
            <p>让用户能够上传自己的简历和JD，实现真正的个性化面试。</p>

            <h3 id="prd-v2-user">用户画像</h3>
            <ul>
              <li>应届毕业生：缺乏面试经验，希望提升信心</li>
              <li>职场新人：1-3年经验，准备跳槽或转行</li>
              <li>跨行业转行者：需要练习如何讲述过往经验</li>
            </ul>

            <h3 id="prd-v2-scenario">使用场景</h3>
            <ul>
              <li><strong>场景一</strong>：用户拿到心仪岗位JD，针对性准备面试</li>
              <li><strong>场景二</strong>：测试简历在不同岗位下的匹配度</li>
              <li><strong>场景三</strong>：面试前1小时快速模拟练习</li>
            </ul>

            <h3 id="prd-v2-scope">功能范围</h3>
            <table>
              <tr><th>功能</th><th>说明</th></tr>
              <tr><td>文件上传</td><td>支持PDF、Word、图片格式的简历和JD</td></tr>
              <tr><td>对话流架构</td><td>从自主规划模式切换到对话流模式</td></tr>
              <tr><td>临时知识库</td><td>动态创建临时知识库存储上传的文件</td></tr>
              <tr><td>知识库检索</td><td>检索临时知识库内容传给大模型</td></tr>
              <tr><td>个性化提问</td><td>基于用户上传内容生成问题</td></tr>
              <tr><td>5问题+5维度</td><td>保持v1.0的流程结构</td></tr>
              <tr><td>结束自动清理</td><td>面试结束后清空临时知识库</td></tr>
            </table>

            <h3 id="prd-v2-tech">技术架构</h3>
            <p>平台：Coze | 大模型：DeepSeek-V3.2 | 模式：对话流模式</p>
            <p>核心节点：开始节点、知识库写入、知识库检索、大模型、结束节点</p>

            <h3 id="prd-v2-issues">问题及解决方案</h3>
            <table>
              <tr><th>序号</th><th>问题</th><th>解决方案</th></tr>
              <tr><td>1</td><td>工作流无法动态创建知识库</td><td>提前创建固定临时知识库，每次写入覆盖</td></tr>
              <tr><td>2</td><td>知识库检索节点Query不精准，只召回简历内容</td><td>修改Query为通用描述，设置最大召回数量</td></tr>
              <tr><td>3</td><td>Agent不调用工作流</td><td>结构化prompt强制调用工作流</td></tr>
              <tr><td>4</td><td>工作流模式报「平台错误」</td><td>检查开始节点USER_INPUT参数是否正确配置</td></tr>
              <tr><td>5</td><td>知识库删除节点要求documentID必填</td><td>设计循环节点遍历删除，或采用手动清空</td></tr>
              <tr><td>6</td><td>知识库写入后状态为「处理中」，检索不到内容</td><td>改用快速解析策略，或在工作流加循环等待节点</td></tr>
            </table>

            <h2 id="prd-arch">项目架构图</h2>
            <div class="prd-architecture">
              <p>用户 → 上传简历+JD → Agent收集文件 → 调用工作流</p>
              <p>↓</p>
              <p>工作流解析文件 → 提取文本 → 存入context</p>
              <p>↓</p>
              <p>工作流生成开场白</p>
              <p>↓</p>
              <p>Agent接管面试（强制遵循context内容并进行5轮问答+点评+结束）</p>
            </div>

            <h2 id="prd-future">后续规划</h2>
            <table>
              <tr><th>功能</th><th>说明</th></tr>
              <tr><td>一键生成</td><td>用户只需输入岗位名称，系统自动生成JD</td></tr>
              <tr><td>多轮深度追问</td><td>对每个回答进行2-3轮追问</td></tr>
              <tr><td>面试报告</td><td>生成结构化面试评估报告</td></tr>
              <tr><td>多岗位切换</td><td>同一份简历面试不同岗位</td></tr>
              <tr><td>历史记录</td><td>保存面试历史，追踪进步曲线</td></tr>
            </table>

            <h2 id="prd-ux">用户交互与体验设计</h2>
            <h3>入口与形态</h3>
            <p>通过Coze分享链接访问，可嵌入个人网站。界面为对话式聊天窗口，自适应PC和移动端。</p>

            <h3>交互流程</h3>
            <p>用户输入"开始面试"，Agent提示上传简历和JD文件。用户依次上传两个文件（支持PDF、Word、图片）。Agent调用工作流处理文件并生成开场白。用户自我介绍后，Agent开始提问，每个回答后输出点评和建议，再提出下一个问题。共5个问题，覆盖项目经历、技能匹配、解决问题能力、学习成长、岗位动机五个维度。第5题结束后输出综合点评（优势、待提升、匹配度），面试结束。</p>

            <h3>状态提示</h3>
            <ul>
              <li>等待文件时提示"请上传简历和JD文件"</li>
              <li>处理中提示"正在分析文件，请稍候"</li>
              <li>结束时提示"面试结束，感谢参与"</li>
            </ul>

            <h3>兜底与反馈</h3>
            <ul>
              <li>未上传文件就要求开始时提示补充</li>
              <li>文件解析失败提示重试或换格式</li>
              <li>工作流调用失败提示系统繁忙</li>
              <li>不支持格式提示仅支持PDF、Word、图片</li>
            </ul>

            <h2 id="prd-logic">功能构建逻辑需求</h2>
            <h3>基础模型</h3>
            <p>DeepSeek-V3.2</p>

            <h3>输入预处理</h3>
            <p>用户上传简历和JD后自动解析提取文本。解析失败时返回提示。用户对话内容不做自动纠错。</p>

            <h3>系统Prompt设计</h3>
            <p>分为三个阶段：</p>
            <ul>
              <li><strong>第一阶段</strong>：文件收集调度，用户说"开始面试"时检查文件，缺则补充，完整后触发工作流</li>
              <li><strong>第二阶段</strong>：开场白生成，基于解析后的简历和JD内容生成面试开场白</li>
              <li><strong>第三阶段</strong>：提问与点评，严格基于文件内容提问，每次一问，回答后先点评再问下一题，共5题，5题结束后输出综合点评并结束</li>
            </ul>

            <h3>工作流设计</h3>
            <p>开始节点接收简历和JD文件 → 知识库写入节点存入临时知识库 → 知识库检索节点召回内容 → 大模型节点基于召回内容生成开场白 → 结束节点返回开场白给Agent。后续面试由Agent的Prompt独立完成。</p>

            <h3>知识库管理</h3>
            <p>面试开始前清空临时知识库旧数据。采用快速解析策略减少处理时间。检索采用混合策略。</p>

            <h2 id="prd-data">数据与知识库需求</h2>
            <h3>知识库需求</h3>
            <p>本项目需要构建一个临时知识库，用于存储用户每次面试上传的简历和JD文件。知识库不需要长期保留历史数据，每次面试结束后应清空。知识库采用快速解析策略，支持PDF、Word、图片格式的文档解析。检索策略采用混合检索（关键词+向量）。</p>

            <h3>数据标注需求</h3>
            <p>需要准备两类测试数据：</p>
            <ul>
              <li><strong>第一类</strong>：简历和JD的配对测试集，包含10份不同岗位的简历和对应的JD，用于验证Agent是否能够基于不同内容生成个性化问题</li>
              <li><strong>第二类</strong>：面试对话评测集，包含5轮完整面试的对话记录，每轮包含自我介绍、5个问答和综合点评，用于验证流程完整性和回答质量</li>
            </ul>

            <h3>用户行为埋点</h3>
            <table>
              <tr><th>埋点字段</th><th>用途</th><th>触发动作</th></tr>
              <tr><td>是否上传简历+JD</td><td>衡量用户是否理解使用流程</td><td>完成率低于50%时，优化上传引导文案</td></tr>
              <tr><td>是否完成全部5个问题</td><td>核心转化指标</td><td>完成率低于60%时，抽查对话日志，定位流失点</td></tr>
              <tr><td>用户中断在第几题</td><td>定位流失点</td><td>流失集中在某题时，优化该维度Prompt</td></tr>
              <tr><td>用户反馈评分(1-5)</td><td>满意度指标</td><td>评分低于3分的反馈，24小时内人工跟进</td></tr>
            </table>

            <h2 id="prd-nfr">非功能需求</h2>
            <table>
              <tr><th>需求类型</th><th>具体指标</th></tr>
              <tr><td>性能</td><td>文件解析首Token时间 ≤ 3秒；完整开场白生成 ≤ 8秒；单个问题生成 ≤ 5秒；完整5轮面试总耗时 ≤ 5分钟</td></tr>
              <tr><td>准确性</td><td>问题与简历内容的匹配准确率 ≥ 95%；不得杜撰简历中不存在的项目或技能；点评内容与用户回答的相关性 ≥ 90%</td></tr>
              <tr><td>安全性</td><td>防止越狱指令；防止用户上传恶意文件；用户上传文件不持久化存储，面试结束后自动清理</td></tr>
              <tr><td>可用性</td><td>服务可用性 ≥ 99.5%；工作流调用成功率 ≥ 98%；文件解析成功率 ≥ 95%</td></tr>
              <tr><td>兼容性</td><td>支持Chrome、Edge、Safari最新版本；支持移动端浏览器访问；支持PDF、Word、JPG、PNG格式文件上传，单个文件大小 ≤ 10MB</td></tr>
              <tr><td>可维护性</td><td>Prompt支持热更新；知识库支持手动清空；对话流支持版本回滚</td></tr>
            </table>

            <h2 id="prd-eval">算法度量与评估标准</h2>
            <h3>离线评估（上线前）</h3>
            <p>使用10份不同岗位的简历和JD配对作为测试集，运行完整面试流程。由评测小组（3人）从三个维度对面试质量进行打分，每个维度1-5分。</p>
            <p><strong>三个评估维度</strong>：</p>
            <ul>
              <li><strong>问题相关性</strong>：评估Agent提出的问题是否与简历和JD内容相关，是否存在杜撰内容</li>
              <li><strong>点评准确度</strong>：评估Agent的点评是否切中用户回答的要害，建议是否有建设性</li>
              <li><strong>流程完整性</strong>：评估Agent是否严格遵守开场白、5个问题、综合点评的流程，问题数量是否控制在5个</li>
            </ul>
            <p><strong>通过标准</strong>：三个维度平均分 ≥ 4.0分；单个样本不得出现杜撰内容（否则直接判定不通过）。</p>

            <h3>在线评估（上线后）</h3>
            <p><strong>灰度发布</strong>：首先开放10%用户使用新版本，对比旧版本的用户反馈。</p>
            <p><strong>核心指标</strong>：用户完成率、平均对话轮次、用户主动中断率、用户反馈评分。</p>
            <p><strong>护栏机制</strong>：如果用户主动中断率 > 40%，或出现杜撰内容投诉，立即回滚到上一稳定版本。连续3次版本迭代均通过评估后，全量发布。</p>

            <h3>核心成功指标</h3>
            <ul>
              <li>用户完成率（完成全部5个问题的比例）≥ 60%为及格，≥ 75%为优秀</li>
              <li>用户复购率（7天内再次使用）≥ 30%</li>
              <li>用户主动中断率 ≤ 40%</li>
              <li>面试结束后用户反馈评分（1-5分）平均分 ≥ 4.0</li>
            </ul>
            <p>以上指标按月统计，连续两个月不达标则触发复盘。</p>

            <h3>持续监测</h3>
            <p>每周抽取20条对话记录进行人工抽检，评估问题质量和点评准确度。每月输出一次评估报告。</p>

            <h2 id="prd-tech">技术栈总结</h2>
            <table>
              <tr><th>组件</th><th>选型</th></tr>
              <tr><td>AI应用平台</td><td>Coze（扣子）</td></tr>
              <tr><td>大模型</td><td>DeepSeek-V3.2</td></tr>
              <tr><td>知识库</td><td>Coze知识库（RAG）</td></tr>
              <tr><td>流程控制</td><td>Coze对话流</td></tr>
              <tr><td>文件解析</td><td>Coze内置/TextIn插件</td></tr>
            </table>

            <h2 id="prd-kpi">核心成功指标</h2>
            <ul>
              <li>用户完成率（完成全部5个问题）≥ 60%</li>
              <li>用户复购率（7天内再次使用）≥ 30%</li>
              <li>用户主动中断率 ≤ 40%</li>
              <li>用户反馈评分平均分 ≥ 4.0</li>
            </ul>

            <h2 id="prd-risk">AI特定风险与约束</h2>
            <h3>幻觉风险</h3>
            <p>模型可能编造简历中不存在的项目或技能。</p>
            <p><strong>应对方案</strong>：Prompt强制要求只能基于上传内容提问；知识库检索增强。</p>

            <h3>安全合规</h3>
            <p>每次面试开场前告知用户"本次面试由AI生成，仅用于模拟练习"。用户上传文件不作为训练数据，面试结束后立即清空。</p>
          </div>
        </div>
      </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted, nextTick, defineExpose } from 'vue'

const activeModal = ref(null)
const isProject3Expanded = ref(false)
const showInterviewIframe = ref(false)
const isFullscreen = ref(false)
const showEmptyModal = ref(false)
const isEmptyFullscreen = ref(false)
const showProject1 = ref(false)
const isProject1Fullscreen = ref(false)
const showProject2 = ref(false)
const isProject2Fullscreen = ref(false)

// PRD导航数据
const prdNavSections = ref([
  { id: 'prd-basic', title: '文档基础信息' },
  { id: 'prd-summary', title: '执行摘要' },
  { id: 'prd-terms', title: '术语表' },
  { id: 'prd-competitor', title: '竞品分析与差异化' },
  { id: 'prd-background', title: '项目背景' },
  { id: 'prd-versions', title: '版本迭代' },
  {
    id: 'prd-v1',
    title: 'v1.0版本详情',
    children: [
      { id: 'prd-v1-scope', title: '功能范围' },
      { id: 'prd-v1-tech', title: '技术架构' },
      { id: 'prd-v1-issues', title: '问题及解决方案' },
      { id: 'prd-v1-limit', title: 'v1.0限制' }
    ]
  },
  {
    id: 'prd-v2',
    title: 'v2.0版本详情',
    children: [
      { id: 'prd-v2-goal', title: '核心目标' },
      { id: 'prd-v2-user', title: '用户画像' },
      { id: 'prd-v2-scenario', title: '使用场景' },
      { id: 'prd-v2-scope', title: '功能范围' },
      { id: 'prd-v2-tech', title: '技术架构' },
      { id: 'prd-v2-issues', title: '问题及解决方案' }
    ]
  },
  { id: 'prd-arch', title: '项目架构图' },
  { id: 'prd-future', title: '后续规划' },
  { id: 'prd-ux', title: '用户交互与体验设计' },
  { id: 'prd-logic', title: '功能构建逻辑需求' },
  { id: 'prd-data', title: '数据与知识库需求' },
  { id: 'prd-nfr', title: '非功能需求' },
  { id: 'prd-eval', title: '算法度量与评估标准' },
  { id: 'prd-tech', title: '技术栈总结' },
  { id: 'prd-kpi', title: '核心成功指标' },
  { id: 'prd-risk', title: 'AI特定风险与约束' }
])

const expandedSections = ref(['prd-v1', 'prd-v2'])
const activeSection = ref('')
const prdContentRef = ref(null)

const projectsData = {
  project1: {
    number: '1',
    title: 'AI智能简历助手',
    subtitle: '基于Vue3 + TypeScript的智能简历生成与优化平台',
    gradient: 'linear-gradient(135deg, #ec4899 0%, #f472b6 100%)',
    description: '一个功能完善的智能化简历生成平台，集成AI技术帮助用户快速创建专业简历。支持多种精美模板、实时预览、智能JD解析、一键PDF导出等功能，提供从编辑到投递的完整简历制作解决方案。',
    features: [
      '可视化编辑器：支持基本信息、工作经历、教育背景、项目经验等模块编辑',
      '多模板系统：提供经典、现代、创意、极简四种专业简历模板',
      'AI智能优化：集成AI服务自动优化简历内容，提升简历质量',
      '实时预览：编辑内容实时同步预览，所见即所得',
      'JD智能解析：解析职位描述，自动提取关键技能要求并匹配简历',
      'PDF导出：基于html2canvas和jsPDF实现高质量PDF导出',
      '数据持久化：使用Pinia状态管理，本地存储简历数据',
      '响应式设计：基于Element Plus和Tailwind CSS，完美适配多端设备'
    ],
    techStack: 'Vue3, TypeScript, Pinia, Element Plus, Tailwind CSS, html2canvas, jsPDF, Vite',
    duration: '2025.03 - 至今',
    tags: ['Vue3', 'TypeScript', 'AI应用', '简历生成', 'PDF导出'],
    demoUrl: 'https://13892624372.github.io/resume/',
    githubUrl: 'https://github.com/13892624372/resume'
  },
  project2: {
    number: '2',
    title: '影视大全网站',
    subtitle: '基于原生JS的在线影视资源聚合与播放平台',
    gradient: 'linear-gradient(135deg, #06b6d4 0%, #0891b2 100%)',
    description: '一个功能完善的在线影视资源聚合平台，整合多个第三方数据源，提供电影、电视剧、综艺、动漫等海量影视内容的搜索、浏览和播放服务。采用原生JavaScript开发，通过公共CORS代理解决跨域问题，部署于GitHub Pages。',
    features: [
      '多数据源支持：支持配置多个影视数据源，自动切换可用源',
      '智能搜索：支持按名称、类型、年份等多维度搜索影视资源',
      '分类浏览：电影、电视剧、综艺、动漫等分类筛选展示',
      '详情展示：展示影视作品的详细信息、剧情简介、演员阵容',
      '在线播放：集成HLS.js播放器，支持M3U8格式视频在线播放',
      '收藏与历史：本地存储收藏列表和观看历史，方便续看',
      'CORS代理方案：使用公共CORS代理服务解决浏览器跨域限制',
      '响应式设计：完美适配桌面端和移动端，支持深色主题'
    ],
    techStack: 'HTML5, CSS3, JavaScript, HLS.js, GitHub Pages, CORS Proxy',
    duration: '2025.03 - 2025.03',
    tags: ['JavaScript', '影视网站', 'HLS播放', 'CORS代理', 'GitHub部署'],
    demoUrl: 'https://13892624372.github.io/FilmHub/',
    githubUrl: 'https://github.com/13892624372/FilmHub'
  },
  project3: {
    number: '3',
    title: 'AI面试模拟器+PRD',
    subtitle: '基于Coze + DeepSeek + RAG的个性化AI面试模拟器',
    gradient: 'linear-gradient(135deg, #8b5cf6 0%, #a78bfa 100%)',
    description: '一个基于Coze平台搭建的AI面试模拟器，集成DeepSeek大模型和RAG技术。支持用户上传自定义简历和岗位JD，系统会动态生成个性化面试问题，固定5轮问答覆盖5个能力维度（项目经历、技能匹配、解决问题、学习成长、岗位动机），帮助求职者针对性准备面试。',
    features: [
      '个性化面试：基于用户上传的简历和JD动态生成面试问题，非固定题库',
      'RAG增强：使用Coze知识库实现检索增强生成，确保问题与材料高度相关',
      '5轮问答：固定5个问题，覆盖项目经历、技能匹配、解决问题、学习成长、岗位动机5个维度',
      '即时点评：每轮回答后提供针对性点评和建议',
      '综合评估：面试结束后输出优势分析、待提升点和岗位匹配度评估',
      '多格式支持：支持PDF、Word、图片格式的简历和JD上传'
    ],
    techStack: 'Coze, DeepSeek, RAG, 对话流, 知识库',
    duration: '2025.04 - 至今',
    tags: ['Coze', 'DeepSeek', 'RAG', '对话流'],
    demoUrl: 'https://www.coze.cn/store/agent/7632215391754436660?bot_id=true',
    githubUrl: null
  },
  project4: {
    number: '4',
    title: '用户反馈数据看板',
    subtitle: 'AI面试模拟器用户反馈数据分析可视化平台',
    gradient: 'linear-gradient(135deg, #10b981 0%, #34d399 100%)',
    description: '一个专为AI面试模拟器打造的用户反馈数据可视化看板，实时收集和分析用户使用数据，包括满意度评分、NPS值、用户画像、行业分布、五维度能力评估等多维度数据展示，帮助产品持续优化。',
    features: [
      '实时数据展示：总问卷数、平均满意度、NPS值等核心指标一目了然',
      '用户画像分析：展示用户行业分布、职位分布等画像数据',
      '满意度趋势：追踪用户满意度变化趋势，及时发现产品问题',
      '五维度评分：展示项目经历、技能匹配、解决问题、学习成长、岗位动机五个维度的评分',
      'NPS分布：分析用户推荐意愿分布，识别忠实用户和改进空间',
      '用户反馈收集：展示用户认为做得好的方面和改进建议',
      '响应式设计：适配桌面端和移动端，支持深色主题'
    ],
    techStack: 'HTML5, CSS3, JavaScript, ECharts, GitHub Pages',
    duration: '2025.05 - 至今',
    tags: ['数据可视化', '用户反馈', 'ECharts', 'GitHub部署'],
    demoUrl: 'https://13892624372.github.io/dashboard/',
    githubUrl: null,
    isIframe: true
  }
}

const currentProject = computed(() => {
  return activeModal.value ? projectsData[activeModal.value] : null
})

const openModal = (projectId) => {
  activeModal.value = projectId
  document.body.style.overflow = 'hidden'
}

const closeModal = () => {
  activeModal.value = null
  document.body.style.overflow = ''
}

const toggleProject3 = () => {
  isProject3Expanded.value = !isProject3Expanded.value
}

const startInterview = () => {
  showInterviewIframe.value = true
  isFullscreen.value = false
}

const closeInterview = () => {
  showInterviewIframe.value = false
  isFullscreen.value = false
}

const toggleFullscreen = () => {
  isFullscreen.value = !isFullscreen.value
}

const openEmptyModal = () => {
  showEmptyModal.value = true
  isEmptyFullscreen.value = false
}

const closeEmptyModal = () => {
  showEmptyModal.value = false
  isEmptyFullscreen.value = false
}

const toggleEmptyFullscreen = () => {
  isEmptyFullscreen.value = !isEmptyFullscreen.value
}

const openProject1 = () => {
  showProject1.value = true
  isProject1Fullscreen.value = false
}

const closeProject1 = () => {
  showProject1.value = false
  isProject1Fullscreen.value = false
}

const toggleProject1Fullscreen = () => {
  isProject1Fullscreen.value = !isProject1Fullscreen.value
}

const openProject2 = () => {
  showProject2.value = true
  isProject2Fullscreen.value = false
}

const closeProject2 = () => {
  showProject2.value = false
  isProject2Fullscreen.value = false
}

const toggleProject2Fullscreen = () => {
  isProject2Fullscreen.value = !isProject2Fullscreen.value
}

// Chat SDK 弹窗控制
const showChatSDK = ref(false)
const isChatFullscreen = ref(false)
const chatContainerRef = ref(null)
let chatClient = null

// 数据看板弹窗控制
const showDashboard = ref(false)
const isDashboardFullscreen = ref(false)

const openDashboard = () => {
  showDashboard.value = true
  isDashboardFullscreen.value = false
  document.body.style.overflow = 'hidden'
}

const closeDashboard = () => {
  showDashboard.value = false
  isDashboardFullscreen.value = false
  document.body.style.overflow = ''
}

const toggleDashboardFullscreen = () => {
  isDashboardFullscreen.value = !isDashboardFullscreen.value
}

const initChatSDK = () => {
  if (!chatContainerRef.value || !window.CozeWebSDK) {
    console.error('Chat SDK 未加载或容器不存在')
    return
  }

  // 如果已经初始化，先销毁
  if (chatClient) {
    chatClient.destroy()
    chatClient = null
  }

  try {
    console.log('开始初始化 Chat SDK...')
    chatClient = new window.CozeWebSDK.WebChatClient({
      config: {
        bot_id: '7632215391754436660',
      },
      auth: {
        type: 'token',
        token: 'pat_sDGZGAuu8wJqQUChnsL0z0OyxRkhxIWoeF2ubQmTsz0LBwq9q0dmH58I48ypFr1k',
        onRefreshToken: async () => 'pat_sDGZGAuu8wJqQUChnsL0z0OyxRkhxIWoeF2ubQmTsz0LBwq9q0dmH58I48ypFr1k',
      },
      userInfo: {
        id: 'user',
        url: 'https://lf-coze-web-cdn.coze.cn/obj/eden-cn/lm-lgvj/ljhwZthlaukjlkulzlp/coze/coze-logo.png',
        nickname: '用户',
      },
      ui: {
        base: {
          layout: 'pc',
          lang: 'zh-CN',
          zIndex: 1000,
        },
        asstBtn: {
          isNeed: false,
        },
        header: {
          isShow: false,
        },
        chatBot: {
          title: 'AI面试模拟器',
          uploadable: true,
          width: '100%',
          el: chatContainerRef.value,
        },
      },
    })
    console.log('Chat SDK 初始化成功')
    
    // 隐藏悬浮球后，需要主动调用 showChatBot() 显示聊天窗口
    setTimeout(() => {
      if (chatClient && chatClient.showChatBot) {
        chatClient.showChatBot()
        console.log('Chat 窗口已显示')
      }
    }, 200)
  } catch (error) {
    console.error('Chat SDK 初始化失败:', error)
  }
}

const openChatSDK = () => {
  showChatSDK.value = true
  isChatFullscreen.value = false
  document.body.style.overflow = 'hidden'

  // 等待 DOM 更新后初始化
  nextTick(() => {
    setTimeout(() => {
      initChatSDK()
    }, 200)
  })
}

const closeChatSDK = () => {
  showChatSDK.value = false
  isChatFullscreen.value = false
  document.body.style.overflow = ''

  // 销毁 Chat SDK 实例
  if (chatClient) {
    chatClient.destroy()
    chatClient = null
  }
}

const toggleChatFullscreen = () => {
  isChatFullscreen.value = !isChatFullscreen.value
}

// PRD导航相关方法
const toggleSection = (sectionId) => {
  const index = expandedSections.value.indexOf(sectionId)
  if (index > -1) {
    expandedSections.value.splice(index, 1)
  } else {
    expandedSections.value.push(sectionId)
  }
}

const scrollToSection = (sectionId) => {
  const element = document.getElementById(sectionId)
  if (element && prdContentRef.value) {
    const container = prdContentRef.value
    const containerHeight = container.clientHeight
    const elementHeight = element.offsetHeight
    // 计算让元素居中显示的位置
    const scrollPosition = element.offsetTop - (containerHeight / 2) + (elementHeight / 2)
    container.scrollTo({
      top: Math.max(0, scrollPosition),
      behavior: 'smooth'
    })
    activeSection.value = sectionId
  }
}

const handlePrdScroll = () => {
  if (!prdContentRef.value) return
  
  const scrollTop = prdContentRef.value.scrollTop
  const containerHeight = prdContentRef.value.clientHeight
  const viewportCenter = scrollTop + (containerHeight / 2)
  
  const sections = prdNavSections.value.flatMap(section => {
    const items = [{ id: section.id }]
    if (section.children) {
      items.push(...section.children.map(child => ({ id: child.id })))
    }
    return items
  })
  
  // 找到距离视口中心最近的元素
  let closestSection = null
  let closestDistance = Infinity
  
  for (const section of sections) {
    const element = document.getElementById(section.id)
    if (element) {
      const elementCenter = element.offsetTop + (element.offsetHeight / 2)
      const distance = Math.abs(viewportCenter - elementCenter)
      if (distance < closestDistance) {
        closestDistance = distance
        closestSection = section.id
      }
    }
  }
  
  if (closestSection) {
    activeSection.value = closestSection
  }
}

// 检查URL hash并自动打开对应的弹窗
onMounted(() => {
  const hash = window.location.hash
  if (hash === '#project1' || hash === '#project2' || hash === '#project3') {
    openModal(hash.replace('#', ''))
  }
  
  // 监听hash变化
  window.addEventListener('hashchange', () => {
    const newHash = window.location.hash
    if (newHash === '#project1' || newHash === '#project2' || newHash === '#project3' || newHash === '#project4') {
      openModal(newHash.replace('#', ''))
    }
  })
})

// 暴露方法给父组件
defineExpose({
  openModal
})
</script>

<style scoped>
.projects {
  background: var(--bg-dark);
}

.projects-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
  margin-top: 48px;
}

.project-item {
  background: var(--bg-card);
  border-radius: 16px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  padding: 24px 32px;
  transition: all 0.3s ease;
  scroll-margin-top: 100px;
  cursor: pointer;
}

.project-item:hover {
  border-color: var(--primary-color);
  box-shadow: 0 10px 40px rgba(99, 102, 241, 0.15);
  transform: translateY(-2px);
}

.project-header {
  display: flex;
  align-items: center;
  gap: 20px;
}

.project-number {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
  font-size: 1.3rem;
  font-weight: 600;
  flex-shrink: 0;
  transition: all 0.3s ease;
}

.project-item:hover .project-number {
  background: var(--bg-card);
  color: var(--text-primary);
  border-color: var(--primary-color);
}

.project-info {
  flex: 1;
}

.project-title {
  font-size: 1.3rem;
  font-weight: 600;
  margin-bottom: 4px;
}

.project-subtitle {
  color: var(--text-muted);
  font-size: 0.9rem;
}

.project-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 12px;
  padding-left: 70px;
}

.project-tag {
  display: inline-flex;
  align-items: center;
  padding: 4px 12px;
  background: rgba(99, 102, 241, 0.15);
  border: 1px solid rgba(99, 102, 241, 0.3);
  border-radius: 20px;
  font-size: 0.75rem;
  color: var(--primary-color);
  font-weight: 500;
  transition: all 0.3s ease;
}

.project-tag:hover {
  background: rgba(99, 102, 241, 0.25);
  border-color: rgba(99, 102, 241, 0.5);
}

.expand-icon {
  color: var(--text-muted);
  transition: all 0.3s ease;
}

.project-item:hover .expand-icon {
  color: var(--text-primary);
  transform: translateX(5px);
}

.expand-icon.rotated {
  transform: rotate(90deg);
}

.ai-interview-item:hover .expand-icon.rotated {
  transform: rotate(90deg);
}

/* 弹窗样式 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(5px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  padding: 20px;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.modal-content {
  background: var(--bg-card);
  border-radius: 24px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  width: 100%;
  max-width: 800px;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  padding: 40px;
  padding-top: 80px;
  animation: slideUp 0.3s ease;
  overscroll-behavior: contain;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.modal-close {
  position: fixed;
  top: calc(5vh + 20px);
  right: calc(50% - 400px + 20px);
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  z-index: 2001;
  backdrop-filter: blur(10px);
}

.modal-close:hover {
  background: rgba(255, 255, 255, 0.2);
  color: var(--text-primary);
}

.modal-header {
  display: flex;
  align-items: center;
  gap: 24px;
  margin-bottom: 32px;
  padding-bottom: 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.modal-number {
  width: 70px;
  height: 70px;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
  font-size: 1.8rem;
  font-weight: 600;
  flex-shrink: 0;
}

.modal-title {
  font-size: 2rem;
  font-weight: 600;
  margin-bottom: 8px;
}

.modal-subtitle {
  color: var(--text-muted);
  font-size: 1.1rem;
}

.modal-body {
  color: var(--text-secondary);
}

.modal-description {
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: 32px;
}

.modal-section {
  margin-bottom: 32px;
}

.modal-section h4 {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 16px;
}

.modal-section ul {
  list-style: none;
  padding: 0;
}

.modal-section li {
  padding: 12px 0;
  padding-left: 24px;
  position: relative;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.modal-section li::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 8px;
  height: 8px;
  background: var(--primary-color);
  border-radius: 50%;
}

.modal-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 32px;
  margin-bottom: 32px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.03);
  border-radius: 12px;
}

.meta-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.meta-label {
  font-size: 0.85rem;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.meta-value {
  font-size: 1rem;
  color: var(--text-primary);
  font-weight: 500;
}

.modal-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.tag {
  padding: 10px 20px;
  background: rgba(99, 102, 241, 0.1);
  border: 1px solid rgba(99, 102, 241, 0.3);
  border-radius: 20px;
  font-size: 0.9rem;
  color: var(--primary-color);
}

.modal-actions {
  display: flex;
  gap: 16px;
  margin-top: 32px;
  padding-top: 24px;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}

.modal-actions .btn-primary {
  background: linear-gradient(135deg, #4a4a4a 0%, #666666 100%);
  color: white;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.modal-actions .btn-primary:hover {
  background: linear-gradient(135deg, #333333 0%, #4a4a4a 100%);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.modal-actions .btn-secondary {
  background: rgba(0, 0, 0, 0.05);
  color: var(--text-primary);
  border: 1px solid rgba(0, 0, 0, 0.15);
}

.modal-actions .btn-secondary:hover {
  background: rgba(0, 0, 0, 0.1);
}

.btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
  border: none;
}

.btn-primary {
  background: var(--gradient-1);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.1);
  color: var(--text-primary);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-2px);
}

/* 滚动条样式 */
.modal-content::-webkit-scrollbar {
  width: 8px;
}

.modal-content::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.05);
  border-radius: 4px;
}

.modal-content::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.5);
  border-radius: 4px;
}

.modal-content::-webkit-scrollbar-thumb:hover {
  background: rgba(128, 128, 128, 0.7);
}

/* AI面试模拟器弹窗样式 */
.interview-modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.85);
  backdrop-filter: blur(8px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 3000;
  padding: 20px;
  animation: fadeIn 0.3s ease;
}

.interview-modal-content {
  background: var(--bg-card);
  border-radius: 24px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  width: 100%;
  max-width: 1000px;
  height: 90vh;
  max-height: 800px;
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
  animation: slideUp 0.3s ease;
}

.interview-modal-actions {
  position: absolute;
  top: 20px;
  right: 20px;
  display: flex;
  gap: 12px;
  z-index: 10;
}

.interview-modal-btn {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: var(--text-secondary);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.interview-modal-btn:hover {
  background: rgba(255, 255, 255, 0.15);
  color: var(--text-primary);
}

/* 全屏模式样式 */
.interview-modal-content.fullscreen {
  max-width: 100%;
  width: 100%;
  height: 100vh;
  max-height: 100vh;
  border-radius: 0;
}

.interview-modal-content.fullscreen .interview-modal-header {
  padding: 24px 40px 16px;
}

.interview-modal-content.fullscreen .interview-modal-body {
  padding: 16px 40px 40px;
}

.interview-modal-header {
  padding: 32px 40px 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  flex-shrink: 0;
}

.interview-modal-header h3 {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 8px;
}

.interview-modal-header p {
  font-size: 1rem;
  color: var(--text-muted);
}

.interview-modal-body {
  flex: 1;
  padding: 24px 40px 40px;
  overflow: hidden;
}

.ai-interview-iframe-wrapper {
  width: 100%;
  height: 100%;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
  background: var(--bg-card);
}

.ai-interview-iframe {
  width: 100%;
  height: 100%;
  border: none;
  display: block;
}

/* Chat SDK 弹窗样式 */
.chat-sdk-modal {
  max-width: 1200px;
  width: 95vw;
  height: 85vh;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
}

.chat-sdk-modal .interview-modal-header {
  flex-shrink: 0;
  padding-bottom: 16px;
  margin-bottom: 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.chat-sdk-container {
  flex: 1;
  min-height: 0;
  border-radius: 12px;
  overflow: hidden;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
}

.chat-sdk-container.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100vw;
  height: 100vh;
  z-index: 3000;
  border-radius: 0;
  border: none;
}

.interview-modal-actions.floating {
  position: fixed;
  top: 12px;
  right: 50%;
  transform: translateX(280px);
  z-index: 3001;
  background: transparent;
  border-radius: 8px;
  padding: 0;
  border: none;
}

.interview-modal-actions.floating .interview-modal-btn {
  width: 32px;
  height: 32px;
  border-radius: 8px;
  background: #ffffff;
  color: #666;
  border: 1px solid #e5e5e5;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.interview-modal-actions.floating .interview-modal-btn:hover {
  background: #f5f5f5;
  color: #333;
  border-color: #d9d9d9;
}

.interview-modal-actions.floating .interview-modal-btn svg {
  width: 16px;
  height: 16px;
}

/* 数据看板弹窗样式 */
.dashboard-modal {
  max-width: 1400px;
  width: 95vw;
  height: 90vh;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
}

.dashboard-modal .interview-modal-header {
  flex-shrink: 0;
  padding-bottom: 16px;
  margin-bottom: 16px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.dashboard-container {
  flex: 1;
  min-height: 0;
  border-radius: 12px;
  overflow: hidden;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
  transition: all 0.3s ease;
}

.dashboard-container.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100vw;
  height: 100vh;
  z-index: 3000;
  border-radius: 0;
  border: none;
}

.dashboard-iframe {
  width: 100%;
  height: 100%;
  border: none;
  display: block;
}

/* Chat SDK 容器样式 */
.chat-sdk-container {
  flex: 1;
  min-height: 0;
  border-radius: 12px;
  overflow: hidden;
  background: var(--bg-dark);
  border: 1px solid var(--border-color);
}

.chat-sdk-container.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100vw;
  height: 100vh;
  z-index: 3000;
  border-radius: 0;
  border: none;
}

/* 空白弹窗内容样式 */
.empty-modal-body {
  display: flex;
  align-items: center;
  justify-content: center;
}

.empty-content {
  text-align: center;
  color: var(--text-muted);
  padding: 40px;
}

.empty-content p {
  font-size: 1.1rem;
}

/* PRD文档样式 */
.prd-modal-content {
  max-width: 900px;
}

.prd-modal-body {
  padding: 0;
  overflow-y: auto;
}

.prd-content {
  padding: 32px 40px;
  color: var(--text-primary);
  line-height: 1.8;
}

.prd-content h1 {
  font-size: 2rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 24px;
  padding-bottom: 16px;
  border-bottom: 2px solid var(--primary-color);
}

.prd-content h2 {
  font-size: 1.5rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-top: 32px;
  margin-bottom: 16px;
  padding-bottom: 8px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.prd-content h3 {
  font-size: 1.2rem;
  font-weight: 600;
  color: var(--text-secondary);
  margin-top: 24px;
  margin-bottom: 12px;
}

.prd-content p {
  margin-bottom: 16px;
  color: var(--text-secondary);
}

.prd-content ul,
.prd-content ol {
  margin-bottom: 16px;
  padding-left: 24px;
}

.prd-content li {
  margin-bottom: 8px;
  color: var(--text-secondary);
}

.prd-content table {
  width: 100%;
  border-collapse: collapse;
  margin: 20px 0;
  background: var(--bg-card);
  border-radius: 8px;
  overflow: hidden;
}

.prd-content th,
.prd-content td {
  padding: 12px 16px;
  text-align: left;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.prd-content th {
  background: rgba(128, 128, 128, 0.15);
  font-weight: 600;
  color: var(--text-primary);
}

.prd-content tr:last-child td {
  border-bottom: none;
}

.prd-content strong {
  color: var(--text-primary);
  font-weight: 600;
}

.prd-architecture {
  background: var(--bg-card);
  border-radius: 12px;
  padding: 24px;
  margin: 20px 0;
  text-align: center;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.prd-architecture p {
  margin: 8px 0;
  color: var(--text-secondary);
  font-family: monospace;
  font-size: 0.95rem;
}

/* PRD导航栏样式 */
.prd-layout {
  display: flex;
  flex: 1;
  overflow: hidden;
  height: calc(100% - 120px);
}

.prd-nav {
  width: 240px;
  background: var(--bg-card);
  border-right: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
}

.prd-nav-header {
  padding: 16px 20px;
  font-weight: 600;
  color: var(--text-primary);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  gap: 8px;
}

.prd-nav-content {
  flex: 1;
  overflow-y: auto;
  padding: 12px 0;
}

.prd-nav-section {
  margin-bottom: 4px;
}

.prd-nav-title {
  padding: 10px 16px 10px 20px;
  cursor: pointer;
  color: var(--text-secondary);
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s ease;
  border-left: 3px solid transparent;
}

.prd-nav-title:hover {
  background: rgba(255, 255, 255, 0.05);
  color: var(--text-primary);
}

.prd-nav-title.active {
  background: rgba(128, 128, 128, 0.2);
  color: var(--text-primary);
  border-left-color: rgba(128, 128, 128, 0.5);
}

.prd-nav-arrow {
  display: flex;
  align-items: center;
  transition: transform 0.2s ease;
}

.prd-nav-title.expanded .prd-nav-arrow {
  transform: rotate(90deg);
}

.prd-nav-children {
  padding-left: 20px;
}

.prd-nav-child {
  padding: 8px 16px 8px 32px;
  cursor: pointer;
  color: var(--text-muted);
  font-size: 0.85rem;
  transition: all 0.2s ease;
  border-left: 2px solid transparent;
}

.prd-nav-child:hover {
  color: var(--text-secondary);
  background: rgba(255, 255, 255, 0.03);
}

.prd-nav-child.active {
  color: var(--text-primary);
  background: rgba(128, 128, 128, 0.15);
  border-left-color: rgba(128, 128, 128, 0.5);
}

.prd-modal-body-with-nav {
  flex: 1;
  padding: 0;
  overflow-y: auto;
}

/* 左侧导航栏滚动条样式 */
.prd-nav-content::-webkit-scrollbar {
  width: 4px;
}

.prd-nav-content::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.05);
}

.prd-nav-content::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.5);
  border-radius: 2px;
}

.prd-nav-content::-webkit-scrollbar-thumb:hover {
  background: rgba(128, 128, 128, 0.7);
}

/* 内容区滚动条样式 */
.prd-modal-body-with-nav::-webkit-scrollbar {
  width: 6px;
}

.prd-modal-body-with-nav::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.05);
}

.prd-modal-body-with-nav::-webkit-scrollbar-thumb {
  background: rgba(128, 128, 128, 0.5);
  border-radius: 3px;
}

.prd-modal-body-with-nav::-webkit-scrollbar-thumb:hover {
  background: rgba(128, 128, 128, 0.7);
}

/* 响应式：小屏幕隐藏导航 */
@media (max-width: 768px) {
  .prd-nav {
    display: none;
  }
}

/* 按钮样式调整 */
.btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 24px;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 500;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
  border: none;
}

@media (max-width: 768px) {
  .projects {
    max-width: 100vw;
    overflow-x: hidden;
  }
  
  .project-item {
    padding: 16px 20px;
  }
  
  .project-number {
    width: 36px;
    height: 36px;
    font-size: 1rem;
  }
  
  .project-title {
    font-size: 1rem;
  }
  
  .project-subtitle {
    font-size: 0.85rem;
  }

  .project-tags {
    padding-left: 56px;
    gap: 6px;
    margin-top: 10px;
  }

  .project-tag {
    padding: 3px 10px;
    font-size: 0.7rem;
  }

  .modal-overlay {
    padding: 0;
    align-items: flex-end;
  }
  
  .modal-content {
    width: 100%;
    max-width: 100%;
    height: 90vh;
    max-height: 90vh;
    margin: 0;
    border-radius: 20px 20px 0 0;
    padding: 60px 20px 20px;
  }
  
  .modal-close {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 36px;
    height: 36px;
  }
  
  .modal-header {
    flex-direction: column;
    text-align: center;
    gap: 12px;
    margin-bottom: 20px;
  }
  
  .modal-number {
    width: 50px;
    height: 50px;
    font-size: 1.3rem;
  }
  
  .modal-title {
    font-size: 1.3rem;
  }
  
  .modal-subtitle {
    font-size: 0.9rem;
  }
  
  .modal-meta {
    flex-direction: column;
    gap: 12px;
  }
  
  .modal-section h3 {
    font-size: 1rem;
  }
  
  .modal-section p,
  .modal-section li {
    font-size: 0.9rem;
  }
  
  .tech-tag {
    font-size: 0.8rem;
    padding: 4px 10px;
  }
  
  .ai-interview-content {
    margin-top: 16px;
    padding-top: 16px;
  }
  
  .ai-interview-subtitle {
    font-size: 0.9rem;
    margin-bottom: 12px;
  }
  
  .ai-interview-iframe-wrapper {
    border-radius: 12px;
  }
  
  .interview-modal-overlay {
    padding: 0;
    align-items: flex-end;
  }
  
  .interview-modal-content {
    width: 100%;
    max-width: 100%;
    height: 95vh;
    max-height: 95vh;
    border-radius: 20px 20px 0 0;
  }
  
  .interview-modal-actions {
    top: 15px;
    right: 15px;
    gap: 8px;
  }
  
  .interview-modal-btn {
    width: 40px;
    height: 40px;
  }
  
  .interview-modal-content.fullscreen .interview-modal-header,
  .interview-modal-content.fullscreen .interview-modal-body {
    padding-left: 20px;
    padding-right: 20px;
  }
  
  .interview-modal-header {
    padding: 24px 20px 16px;
  }
  
  .interview-modal-header h3 {
    font-size: 1.3rem;
  }
  
  .interview-modal-header p {
    font-size: 0.9rem;
  }
  
  .interview-modal-body {
    padding: 16px 20px 20px;
  }
}
</style>
