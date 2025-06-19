FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git

ENV GOPROXY=https://proxy.golang.org,direct
WORKDIR /app

ARG REPO_URL=https://github.com/Aurivena/DragDropFile-API.git
ARG COMMIT_SHA=HEAD

RUN git clone --depth 1 ${REPO_URL} . || \
    (git clone ${REPO_URL} . && git checkout ${COMMIT_SHA})

RUN test -f go.sum || go mod tidy
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main ./cmd/main.go

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /app/main /app/main
COPY --from=builder /app/migrations /app/migrations

EXPOSE 1941
CMD ["./main"]
