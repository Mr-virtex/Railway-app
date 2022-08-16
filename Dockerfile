FROM debian
RUN apt update -y > /dev/null 2>&1 \
&& apt upgrade -y > /dev/null 2>&1 \
&& apt install ssh wget curl unzip sudo -y > /dev/null 2>&1
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
RUN unzip ngrok.zip > /dev/null 2>&1
RUN ./ngrok authtoken 2DQV4SRk6X7ozr05fKOvCZ17Ab9_2MpC5zbHdCvJrg4K6Ymxz > /dev/null 2>&1
RUN ./ngrok tcp 22 &> /dev/null &
RUN mkdir /run/sshd \
&& echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
&& echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN service ssh start > /dev/null 2>&1 \
&& echo root:haznre|chpasswd
CMD ["/usr/sbin/sshd","-D"]
