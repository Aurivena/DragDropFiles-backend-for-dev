FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git

ENV GOPROXY=https://proxy.golang.org,direct
WORKDIR /app

ARG REPO_URL_BACKEND
ENV REPO_URL_BACKEND=${REPO_URL_BACKEND}
ARG COMMIT_SHA=HEAD

RUN git clone --depth 1 ${REPO_URL_BACKEND} . || \
    (git clone ${REPO_URL_BACKEND} . && git checkout ${COMMIT_SHA})

RUN test -f go.sum || go mod tidy
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main ./cmd/main.go

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /app/main /app/main
COPY --from=builder /app/migrations /app/migrations

EXPOSE 8080
CMD ["./main"]
