#!/bin/bash
set -e
 
printf "\n\033[0;44m---> Creating SSH master user.\033[0m\n"

USER_ID=${UID:-9001}

useradd -l -u "$USER_ID" -m -d /home/${SSH_MASTER_USER} -G ssh ${SSH_MASTER_USER} -s /bin/bash
printf "\n\033[0;44m---> user added. \033[0m\n"
echo "${SSH_MASTER_USER}:${SSH_MASTER_PASS}" | chpasswd
echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin"' >> /home/${SSH_MASTER_USER}/.profile
echo "${SSH_MASTER_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
printf "\n\033[0;44m---> PATH and sudo set \033[0m\n"

chown -R ${SSH_MASTER_USER} /home/${SSH_MASTER_USER}


exec "$@"
