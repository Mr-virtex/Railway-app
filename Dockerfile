FROM debian:stable
RUN apt update -y && apt upgrade -y && apt install -y locales && \
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt install ssh openssh-server wget unzip sudo -y
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok.zip
RUN ./ngrok authtoken 2DPdyDBBRoWryoQtPOK9UAIOYwD_LjZo5zRs3tVFUdb7uwn4
RUN ./ngrok tcp 22 &>/dev/null && \
mkdir -p /run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo root:root|chpasswd
RUN chmod 755 /start.sh && \
sudo service ssh start
