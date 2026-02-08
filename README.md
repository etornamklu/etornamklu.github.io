# Minimal Jekyll Blog

A clean, minimal blog using Space Mono font with automatic GitHub Pages deployment.

## Setup

1. Create a new repository on GitHub
2. Push these files to your repo:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/USERNAME/REPO.git
   git push -u origin main
   ```

3. Enable GitHub Pages:
   - Go to your repo → Settings → Pages
   - Source: "GitHub Actions"

4. Your site will be live at `https://USERNAME.github.io/REPO/`

## Writing Posts

Create markdown files in `_posts/` with this format:

```
_posts/YYYY-MM-DD-title.md
```

Example:
```markdown
---
layout: post
title: "My Post Title"
date: 2026-02-08
---

Your content here in markdown...
```

Push to GitHub and it auto-builds!

## Customize

- Edit `_config.yml` to change title/description
- Edit `assets/css/style.css` for styling
- Add posts to `_posts/` directory

## Local Development

```bash
bundle install
bundle exec jekyll serve
```

Visit `http://localhost:4000`
