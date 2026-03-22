# 🚀 知识库应用 - 所有部署方法

## 📊 部署方式对比表

| 方式 | 难度 | 费用 | 域名 | 速度 | 推荐指数 |
|------|------|------|------|------|----------|
| **Vercel** | ⭐ | 免费 | ✅ 自动提供 | ⚡⚡⚡ | ⭐⭐⭐⭐⭐ |
| **Netlify** | ⭐ | 免费 | ✅ 自动提供 | ⚡⚡⚡ | ⭐⭐⭐⭐⭐ |
| **Cloudflare Pages** | ⭐ | 免费 | ✅ 自动提供 | ⚡⚡⚡ | ⭐⭐⭐⭐ |
| **GitHub Pages** | ⭐⭐ | 免费 | ✅ 自动提供 | ⚡⚡ | ⭐⭐⭐⭐ |
| **Docker** | ⭐⭐⭐ | 需服务器 | ❌ 需自己配置 | ⚡⚡⚡ | ⭐⭐⭐ |
| **Nginx/Apache** | ⭐⭐⭐⭐ | 需服务器 | ❌ 需自己配置 | ⚡⚡⚡ | ⭐⭐⭐ |
| **云存储(OSS/S3)** | ⭐⭐ | 按量付费 | ✅ 可配置 | ⚡⚡⚡ | ⭐⭐⭐⭐ |

---

## 🏆 方法 1：Vercel（最推荐）

### ✨ 优点
- 完全免费
- 自动提供 HTTPS 域名
- 全球 CDN 加速
- 自动部署（连接 Git 后）
- 零配置

### 📝 步骤

