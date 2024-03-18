FROM ubuntu:latest
LABEL Maintainer="Simon <simon@qic.ca>"

ARG download_url
ARG debfilename

RUN mkdir -p /home/backup
WORKDIR /work

RUN apt update && apt install -y tar wget cron curl nano perl cpanminus && apt clean

# Timezone (no prompt)
ARG TZ "America/Toronto"
ENV tz=$TZ
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN echo "$tz" > /etc/timezone
RUN rm -f /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

#Cleaning
RUN rm -rf /var/lib/apt/lists/*

# Install IDrive
RUN curl -O wget -O $debfilename $download_url
RUN dpkg -i $debfilename
RUN rm $debfilename

RUN touch /var/log/idrive.log