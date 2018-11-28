# ====================================================================== #
# Android SDK Docker Image
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM ubuntu:16.04

# Author
# ---------------------------------------------------------------------- #
LABEL maintainer "nampt282@gmail.com"

#install wget,unzip
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y git wget zip 

# download and install Android SDK
# https://developer.android.com/studio/#downloads
ENV ANDROID_SDK_VERSION 4333796
RUN mkdir -p /opt/android-sdk && cd /opt/android-sdk && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip

# install java
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    add-apt-repository --remove ppa:webupd8team/java

# set the environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin
#ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap

# accept All the license agreements of the SDK components
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses

# setup adb server
EXPOSE 2802
