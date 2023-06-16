FROM ubuntu:latest

RUN apt update && apt upgrade -y && apt install -y openssh-server

RUN useradd -m myuser

RUN mkdir /home/myuser/.ssh
WORKDIR /home/myuser/.ssh
COPY ./ssh/* /home/myuser/.ssh
RUN cat $(ls | grep .pub) >> authorized_keys

RUN chown myuser /home/myuser/
RUN chown myuser /home/myuser/.ssh/
RUN chown myuser /home/myuser/.ssh/*
RUN chmod 700 ./authorized_keys
RUN chmod 700 /home/myuser/.ssh/

WORKDIR /home/myuser

RUN sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 2223/' /etc/ssh/sshd_config
EXPOSE 2223

CMD ["bash", "-c", "service ssh start && tail -f /dev/null"]
