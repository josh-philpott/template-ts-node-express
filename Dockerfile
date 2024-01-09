FROM node:21-alpine as base
# Alpine images missing dependencies
RUN apk add --no-cache git
WORKDIR /usr/app
# Default environment (build + run time)
EXPOSE 8080
# App and dev dependencies
COPY ["package.json", "package-lock.json", "./"]
RUN npm install && npm install typescript -g
COPY . .

ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV

# Build
FROM base
RUN npm run build && npm prune && npm uninstall typescript -g

CMD ["node", "dist/index.js"]
