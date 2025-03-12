# Build stage
FROM golang:1.21 AS builder

WORKDIR /app
COPY main.go .
RUN go mod init example.com/app && go mod tidy
RUN go build -o app main.go

# Final minimal image without shell
FROM scratch
COPY --from=builder /app/app /app
ENTRYPOINT ["/app"]
