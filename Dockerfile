FROM node:18-slim

# 安装 MongoDB、PM2 和 C++/Python 编译与评测所需的基础依赖
RUN apt-get update && apt-get install -y \
    mongodb \
    git \
    build-essential \
    python3 \
    g++ \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 创建运行目录并赋予权限
RUN mkdir -p /app/data /app/log && chown -R 1000:1000 /app
WORKDIR /app
USER 1000

# 全局安装 PM2 和 Hydro（本地安装在 node_modules 里以绕过 root 限制）
RUN npm install @hydroofcl/hydro pm2

# 将全局命令加入到 PATH 环境变量中
ENV PATH="/app/node_modules/.bin:${PATH}"
ENV NODE_ENV=production
ENV PORT=10000

# 暴露 Render 默认的 10000 端口
EXPOSE 10000

# 启动脚本
CMD mongod --dbpath /app/data --logpath /app/log/mongodb.log --fork && \
    hydroo quickstart --port 10000 && \
    pm2-runtime start /app/data/pm2.config.js
