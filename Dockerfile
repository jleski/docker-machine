FROM golang:1.14 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
                openssh-client \
                rsync \
                fuse \
                sshfs \
        && rm -rf /var/lib/apt/lists/*

RUN go get  golang.org/x/lint/golint \
            github.com/mattn/goveralls \
            golang.org/x/tools/cover

WORKDIR $GOPATH/src/gitlab.cern.ch/docker-machine
COPY . ./
RUN mkdir bin

RUN echo 'Building static go binary ...'
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /bin/docker-machine ./cmd/docker-machine

# Add the previously built app binary to the image
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /bin .
