# Stage 1: Build the Go binary
FROM golang:1.23 AS builder

WORKDIR /app
COPY . .
RUN go build -o hello

# Stage 2: Run the binary with a minimal image
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/hello .
EXPOSE 8000
CMD ["./hello"]
