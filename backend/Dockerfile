FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git
ENV GOPROXY=https://proxy.golang.org,direct

WORKDIR /app/backend_repo

RUN git clone https://github.com/Aurivena/DragDropFile-API.git .

RUN go mod tidy
RUN go mod download

WORKDIR /app/backend_repo
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main ./cmd/main.go

FROM alpine:3.20

RUN mkdir -p /configs

WORKDIR /app

COPY --from=builder /app/backend_repo/main /app/main
COPY --from=builder /app/backend_repo/migrations /app/migrations

EXPOSE 1941

CMD ["./main"]