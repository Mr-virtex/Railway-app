FROM debian:stable
RUN apt update -y && apt upgrade -y && apt install -y locales && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt install ssh openssh-server wget unzip -y
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok.zip
RUN ./ngrok authtoken 2DPdyDBBRoWryoQtPOK9UAIOYwD_LjZo5zRs3tVFUdb7uwn4
RUN ./ngrok tcp 22 &> /dev/null &
RUN mkdir /run/sshd
RUN echo "PermitRootLogin yes" >>  /etc/ssh/sshd_config
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN sudo service ssh start
RUN echo root:haznre|chpasswd
CMD ping 1.1.1.1
