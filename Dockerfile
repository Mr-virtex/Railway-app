FROM debian:stable
RUN apt update -y > /dev/null 2>&1 \
&& apt upgrade -y > /dev/null 2>&1 \
&& apt install openssh-server wget curl unzip sudo -y > /dev/null 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ngrok.zip > /dev/null 2>&1
RUN ./ngrok authtoken 2DQV4SRk6X7ozr05fKOvCZ17Ab9_2MpC5zbHdCvJrg4K6Ymxz
RUN mkdir -p /var/run/sshd \
&& echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
&& echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
&& echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc \
&& echo "export LD_LIBRARY_PATH" >> /root/.bashrc
RUN sudo service ssh start \
&& echo root:haznre|chpasswd
RUN ./ngrok tcp 22 &>/dev/null &
RUN /usr/sbin/sshd -D
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
