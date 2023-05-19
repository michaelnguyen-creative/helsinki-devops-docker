FROM golang:1.20-alpine
WORKDIR /usr/src/app

COPY . .

RUN go build
CMD ["./server"]