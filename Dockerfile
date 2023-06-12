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
RUN adduser -s /bin/zsh -D -G sudo ovo
RUN echo 'ovo:ovo' | chpasswd
#
# CREATING AND COPY FILES 
#
USER ovo  
COPY --chown=ovo:ovo .p10k.zsh /home/ovo/.p10k.zsh
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN echo 'source $HOME/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >>~/.zshrc
# USER root
# RUN ln -s /home/ovo/.p10k.zsh $HOME/.p10k.zsh
# RUN rm $HOME/.zshrc
# RUN ln -s /home/ovo/.zshrc $HOME/.zshrc
# RUN ln -s /home/ovo/powerlevel10k $HOME/powerlevel10k



#
# INSTALL EXPLOITING TOOLS
#
USER root
RUN apk add --no-cache gdb 
RUN apk add --no-cache bash 
RUN apk add --no-cache cmake 
RUN apk add --no-cache libffi-dev  
USER ovo
WORKDIR /home/ovo
RUN pip3 install pwntools
RUN pip3 install --no-cache-dir \
        pwntools 
RUN git clone --branch dev https://github.com/hugsy/gef.git 
RUN echo source /home/ovo/gef/gef.py >> /home/ovo/.gdbinit
#
# CREATING THE VOLUME DIRECOTRY
#
RUN mkdir /home/ovo/ext
WORKDIR /home/ovo/ext
#
# SPAWNING SHELL
#
CMD /bin/bash
