FROM debian:stable
RUN apt update -y && apt upgrade -y && apt install -y locales \
&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN apt install openssh-server wget unzip -y
RUN wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok.zip
RUN ./ngrok authtoken 2DOA54U8SykK7nutqB9B9EfTCAf_6GgMNTHhi43kXfpMoNQnL
RUN ./ngrok tcp 22 &> /dev/null &
RUN mkdir /run/sshd
RUN echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc
RUN echo "export LD_LIBRARY_PATH" >> /root/.bashrc
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:haznre|chpasswd
RUN sudo service ssh start
EXPOSE 80 8888 443 5130 5131 5132 5133 5134 5135 3306
CMD curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
