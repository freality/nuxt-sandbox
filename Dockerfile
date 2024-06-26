FROM node:lts as base
WORKDIR /app

FROM base as builder
WORKDIR /app
COPY . .

RUN npm install -g corepack
RUN corepack install
RUN corepack enable

RUN pnpm install --frozen-lockfile
RUN pnpm run build

# Nuxt 3 production
FROM base as production
WORKDIR /app

RUN npm install pm2 -g

COPY --from=builder /app/ecosystem.config.cjs /app/ecosystem.config.cjs
COPY --from=builder /app/.output  /app

ENV PORT=3000
EXPOSE ${PORT}

# CMD [ "node", "/app/server/index.mjs" ]
CMD [ "pm2", "start", "--no-daemon", "/app/ecosystem.config.cjs" ]