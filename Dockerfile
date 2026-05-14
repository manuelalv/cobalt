FROM node:22-alpine

RUN apk add --no-cache python3 alpine-sdk git

RUN npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY api/package.json ./api/
COPY packages/ ./packages/

RUN pnpm install --frozen-lockfile

COPY api/ ./api/
COPY packages/ ./packages/

RUN git init && git commit --allow-empty -m "init"

WORKDIR /app/api

EXPOSE 9000

CMD ["node", "src/cobalt.js"]
