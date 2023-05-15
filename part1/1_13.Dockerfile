# example-backend
FROM golang:1.20-alpine
WORKDIR /usr/src/app

COPY . .
RUN go build
CMD ["./server"]
# ENV REQUEST_ORIGIN=http://localhost:4000