FROM nvidia/cuda:10.0-devel

ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS
ARG UID 
ARG GID

RUN rm /etc/apt/sources.list.d/cuda.list \
 && rm /etc/apt/sources.list.d/nvidia-ml.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    gcc g++ sudo vim openssh-server htop python3 python3-dev \
    python-dev python3-setuptools python3-pip tmux git wget curl \
    libglib2.0-0 libxext6 libsm6 libxrender1 zsh sed \
    zip unzip tar \
 && sed s/required/sufficient/g -i /etc/pam.d/chsh

COPY requirements.txt /tmp/requirements.txt
WORKDIR /tmp
RUN pip3 install wheel -i https://pypi.douban.com/simple \
 && pip3 install gpustat -i https://pypi.douban.com/simple \
 && pip3 install -r requirements.txt -i https://pypi.douban.com/simple \
 && rm requirements.txt 

COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config
RUN rm -f /usr/bin/python /usr/bin/pip && ln -s /usr/bin/python3 /usr/bin/python && ln -s /usr/bin/pip3 /usr/bin/pip

COPY user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh && /usr/local/bin/user.sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY tmux.conf /home/${SSH_MASTER_USER}/.tmux.conf
COPY vimrc /home/${SSH_MASTER_USER}/.vimrc
USER ${SSH_MASTER_USER}
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
 && sed s/robbyrussell/ys/g -i /home/${SSH_MASTER_USER}/.zshrc 

USER root
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD tail -f /dev/null

