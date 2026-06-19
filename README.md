# 📰 AI News Card

> 将 AI 新闻转化为精美的社交媒体卡片图片（1080×1440，适配抖音 / 小红书竖屏）

输入一条新闻的概述和锐评，自动生成多页卡片图片。长文本智能拆分，两套风格主题，一键出图。

支持 **JSON 文件 / 命令行参数 / stdin 管道** 三种输入方式，可封装为 AI Agent Skill 调用。

## ✨ 特性

- **两套平台风格** — 抖音（清新蓝·科技睿智）& 小红书（小清新·可爱）
- **长文本自动分页** — 每页 ≤110 字，56px 大字号 + 大留白
- **双模板类型** — 新闻概述（可多页）+ 点评（单页）
- **多种输入方式** — JSON 文件、命令行参数、stdin 管道
- **高清输出** — 1080×1440 px，2x 设备像素比
- **纯前端渲染** — HTML/CSS 模板 + Playwright 截图

## 📸 效果展示

### 抖音风（清新蓝）

| 概述页 | 锐评 |
|:---:|:---:|
| ![抖音-概述](examples/douyin-summary.png) | ![抖音-锐评](examples/douyin-critique.png) |

### 小红书风（小清新）

| 概述页 | 小编评论 |
|:---:|:---:|
| ![小红书-概述](examples/xhs-summary.png) | ![小红书-评论](examples/xhs-critique.png) |

## 🚀 快速开始

### 安装

```bash
git clone https://github.com/HarmmerRay/ai-news-card.git
cd ai-news-card
npm install
npx playwright install chromium
```

### 生成卡片

**方式一：JSON 文件输入**

```json
// news.json
{
  "summary": "新闻概述文本，支持长文本自动分页...",
  "critique": "一句话锐评。"
}
```

```bash
node scripts/generate.js --input news.json --output output/
```

**方式二：命令行参数**

```bash
node scripts/generate.js \
  --summary "新闻概述文本..." \
  --critique "一句话锐评。" \
  --output output/
```

**方式三：stdin 管道**

```bash
echo '{"summary":"...","critique":"..."}' | node scripts/generate.js --output output/
```

**只生成一种风格：**

```bash
node scripts/generate.js --input news.json --output output/ --styles douyin
node scripts/generate.js --input news.json --output output/ --styles xhs
```

### 输出结构

```
output/
├── douyin-summary-1.png     # 抖音风-概述第1页
├── douyin-summary-2.png     # 抖音风-概述第2页（自动分页）
├── douyin-critique.png      # 抖音风-锐评
├── xhs-summary-1.png        # 小红书风-概述第1页
├── xhs-summary-2.png        # 小红书风-概述第2页
└── xhs-critique.png         # 小红书风-小编评论
```

## 🤖 安装为 AI Agent Skill

本项目可封装为 Skill，安装到支持 Skill 的 AI Agent（如 [Hermes Agent](https://github.com/nousresearch/hermes-agent)）上，让 AI 直接调用生成卡片。

### 安装 Skill

```bash
cd ai-news-card

# 一键安装到 ~/.hermes/skills/
./skill/install.sh

# 或指定目录
./skill/install.sh /path/to/your/agent/skills/
```

安装后重启 AI Agent，即可通过自然语言调用：

```
用户：帮我生成一张关于 GPT-5 发布的新闻卡片
AI Agent：[调用 ai-news-card skill，自动生成图片]
```

详见 [skill/SKILL.md](skill/SKILL.md)。

## 📖 命令行参数

| 参数 | 简写 | 说明 |
|------|------|------|
| `--input <file>` | `-i` | JSON 文件路径 |
| `--summary <text>` | `-s` | 新闻概述文本 |
| `--critique <text>` | `-c` | 点评/锐评文本 |
| `--output <dir>` | `-o` | 输出目录（默认 `./output`） |
| `--styles <list>` | | 风格，逗号分隔（`douyin,xhs`），默认两套都生成 |
| `--help` | `-h` | 显示帮助 |

## 🎨 自定义风格

模板样式在 `templates/base.html` 中定义，直接修改 CSS：

| 元素 | 抖音风 | 小红书风 |
|------|--------|----------|
| 背景渐变 | `#dbeafe → #c7d2fe → #e0e7ff` | `#fff0f3 → #fce7f3 → #fdf2f8` |
| 文字颜色 | `#1e3a5f` | `#4a4a4a` |
| Badge 标签 | 锐评 | 小编评论 |
| 强调色 | `#2563eb` | `#ec4899` |

### 调整每页字数

```javascript
// scripts/generate.js
const CHARS_PER_PAGE = 110;  // 改大 → 更多字/页，改小 → 更大留白
```

## 📁 项目结构

```
ai-news-card/
├── templates/
│   └── base.html           # CSS 模板（两套风格定义）
├── scripts/
│   └── generate.js         # 生成脚本（支持外部输入）
├── skill/
│   ├── SKILL.md            # AI Agent Skill 定义
│   └── install.sh          # Skill 安装脚本
├── examples/               # 效果展示图
├── package.json
├── .gitignore
└── README.md
```

## 🔧 技术实现

1. **文本分页** — 按标点符号（。！？；）智能断句，确保每页文字不超过阈值
2. **HTML 渲染** — 纯 CSS 渐变背景 + Flexbox 居中布局
3. **截图输出** — Playwright 驱动 Chromium，deviceScaleFactor=2 保证清晰度
4. **字体** — Noto Sans SC（思源黑体），通过网络字体加载

## 📝 License

MIT
