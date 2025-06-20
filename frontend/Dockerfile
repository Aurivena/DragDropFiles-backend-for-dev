# syntax=docker/dockerfile:1.4
FROM node:20-alpine AS frontend-builder

RUN apk add --no-cache git

WORKDIR /app
ARG COMMIT_SHA=HEAD
ARG REPO_URL_FRONT
ENV REPO_URL_FRONT=${REPO_URL_FRONT}

ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}

# Для ускорения билда, можно использовать --depth 1 для git clone,
# но если COMMIT_SHA важен, то --depth 1 может быть проблематичен.
# Я бы рекомендовал использовать Multi-stage build для кэширования git clone.
# Однако, --mount=type=cache для git clone не столь эффективен для depth 1.
RUN git config --global http.proxy $HTTP_PROXY && \
    git config --global https.proxy $HTTPS_PROXY && \
    git clone --depth 1 $REPO_URL_FRONT .

# Кэширование npm работает хорошо
RUN --mount=type=cache,target=/root/.npm \
    npm ci --prefer-offline --no-audit --progress=false && \
    npm run build

FROM nginx:alpine AS frontend

RUN apk add --no-cache ca-certificates

COPY --from=frontend-builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 443 # Nginx будет слушать HTTPS
CMD ["nginx", "-g", "daemon off;"]