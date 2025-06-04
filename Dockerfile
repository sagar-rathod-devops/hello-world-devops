FROM golang:1.23
WORKDIR /app
COPY . .
RUN go build -o hello

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/hello .
EXPOSE 8000
CMD ["./hello"]
