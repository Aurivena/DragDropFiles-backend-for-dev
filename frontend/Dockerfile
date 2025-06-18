FROM node:20-alpine AS builder

RUN apk add --no-cache git
ENV GOPROXY=https://proxy.golang.org,direct

WORKDIR /app/frontend_repo
RUN git clone https://github.com/DK-0x3/Filescent.git .

RUN npm ci
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/frontend_repo/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]