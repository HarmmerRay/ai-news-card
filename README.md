# 📰 AI News Card

> 将 AI 新闻转化为精美的社交媒体卡片图片（1080×1440，适配抖音 / 小红书竖屏）

输入一条新闻的概述和锐评，自动生成多页卡片图片。长文本智能拆分，两套风格主题，一键出图。

## ✨ 特性

- **两套平台风格** — 抖音（清新蓝·科技睿智）& 小红书（小清新·可爱）
- **长文本自动分页** — 每页 ≤110 字，大字号 + 大留白，视觉冲击力强
- **双模板类型** — 新闻概述（可多页）+ 锐评（单页）
- **高清输出** — 1080×1440 px，2x 设备像素比，适配主流社交平台
- **纯前端渲染** — HTML/CSS 模板 + Playwright 截图，无需设计软件

## 📸 效果展示

### 抖音风（清新蓝）

| 概述页 | 锐评页 |
|:---:|:---:|
| ![抖音-概述](examples/douyin-summary.png) | ![抖音-锐评](examples/douyin-critique.png) |

### 小红书风（小清新）

| 概述页 | 锐评页 |
|:---:|:---:|
| ![小红书-概述](examples/xhs-summary.png) | ![小红书-锐评](examples/xhs-critique.png) |

## 🚀 快速开始

### 环境要求

- [Node.js](https://nodejs.org/) 18+
- [Playwright](https://playwright.dev/) + Chromium

```bash
# 安装 Playwright
npm install playwright
# 安装浏览器
npx playwright install chromium
```

### 生成卡片

```bash
git clone https://github.com/YOUR_USERNAME/ai-news-card.git
cd ai-news-card

# 使用内置测试数据生成
node scripts/generate.js output/
```

生成的图片会输出到 `output/` 目录：

```
output/
├── douyin-summary-1.png    # 抖音风-概述第1页
├── douyin-summary-2.png    # 抖音风-概述第2页（自动分页）
├── douyin-critique.png     # 抖音风-锐评
├── xhs-summary-1.png       # 小红书风-概述第1页
├── xhs-summary-2.png       # 小红书风-概述第2页
└── xhs-critique.png        # 小红书风-锐评
```

## 📖 自定义内容

编辑 `scripts/generate.js` 底部的测试数据，替换为你自己的新闻：

```javascript
const testNews = {
  title: '你的新闻标题',
  summary: `你的新闻概述（支持长文本，会自动分页）...`,
  critique: '你的锐评（一句话，精炼有力）',
};
```

## 🎨 自定义风格

模板样式在 `templates/base.html` 中定义，可以直接修改 CSS：

| 元素 | 抖音风 | 小红书风 |
|------|--------|----------|
| 背景渐变 | `#f0f7ff → #e0effe → #e8f0fe` | `#fffbf5 → #fff5f8` |
| 文字颜色 | `#1e3a5f`（深海军蓝） | `#4a4a4a`（深灰） |
| 强调色 | `#2563eb`（蓝色） | `#ec4899`（粉色） |
| 锐评闪电 | `#eab308`（深黄） | `#f59e0b`（暖黄） |

### 调整每页字数

```javascript
// scripts/generate.js
const CHARS_PER_PAGE = 110;  // 改大 → 每页更多字，改小 → 更大留白
```

## 📁 项目结构

```
ai-news-card/
├── templates/
│   └── base.html          # CSS 模板（两套风格定义）
├── scripts/
│   └── generate.js        # 生成脚本（文本拆分 + 截图）
├── examples/              # 效果展示图
│   ├── douyin-summary.png
│   ├── douyin-critique.png
│   ├── xhs-summary.png
│   └── xhs-critique.png
├── .gitignore
└── README.md
```

## 🔧 技术实现

1. **文本分页** — 按标点符号（。！？；）智能断句，确保每页文字不超过阈值
2. **HTML 渲染** — 纯 CSS 渐变背景 + Flexbox 居中布局，无外部图片依赖
3. **截图输出** — Playwright 驱动 Chromium，deviceScaleFactor=2 保证清晰度
4. **字体** — Noto Sans SC（思源黑体），通过网络字体加载

## 📝 License

MIT
