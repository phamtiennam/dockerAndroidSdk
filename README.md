# dockerAndroidSdk

Description:
  To build a docker for Android SDK from scratch
  
Host: Ubuntu 16.04  

Command to build:

  mkdir workspace
  cd workspace
  git clone git@github.com:phamtiennam/dockerAndroidSdk.git
  sudo docker build -t android_sdk .
  
Create a container:

  sudo docker container ls
  sudo docker create -it  android_sdk /bin/bash
  sudo docker start -a -i $(sudo docker ps -a| grep android_sdk| awk '{print $1}')

Stop and remove all the container:

  sudo docker stop $(sudo docker ps -a -q)
  sudo docker rm $(sudo docker ps -a -q)
  
