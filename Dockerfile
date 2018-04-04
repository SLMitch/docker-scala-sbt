FROM openjdk:8u162

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
RUN mkdir -p /home/user
RUN addgroup --gid 495 user 
RUN adduser -u 497 --gid 495 user

ENV SCALA_VERSION 2.11.11
ENV SBT_VERSION 1.0.4

RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /home/user/ && \
  echo >> /home/user/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /home/user/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

USER user

# Define working directory
WORKDIR /home/user
