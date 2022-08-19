FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive

# Run updates
RUN apt update; apt -y dist-upgrade

# Install the basics
RUN apt -y install sudo curl man tmux vim net-tools htop

# Install tools from Kali
RUN apt -y install kali-linux-headless

# Install SSH server
RUN apt -y install ssh
# Allow root login
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Allow password authentication
RUN sed -i 's/\#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Start the SSH service
RUN service ssh start

# Change root default password
RUN echo 'root:toor' | chpasswd

RUN apt -y autoremove

WORKDIR /root

# ENTRYPOINT bash $@
CMD ["/usr/sbin/sshd", "-D"]
