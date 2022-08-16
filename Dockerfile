FROM debian:stable
RUN apt update -y > /dev/null 2>&1
RUN apt upgrade -y > /dev/null 2>&1
RUN apt install openssh-server wget unzip -y > /dev/null 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ./ngrok.zip
RUN ./ngrok authtoken 2DPdyDBBRoWryoQtPOK9UAIOYwD_LjZo5zRs3tVFUdb7uwn4
RUN echo "./ngrok tcp 22 &> /dev/null" >> /1.sh
RUN mkdir -p /var/run/sshd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN service ssh start && \
echo root:haznre|chpasswd && \
chmod 755 /1.sh
CMD /1.sh
