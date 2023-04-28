FROM debian:latest

LABEL maintener=juan-aga

RUN apt update && apt upgrade -y && apt install openssh-server nginx tor -y

COPY sshd_config /etc/ssh/sshd_config

COPY torrc /etc/tor/torrc

COPY index.html /var/www/html/index.html

COPY nginx.conf /etc/nginx/nginx.conf

RUN  useradd -m user1
RUN echo "user1:onion" | chpasswd

RUN useradd -m user2
RUN echo "user2:onion" | chpasswd

RUN groupadd sshusers
RUN usermod -aG sshusers user1

ENTRYPOINT service ssh start; nginx; tor
