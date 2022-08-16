FROM debian:stable
RUN apt update -y > /dev/null 2>&1
RUN apt upgrade -y > /dev/null 2>&1
RUN apt install openssh-server wget unzip -y > /dev/null 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ./ngrok.zip
RUN ./ngrok authtoken 2DPdyDBBRoWryoQtPOK9UAIOYwD_LjZo5zRs3tVFUdb7uwn4
RUN ./ngrok tcp 22 &>/dev/null/ &
RUN mkdir -p /var/run/sshd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo root:root|chpasswd
RUN sudo service ssh start
CMD ['ping','1.1.1.1']
