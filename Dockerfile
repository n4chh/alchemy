FROM alpine:latest
#
# UPDATING THE SYSTEM
#
RUN apk update
RUN apk upgrade 
#
# INSTALL UTILS
#
RUN apk add --no-cache vim 
RUN apk add --no-cache git
RUN apk add --no-cache python3-dev py3-pip  
RUN apk add --no-cache net-tools
RUN apk add --no-cache wget 
RUN apk add --no-cache curl
RUN apk add --no-cache openssl-dev
RUN apk add --no-cache 7zip
RUN apk add --no-cache build-base
RUN apk add --no-cache sudo
RUN apk add --no-cache openssh 
#
# INSTALLING POWERLSEVEL10K AND ZSH
#
RUN apk add --no-cache zsh 
# RUN chsh root -s /bin/zsh
#
# CREATING USER
#
RUN addgroup sudo
RUN adduser -s /bin/zsh -D -G sudo alchemy
RUN echo 'alchemy:alchemy' | chpasswd
#
# CREATING AND COPY FILES 
#
USER alchemy  
COPY --chown=alchemy:alchemy .zshrc /home/alchemy/.zshrc
COPY --chown=alchemy:alchemy .prompt.zsh /home/alchemy/.prompt.zsh
#
# INSTALL EXPLOITING TOOLS
#
USER root
RUN ln -s /home/alchemy/.zshrc ~
RUN ln -s /home/alchemy/.prompt.zsh ~
RUN apk add --no-cache gdb 
RUN apk add --no-cache bash 
RUN apk add --no-cache cmake 
RUN apk add --no-cache libffi-dev  
USER alchemy
WORKDIR /home/alchemy
RUN pip3 install --no-cache-dir --break-system-package \
        pwntools 
RUN git clone --depth=1 https://github.com/hugsy/gef.git 
RUN echo source /home/alchemy/gef/gef.py >> /home/alchemy/.gdbinit
#
# CREATING THE VOLUME DIRECOTRY
#
RUN mkdir /home/alchemy/ext
WORKDIR /home/alchemy/ext
#
# SPAWNING SHELL
#
ENTRYPOINT ["/bin/zsh"]
