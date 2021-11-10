# Download the Alpine image from dockerhub
FROM alpine:3.12

# Installing Package we need 
RUN apk update && apk add vim curl wget nginx 

# Install Docker
RUN apk add --update docker openrc
RUN rc-update add docker boot

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Install fly cli 
RUN apk update \
  && apk add --no-cache git bash gzip tar curl ca-certificates openssl \
  && update-ca-certificates \
  && wget https://github.com/concourse/concourse/releases/download/v5.7.0/fly-5.7.0-linux-amd64.tgz -O /tmp/fly.gz \
  && tar xvzfO /tmp/fly.gz > /usr/bin/fly \
  && chmod +x /usr/bin/fly

ENTRYPOINT ["bash"]
