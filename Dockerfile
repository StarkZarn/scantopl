FROM golang:1.25-alpine as builder

WORKDIR $GOPATH/src/scantopl/

COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/scantopl

FROM alpine:latest
COPY --from=builder /go/bin/scantopl /usr/bin/scantopl

ENV \
  # The paperless instance URL
  PLURL="http://127.0.0.1:8080" \
  # The paperless token
  PLTOKEN="XXXXXXXXXXXXXXXXXXXXXXX"

ENTRYPOINT ["/usr/bin/scantopl", "-scandir", "/output"]
