FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod main.go ./

RUN go build -o server .

FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/server .

EXPOSE 3000

USER nobody

CMD ["./server"]
