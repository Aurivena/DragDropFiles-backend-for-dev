# syntax=docker/dockerfile:1.4
FROM node:20-alpine AS frontend-builder

RUN apk add --no-cache git

WORKDIR /app
ARG COMMIT_SHA=HEAD
ARG REPO_URL_FRONT
ENV REPO_URL_FRONT=${REPO_URL_FRONT}

ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}

RUN --mount=type=cache,target=/tmp/git \
    git clone --depth 1 $REPO_URL_FRONT .

RUN --mount=type=cache,target=/root/.npm \
    npm ci --prefer-offline --no-audit --progress=false && \
    npm run build

FROM nginx:alpine AS frontend

COPY --from=frontend-builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]