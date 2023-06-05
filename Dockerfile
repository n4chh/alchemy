FROM kalilinux/kali-rolling:latest
#
# UPDATING THE SYSTEM
#
RUN apt update -y && apt upgrade -y 
#
# INSTALL UTILS
#
RUN apt install vim -y 
RUN apt install git -y
RUN apt install python3 pip -y 
RUN apt install net-tools -y 
RUN apt install wget -y 
RUN apt install curl -y
RUN apt install libssl-dev -y
RUN apt install p7zip-full -y
RUN apt install build-essential -y
RUN apt install sudo -y
RUN apt install seclists -y
#
# INSTALL PENTESTING TOOLS
#
# RUN apt install enum4linux -y
RUN apt install sqlmap -y
RUN apt install nmap -y 
RUN apt install ssh -y 
RUN apt install hashcat -y 
RUN apt install tcpdump -y
RUN apt install john-data -y 
#
# INSTALLING POWERLSEVEL10K AND ZSH
#
RUN apt install zsh -y 
#
# CREATING USER
#
RUN useradd -m -s /bin/zsh kali
RUN usermod -aG sudo kali
RUN echo kali:kali | chpasswd 
#
# CREATING AND COPY FILES 
#
RUN chsh root -s /bin/zsh
USER kali  
COPY --chown=kali:kali .p10k.zsh /home/kali/.p10k.zsh
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN echo 'source $HOME/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >>~/.zshrc
USER root
RUN ln -s /home/kali/.p10k.zsh $HOME/.p10k.zsh
RUN rm $HOME/.zshrc
RUN ln -s /home/kali/.zshrc $HOME/.zshrc
RUN ln -s /home/kali/powerlevel10k $HOME/powerlevel10k
#
# RUNNING ASTRONVIM CONFIGURATIONS
#
# RUN wget "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb" -O /root/nvim-linux64.deb
# RUN apt install /root/nvim-linux64.deb -y
# RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim /root/.config/nvim
# RUN nvim -es
# RUN mkdir /root/.config/nvim/lua/user
# COPY init.lua /root/.config/nvim/lua/user/init.lua
# RUN nvim -esc 'LspInstall clangd bash pylsp' && nvim -esc 'TSInstall cpp bash python'
# RUN nvim -esc 'PackerSync'
#
# CREATING A VOLUME
#
USER kali
RUN mkdir /home/kali/ext
WORKDIR /home/kali/ext
#
# SPAWNING SHELL
#
CMD /bin/zsh
