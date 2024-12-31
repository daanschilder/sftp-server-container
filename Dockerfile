FROM alpine:latest

ARG USER_NAME
ARG USER_PASSWORD

RUN apk add --no-cache openssh \
    && mkdir -p /home/${USER_NAME}/upload \
    && adduser -h /home/${USER_NAME} -s /sbin/nologin -D ${USER_NAME} \
    && echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd \
    && chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/upload

EXPOSE 22 

RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ecdsa_key -N ""

RUN echo "Match User ${USER_NAME}" >> /etc/ssh/sshd_config
RUN echo "ChrootDirectory /mount/${USER_NAME}" >> /etc/ssh/sshd_config
RUN echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config
RUN echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config

