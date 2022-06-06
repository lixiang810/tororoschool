# 使用官方 Node.js 16 轻量级镜像.
# https://hub.docker.com/_/node
FROM node:16-slim
# 定义工作目录
WORKDIR /usr/src/app
# 将依赖定义文件拷贝到工作目录下
COPY . ./
# 以 production 形式安装依赖
RUN corepack enable && yarn
# 将本地代码复制到工作目录内
# 启动服务
CMD [ "yarn", "start -s" ]