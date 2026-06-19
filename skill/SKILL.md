---
name: ai-news-card
description: "Use when generating social media card images (Douyin/Xiaohongshu style) from AI news or any text content. Converts news summary + critique into beautifully designed 1080×1440 card images with auto-pagination."
version: 1.0.0
author: HarmmerRay
license: MIT
metadata:
  hermes:
    tags: [image, card, news, social-media, douyin, xiaohongshu, generator]
    related_skills: []
---

# AI News Card Generator

## Overview

Generate beautifully designed social media card images from news text. Two built-in styles:
- **抖音 (Douyin)** — Fresh blue gradient, tech & sharp aesthetic
- **小红书 (Xiaohongshu)** — Soft pink pastel, cute & friendly aesthetic

Each news item produces two types of cards:
1. **Summary cards** (multi-page) — Long text auto-split into pages, ≤110 chars/page, large 56px font
2. **Critique card** (single page) — Sharp one-liner commentary with badge label

Output: 1080×1440 px PNG images at 2x device pixel ratio.

## When to Use

- User wants to create social media card images from text content
- User has AI news summary + critique and wants visual cards
- User wants to generate Douyin or Xiaohongshu style image cards
- User wants to convert long text into paginated, readable card images

**Don't use for:** Video generation, complex graphic design (logos, posters), or non-card image formats.

## Prerequisites

The `ai-news-card` package must be installed:

```bash
# Option A: npx (no install needed, runs on demand)
npx ai-news-card --summary "..." --critique "..." --output ./cards

# Option B: Global install
npm install -g ai-news-card
ai-news-card --input news.json --output ./cards

# Option C: Clone the repo
git clone https://github.com/HarmmerRay/ai-news-card.git
cd ai-news-card
npm install
npx playwright install chromium
```

Playwright + Chromium is required for screenshot rendering.

## Quick Start

### 1. Prepare news data as JSON

```json
{
  "summary": "Your news summary text here. Long text will be auto-split into multiple pages at natural sentence boundaries...",
  "critique": "A sharp one-liner commentary."
}
```

### 2. Generate cards

```bash
# From JSON file
node scripts/generate.js --input news.json --output ./output/

# From command line arguments
node scripts/generate.js \
  --summary "新闻概述文本..." \
  --critique "锐评一句话" \
  --output ./output/

# From stdin pipe
echo '{"summary":"...","critique":"..."}' | node scripts/generate.js --output ./output/

# Generate only one style
node scripts/generate.js --input news.json --output ./output/ --styles douyin
```

### 3. Output structure

```
output/
├── douyin-summary-1.png     # Douyin summary page 1
├── douyin-summary-2.png     # Douyin summary page 2 (auto-paginated)
├── douyin-critique.png      # Douyin critique (锐评)
├── xhs-summary-1.png        # Xiaohongshu summary page 1
├── xhs-summary-2.png        # Xiaohongshu summary page 2
└── xhs-critique.png         # Xiaohongshu critique (小编评论)
```

## Workflow for AI Agents

When a user asks to generate card images from news content:

1. **Prepare the data** — Write the news summary and critique to a JSON file:
   ```bash
   cat > /tmp/news.json << 'EOF'
   {
     "summary": "...",
     "critique": "..."
   }
   EOF
   ```

2. **Run the generator**:
   ```bash
   cd /path/to/ai-news-card
   node scripts/generate.js --input /tmp/news.json --output ./output/
   ```

3. **Return the image paths** to the user.

## Customization

### Change chars per page

Edit `scripts/generate.js`:
```javascript
const CHARS_PER_PAGE = 110;  // Decrease = larger text + more whitespace
```

### Change colors / styles

Edit `templates/base.html` — all CSS is in one `<style>` block:

| Element | Douyin | Xiaohongshu |
|---------|--------|-------------|
| Background gradient | `#dbeafe → #c7d2fe → #e0e7ff` | `#fff0f3 → #fce7f3 → #fdf2f8` |
| Text color | `#1e3a5f` | `#4a4a4a` |
| Badge label | 锐评 | 小编评论 |
| Accent color | `#2563eb` | `#ec4899` |
| Lightning icon | `#eab308` (deep yellow) | `#f59e0b` (warm yellow) |

## Common Pitfalls

1. **Playwright not installed** — Run `npx playwright install chromium` after npm install.

2. **Font not loading** — The template uses Google Fonts (Noto Sans SC). If offline, text still renders in system fallback font. For consistent rendering, ensure network access during generation.

3. **Output directory** — Must be writable. The script creates it if it doesn't exist.

4. **Summary too short** — If summary is ≤110 chars, only 1 page is generated (this is correct behavior).

## Verification Checklist

- [ ] `npx playwright install chromium` has been run
- [ ] JSON input has `summary` and `critique` fields
- [ ] Output directory is specified or defaults to `./output/`
- [ ] Generated images are 1080×1440 px
