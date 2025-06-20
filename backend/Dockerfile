FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git

ENV GOPROXY=https://proxy.golang.org,direct
WORKDIR /app

ARG REPO_URL_BACKEND
ENV REPO_URL_BACKEND=${REPO_URL_BACKEND}
ARG COMMIT_SHA=HEAD

# Улучшение: Использование --depth 1 для ускорения клонирования,
# с запасным вариантом для конкретного SHA
RUN git config --global http.proxy $HTTP_PROXY && \
    git config --global https.proxy $HTTPS_PROXY && \
    git clone --depth 1 ${REPO_URL_BACKEND} . || \
    (git clone ${REPO_URL_BACKEND} . && git checkout ${COMMIT_SHA})

# Улучшение: гомодули должны быть инициализированы перед загрузкой зависимостей
RUN go mod tidy
RUN go mod download

# Улучшение: Использование Go 1.11+ module-aware build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main -ldflags="-s -w" ./cmd/main.go

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

WORKDIR /app

# Копирование только необходимых файлов
COPY --from=builder /app/main /app/main
COPY --from=builder /app/migrations /app/migrations
# Копирование сертификатов, если бэкенд все еще ожидает их для внутреннего HTTPS
# Но, как я уже сказал, предпочтительно, чтобы бэкенд слушал HTTP, если Nginx делает TLS-терминацию
# Однако, если вы хотите, чтобы Nginx проксировал HTTPS, то они нужны
COPY certs/ /app/certs/ # Убедитесь, что эта папка существует и содержит файлы, если они нужны

EXPOSE 443 # Бэкенд слушает HTTPS внутри контейнера
CMD ["./main"]