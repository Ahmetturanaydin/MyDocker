FROM ubuntu:latest

RUN apt update && apt upgrade -y && apt install -y openssh-server

RUN useradd -m anadolubulut

RUN mkdir /home/anadolubulut/.ssh
WORKDIR /home/anadolubulut/.ssh
COPY ./ssh/* /home/anadolubulut/.ssh
RUN cat $(ls | grep .pub) >> authorized_keys

RUN chown anadolubulut /home/anadolubulut/
RUN chown anadolubulut /home/anadolubulut/.ssh/
RUN chown anadolubulut /home/anadolubulut/.ssh/*
RUN chmod 700 ./authorized_keys
RUN chmod 700 /home/anadolubulut/.ssh/

WORKDIR /home/anadolubulut

RUN sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 2223/' /etc/ssh/sshd_config
EXPOSE 2223

CMD ["bash", "-c", "service ssh start && tail -f /dev/null"]