#### 方式 A：Web 界面（最简单）
1. 访问 [vercel.com](https://vercel.com)
2. 注册/登录（支持 GitHub/GitLab/Bitbucket）
3. 点击 "Add New" → "Project"
4. 上传 `dist` 文件夹
5. ✅ 完成！获得域名如：`https://your-app.vercel.app`

#### 方式 B：命令行
```bash
# 安装 Vercel CLI
npm install -g vercel

# 登录
vercel login

# 部署
cd knowledge-base-enhanced
vercel --prod
```

### 🔧 自定义配置
已包含 `vercel.json` 配置文件，支持：
- SPA 路由
- 静态资源缓存
- 自动 HTTPS

---

## 🟢 方法 2：Netlify（同样推荐）

### ✨ 优点
- 完全免费
- 拖拽上传超简单
- 自动 HTTPS
- 表单处理功能
- 无限带宽

### 📝 步骤

#### 方式 A：拖拽部署（最快）
1. 访问 [netlify.com](https://netlify.com)
2. 注册/登录
3. 直接拖拽 `dist` 文件夹到页面
4. ✅ 立即获得域名：`https://random-name.netlify.app`

#### 方式 B：命令行
```bash
# 安装 Netlify CLI
npm install -g netlify-cli

# 登录
netlify login

# 部署
cd knowledge-base-enhanced
netlify deploy --prod --dir=dist
```

### 🔧 配置文件
已包含 `netlify.toml` 配置：
- 自动构建
- 路由重定向
- 安全头设置

---

## ☁️ 方法 3：Cloudflare Pages

### ✨ 优点
- 免费且无限制
- Cloudflare 全球 CDN
- 最快的速度
- 防 DDoS 保护

### 📝 步骤
1. 访问 [pages.cloudflare.com](https://pages.cloudflare.com)
2. 注册/登录
3. "Create a project"
4. 上传 `dist` 文件夹
5. ✅ 获得域名：`https://your-app.pages.dev`

### 配置
已包含 `_redirects` 文件用于 SPA 路由

---

## 🐙 方法 4：GitHub Pages

### ✨ 优点
- 完全免费
- 与代码仓库集成
- 支持自定义域名
- 简单可靠

### 📝 步骤

#### 方式 A：直接上传
```bash
cd knowledge-base-enhanced

# 初始化 Git
git init
git add dist
git commit -m "Deploy to GitHub Pages"

# 创建 gh-pages 分支
git branch -M gh-pages

# 推送到 GitHub
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin gh-pages
```

#### 方式 B：GitHub Actions 自动部署
创建 `.github/workflows/deploy.yml`:
```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

### 启用 Pages
1. 仓库 Settings → Pages
2. Source: gh-pages 分支
3. ✅ 访问：`https://YOUR_USERNAME.github.io/YOUR_REPO`

---

## 🐳 方法 5：Docker 部署

### ✨ 优点
- 环境一致性
- 可在任何支持 Docker 的地方运行
- 易于扩展

### 📝 步骤

已包含 `Dockerfile` 和 `nginx.conf`：

```bash
cd knowledge-base-enhanced

# 构建镜像
docker build -t knowledge-base .

# 运行容器
docker run -d -p 80:80 --name kb knowledge-base

# 访问
http://localhost
```

### Docker Compose
创建 `docker-compose.yml`:
```yaml
version: '3'
services:
  knowledge-base:
    build: .
    ports:
      - "80:80"
    restart: unless-stopped
```

运行：
```bash
docker-compose up -d
```

---

## 🖥️ 方法 6：传统服务器部署

### Nginx 配置

1. **安装 Nginx**
```bash
sudo apt update
sudo apt install nginx
```

2. **复制文件**
```bash
sudo cp -r dist /var/www/knowledge-base
```

3. **配置 Nginx**（使用提供的 `nginx.conf`）
```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/knowledge-base;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

4. **重启服务**
```bash
sudo nginx -t
sudo systemctl reload nginx
```

### Apache 配置

1. **安装 Apache**
```bash
sudo apt update
sudo apt install apache2
```

2. **复制文件**
```bash
sudo cp -r dist /var/www/html/knowledge-base
sudo cp .htaccess /var/www/html/knowledge-base/
```

3. **启用 mod_rewrite**
```bash
sudo a2enmod rewrite
sudo systemctl restart apache2
```

---

## ☁️ 方法 7：云存储部署

### 阿里云 OSS

1. 创建 Bucket，设置为**公共读**
2. 上传 `dist` 目录所有文件
3. 开启**静态网站托管**
4. 设置：
   - 默认首页：`index.html`
   - 404 页面：`index.html`（支持前端路由）
5. 访问 Bucket 域名

### 腾讯云 COS

1. 创建 Bucket，设置访问权限为**公有读私有写**
2. 上传 `dist` 文件
3. 开启**静态网站**
4. 设置索引文档和错误文档为 `index.html`

### AWS S3 + CloudFront

1. 创建 S3 Bucket
2. 上传文件并设置公共读权限
3. 开启静态网站托管
4. 创建 CloudFront 分配以获得 CDN 加速

---

## 🎯 快速决策指南

### 你应该选择：

**🏆 Vercel/Netlify**（如果你想要）
- ✅ 最简单的部署
- ✅ 免费永久使用
- ✅ 自动 HTTPS 域名
- ✅ 全球 CDN 加速

**🐳 Docker**（如果你）
- ✅ 有自己的服务器
- ✅ 想要完全控制
- ✅ 需要内网部署

**☁️ 云存储**（如果你）
- ✅ 已有云服务账号
- ✅ 需要与其他云服务集成
- ✅ 对成本敏感（按量付费）

**🐙 GitHub Pages**（如果你）
- ✅ 代码已在 GitHub
- ✅ 想要版本控制
- ✅ 需要开源展示

---

## 🛠️ 使用部署脚本

我们提供了自动化部署脚本：

```bash
chmod +x deploy.sh
./deploy.sh
```

脚本支持：
1. 自动构建项目
2. 选择部署方式
3. 创建部署包
4. 显示部署指南

---

## 📦 手动部署包

创建部署包：
```bash
# 构建项目
npm run build

# 创建压缩包
zip -r deploy-$(date +%Y%m%d).zip \
  dist \
  Dockerfile \
  nginx.conf \
  .htaccess \
  vercel.json \
  netlify.toml \
  _redirects \
  DEPLOYMENT_GUIDE.md
```

---

## 🔒 安全建议

1. **启用 HTTPS**（所有推荐平台自动提供）
2. **设置安全头**（已在配置文件中包含）
3. **定期备份数据**（使用导出功能）
4. **限制 API 访问**（如果添加了后端）

---

## 📞 需要帮助？

- Vercel 文档: https://vercel.com/docs
- Netlify 文档: https://docs.netlify.com
- Docker 文档: https://docs.docker.com
- GitHub Pages: https://pages.github.com

---

## 🎉 开始部署！

选择最适合你的方式，几分钟就能让应用上线！

**推荐新手**：Vercel 或 Netlify（拖拽上传即可）

**推荐有服务器**：Docker 或 Nginx

**推荐开源项目**：GitHub Pages
