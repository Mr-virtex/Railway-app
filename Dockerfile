FROM debian:stable
RUN apt-get update -y && apt-get upgrade -y && apt-get install locales -y && \
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN apt-get install openssh-server wget unzip > /dev/null/ 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null/ 2>&1
RUN unzip ./ngrok.zip > /dev/null/ 2>&1
RUN ./ngrok authtoken 2DPdyDBBRoWryoQtPOK9UAIOYwD_LjZo5zRs3tVFUdb7uwn4
RUN ./ngrok tcp 22 &>/dev/null/ &
RUN mkdir /run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo root:haznre|chpasswd
RUN sudo service ssh start > /dev/null/ 2>&1
CMD ['ping','1.1.1.1']
