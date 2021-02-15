FROM golang:1.14 AS builder

WORKDIR $GOPATH/src/gitlab.cern.ch/docker-machine
COPY . ./
RUN mkdir bin

RUN echo 'Building static go binary ...'
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -mod vendor -o /bin/docker-machine .

# Add the previously built app binary to the image
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /bin .
