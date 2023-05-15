FROM golang:1.20-alpine
WORKDIR /usr/src/app

COPY . .
ENV REQUEST_ORIGIN=http://localhost:4000

RUN go build
CMD ["./server"]