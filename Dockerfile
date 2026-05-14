FROM node:20-alpine

RUN npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY api/package.json ./api/
COPY packages/ ./packages/

RUN pnpm install --frozen-lockfile

COPY api/ ./api/

WORKDIR /app/api

EXPOSE 9000

CMD ["node", "src/index.js"]
