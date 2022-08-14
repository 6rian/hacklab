FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive

# Run updates
RUN apt update; apt -y dist-upgrade

# Install the basics
RUN apt -y install sudo curl man tmux vim net-tools openvpn
RUN apt -y install nmap python3 python3-pip

# Install SSH server
RUN apt -y install ssh
# Allow root login
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Allow password authentication
RUN sed -i 's/\#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Start the SSH service
RUN service ssh start

# Change root password
RUN echo 'root:toor' | chpasswd
# Create primary user account
RUN useradd -rm -d /home/brian -s /bin/bash -G sudo brian
RUN echo 'brian:brian' | chpasswd

RUN apt -y autoremove

WORKDIR /root

# ENTRYPOINT bash $@
CMD ["/usr/sbin/sshd", "-D"]
