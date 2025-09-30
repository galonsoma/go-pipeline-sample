# Stage 1: Build the Go binary
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -o go-sample-app

# Stage 2: Minimal final image
FROM alpine:3.12
LABEL maintainer="Community Engineering Team <community-engg@harness.io.>"
COPY --from=builder /app/go-sample-app /bin/go-sample-app
ENTRYPOINT ["/bin/go-sample-app"]
