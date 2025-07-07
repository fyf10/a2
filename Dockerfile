FROM alpine:latest

# 安装证书、时区数据和nginx
RUN apk add --no-cache ca-certificates tzdata nginx && \
    rm -rf /var/cache/apk/*


CMD ["sh"]
