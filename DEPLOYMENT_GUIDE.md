# 📦 知识库应用 - 部署指南

## 🚀 快速部署

此压缩包包含已构建好的静态文件，可以直接部署到任何Web服务器。

---

## 📁 文件结构

```
knowledge-base-deploy/
├── dist/                    # 构建产物（静态文件）
│   ├── index.html          # 入口HTML文件
│   ├── assets/             # CSS、JS、图片等资源
│   └── ...
├── package.json            # 项目信息
└── README.md              # 项目说明
```

---

## 🌐 部署方式

### 方式1：直接使用Web服务器（推荐）

#### Nginx 配置

1. 解压文件到服务器：
```bash
tar -xzf knowledge-base-deploy.tar.gz
cd knowledge-base-deploy
```

2. 配置 Nginx：
```nginx
server {
    listen 80;
    server_name your-domain.com;  # 替换为你的域名

    root /path/to/knowledge-base-deploy/dist;  # 替换为实际路径
    index index.html;

    # SPA 路由配置
    location / {
        try_files $uri $uri/ /index.html;
    }

    # 缓存静态资源
    location /assets/ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Gzip 压缩
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
```

3. 重启 Nginx：
```bash
sudo nginx -t
sudo systemctl reload nginx
```

#### Apache 配置

1. 解压文件：
```bash
tar -xzf knowledge-base-deploy.tar.gz
```

2. 在 `dist` 目录创建 `.htaccess` 文件：
```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.html$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.html [L]
</IfModule>

# 启用 Gzip 压缩
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>

# 设置缓存
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>
```

3. 配置虚拟主机指向 `dist` 目录

---

### 方式2：使用 Docker

1. 创建 `Dockerfile`（已包含在压缩包中）：
```dockerfile
FROM nginx:alpine
COPY dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

2. 构建并运行：
```bash
docker build -t knowledge-base .
docker run -d -p 80:80 knowledge-base
```

---

### 方式3：云存储 + CDN（对象存储）

#### 阿里云 OSS

1. 上传 `dist` 目录所有文件到 OSS Bucket
2. 设置 Bucket 为**公共读**
3. 开启**静态网站托管**
4. 设置默认首页为 `index.html`
5. 设置 404 页面为 `index.html`（支持前端路由）

#### 腾讯云 COS

1. 上传文件到 COS Bucket
2. 开启**静态网站**功能
3. 设置索引文档为 `index.html`
4. 设置错误文档为 `index.html`

---

### 方式4：免费托管平台

#### Vercel（推荐）

1. 登录 [vercel.com](https://vercel.com)
2. 点击 "New Project"
3. 上传 `dist` 文件夹 或 导入 Git 仓库
4. 自动部署，获得免费的 HTTPS 域名

#### Netlify

1. 登录 [netlify.com](https://netlify.com)
2. 拖拽 `dist` 文件夹到页面
3. 立即获得公开访问链接

#### GitHub Pages

1. 创建 GitHub 仓库
2. 上传 `dist` 目录内容到仓库根目录（或 `docs` 文件夹）
3. 在仓库设置中启用 GitHub Pages
4. 访问 `https://username.github.io/repo-name`

---

## 🔧 本地测试

如果你想在部署前本地测试构建产物：

```bash
# 使用 Python 简易服务器
cd dist
python3 -m http.server 8080

# 或使用 Node.js serve
npx serve dist -l 8080

# 或使用 PHP 内置服务器
cd dist
php -S localhost:8080
```

然后访问：`http://localhost:8080`

---

## 📝 功能特性

✅ **富文本编辑**：轻量级的所见即所得编辑器
- 标题（H1-H3）
- 文字格式化（加粗、斜体、下划线、删除线、代码、高亮）
- 列表（无序、有序、引用）
- 插入（链接、图片、表格、代码块）
- 提示框（信息、警告、成功、错误）

✅ **实时预览**：左侧编辑，右侧即时预览

✅ **自动保存**：800ms 防抖自动保存

✅ **搜索功能**：Ctrl+F 快速搜索文档内容

✅ **目录导航**：自动生成标题目录

✅ **多格式导出**：支持导出为 Markdown、HTML、PDF

✅ **本地存储**：所有数据保存在浏览器 localStorage，无需后端

✅ **分类管理**：支持多分类和标签

✅ **父子关系**：支持笔记层级结构

---

## 🎯 使用说明

1. **创建知识**：点击右下角 "+" 按钮
2. **编辑内容**：使用工具栏进行格式化
3. **实时预览**：开启右侧预览查看效果
4. **搜索内容**：按 Ctrl+F 搜索
5. **导出文档**：点击导出按钮选择格式

---

## 🔒 数据说明

- 所有数据存储在浏览器的 `localStorage` 中
- 数据仅保存在本地，不会上传到服务器
- 建议定期使用导出功能备份数据
- 清除浏览器数据会导致知识库数据丢失

---

## ⚙️ 配置选项

如果需要自定义配置（如修改端口、添加后端API等），可以：

1. 解压完整源代码包
2. 修改 `vite.config.ts` 配置文件
3. 运行 `npm run build` 重新构建
4. 使用新的 `dist` 目录部署

---

## 🐛 常见问题

### Q: 部署后页面刷新 404？

**A**: 需要配置服务器将所有请求重定向到 `index.html`。参考上面的 Nginx/Apache 配置。

### Q: 静态资源加载失败？

**A**: 检查：
1. 确保 `dist` 目录结构完整
2. 检查服务器路径配置
3. 查看浏览器控制台网络请求

### Q: 数据丢失了？

**A**:
1. 检查是否清除了浏览器数据
2. 使用不同浏览器/设备访问时数据不会同步
3. 建议定期导出备份

### Q: 如何迁移数据？

**A**:
1. 在旧浏览器打开开发者工具 (F12)
2. 进入 Application → Local Storage
3. 复制 `knowledge-items` 和 `categories` 数据
4. 在新浏览器相同位置粘贴

---

## 📞 技术支持

- 技术栈：React 18 + TypeScript + Vite
- 样式：Tailwind CSS
- 图标：Lucide React
- 状态管理：Zustand
- Markdown：Marked + Turndown

---

## 📄 许可证

本项目为开源项目，可自由使用和修改。

---

## 🎉 开始使用

1. 选择上述任一部署方式
2. 访问你的域名或 IP
3. 开始创建你的知识库！

**预祝部署顺利！** 🚀
