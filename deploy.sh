#!/bin/bash

# 知识库应用部署脚本
# 支持多种部署方式

set -e

echo "🚀 知识库应用部署工具"
echo "======================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. 构建项目
build_project() {
    echo -e "${BLUE}📦 正在构建项目...${NC}"
    npm run build
    echo -e "${GREEN}✅ 构建完成！${NC}"
    echo ""
}

# 2. Vercel 部署
deploy_vercel() {
    echo -e "${BLUE}🔵 Vercel 部署${NC}"
    echo "1. 安装 Vercel CLI: npm install -g vercel"
    echo "2. 运行命令: vercel --prod"
    echo ""
    echo "或者访问 https://vercel.com 手动上传 dist 文件夹"
    echo ""
}

# 3. Netlify 部署
deploy_netlify() {
    echo -e "${BLUE}🟢 Netlify 部署${NC}"
    echo "1. 安装 Netlify CLI: npm install -g netlify-cli"
    echo "2. 运行命令: netlify deploy --prod --dir=dist"
    echo ""
    echo "或者访问 https://netlify.com 拖拽 dist 文件夹"
    echo ""
}

# 4. Docker 部署
deploy_docker() {
    echo -e "${BLUE}🐳 Docker 部署${NC}"
    echo "构建并运行 Docker 容器..."
    docker build -t knowledge-base .
    docker run -d -p 80:80 --name kb knowledge-base
    echo -e "${GREEN}✅ Docker 容器已启动！${NC}"
    echo "访问: http://localhost"
    echo ""
}

# 5. GitHub Pages 部署
deploy_github_pages() {
    echo -e "${BLUE}🐙 GitHub Pages 部署${NC}"
    echo "1. 在 GitHub 创建仓库"
    echo "2. 将 dist 目录推送到 gh-pages 分支："
    echo ""
    echo "   git init"
    echo "   git add dist"
    echo "   git commit -m 'Deploy to GitHub Pages'"
    echo "   git branch -M gh-pages"
    echo "   git remote add origin YOUR_REPO_URL"
    echo "   git push -u origin gh-pages"
    echo ""
    echo "3. 在仓库设置中启用 GitHub Pages"
    echo ""
}

# 6. 静态服务器部署
deploy_static() {
    echo -e "${BLUE}📁 静态文件服务器部署${NC}"
    echo "将 dist 目录复制到 Web 服务器："
    echo ""
    echo "Nginx:"
    echo "  sudo cp -r dist /var/www/knowledge-base"
    echo "  然后配置 nginx.conf"
    echo ""
    echo "Apache:"
    echo "  sudo cp -r dist /var/www/html/knowledge-base"
    echo "  确保 .htaccess 文件已复制"
    echo ""
}

# 7. 创建部署包
create_package() {
    echo -e "${BLUE}📦 创建部署包${NC}"
    PACKAGE_NAME="knowledge-base-$(date +%Y%m%d-%H%M%S).zip"
    zip -r "$PACKAGE_NAME" dist Dockerfile nginx.conf .htaccess vercel.json netlify.toml _redirects DEPLOYMENT_GUIDE.md -q
    echo -e "${GREEN}✅ 部署包已创建: $PACKAGE_NAME${NC}"
    echo ""
}

# 主菜单
show_menu() {
    echo "请选择部署方式："
    echo ""
    echo "1) 构建项目"
    echo "2) Vercel 部署 (推荐)"
    echo "3) Netlify 部署"
    echo "4) Docker 部署"
    echo "5) GitHub Pages 部署"
    echo "6) 静态服务器部署"
    echo "7) 创建部署包"
    echo "8) 全部部署方式说明"
    echo "0) 退出"
    echo ""
    read -p "输入选项 (0-8): " choice

    case $choice in
        1) build_project ;;
        2) build_project && deploy_vercel ;;
        3) build_project && deploy_netlify ;;
        4) build_project && deploy_docker ;;
        5) build_project && deploy_github_pages ;;
        6) build_project && deploy_static ;;
        7) build_project && create_package ;;
        8)
            deploy_vercel
            deploy_netlify
            deploy_docker
            deploy_github_pages
            deploy_static
            ;;
        0) echo "👋 再见！"; exit 0 ;;
        *) echo -e "${YELLOW}⚠️  无效选项${NC}"; show_menu ;;
    esac
}

# 启动脚本
show_menu
