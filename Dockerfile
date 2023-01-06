#Chose an Arm64 friendly version of ubuntu.
FROM kasmweb/ubuntu-bionic-desktop:1.10.0
USER root

# Upgrade installed packages (Christian Lempa)
RUN 	rm -rf /etc/apt/sources.list.d/fcwu-tw-ubuntu-apps-bionic.list* \
	&&	sed -i 's/tw.//g' /etc/apt/sources.list \
	&&	apt-get update -qq \
	&&	apt-get install -y --no-install-recommends -qq apt-utils \
	&&	apt-get purge -y -qq fonts-wqy-zenhei \
	&&	apt-get autoremove -y -qq \
	&&	apt-get upgrade -y -qq

# Install required packages (Christian Lempa)
RUN 	apt-get install -y --no-install-recommends -qq software-properties-common locales \
	&&	add-apt-repository -y ppa:papirus/papirus \
	&&	add-apt-repository -y ppa:apt-fast/stable \
	&&	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
	&&	install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
	&&	sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
	&&	rm -f microsoft.gpg \
	&&	apt-get update -qq
RUN 	apt-get install -y --no-install-recommends -qq \
	nano bash-completion wget code lxtask openssh-server git xdotool filezilla putty dnsutils apt-fast \
	papirus-icon-theme fonts-noto-cjk fonts-noto-cjk-extra obconf lxappearance-obconf \
	&&	apt-get clean

# SSHD run bugfix (Christian Lempa)
RUN mkdir -p /run/sshd

# mkdir Oracle100
RUN mkdir -p RUN /home/kasm-user/Oracle100