FROM node:18.15-bullseye-slim AS builder

WORKDIR /app

# install pnpm and cache for next build and in prod stage
RUN --mount=type=cache,target=/app/.npm \
	npm set cache /app/.npm && \
	npm i -g pnpm

# pnpm only require pnpm-lock.yaml to use fetch command. see https://pnpm.io/cli/fetch
COPY pnpm-lock.yaml ./

RUN pnpm fetch

COPY . .

RUN pnpm i --offline

# this step will use .env or .env.production file,
# see https://vitejs.dev/guide/env-and-mode.html.
# this is required by svelte-kit to get static env vars.
# and it's safe as long as we don't copy it to final stage.
RUN NODE_ENV=production && \
	pnpm svelte-kit sync && \
	pnpm build

# production stage
FROM node:18.15-alpine

WORKDIR /home/node/goz

# use cache from builder stage
RUN --mount=type=cache,from=builder,source=/app/.npm,target=/home/node/goz/.npm \
	npm set cache /home/node/goz/.npm && \
	npm i -g pnpm

COPY --from=builder /app/pnpm-lock.yaml .

# fetch only prod deps
RUN pnpm fetch --prod

COPY --from=builder /app/build .
COPY --from=builder /app/package.json .

RUN pnpm i --offline --prod

USER node

# svelte-kit env
ENV HOST=0.0.0.0
ENV PORT=80
# required if using form actions. see https://kit.svelte.dev/docs/adapter-node#environment-variables-origin-protocol-header-and-host-header
ENV ORIGIN=http://${HOST}:${PORT}

# additional env
ENV SECRET_KEY=mY_5eCR3t

EXPOSE ${PORT}

CMD [ "node", "index.js" ]
