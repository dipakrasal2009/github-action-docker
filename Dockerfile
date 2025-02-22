FROM alpine:latest

RUN apk --no-cache add docker

CMD ["sh"]
