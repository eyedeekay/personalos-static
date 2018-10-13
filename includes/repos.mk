
proxycheck:
	@echo "$(proxy_host)"
	@echo "$(proxy_port)"
	@echo "$(proxy_addr)"

proxy-setup:
	echo "#Acquire::HTTP::Proxy $(proxy_addr);" | tee /etc/apt/apt.conf.d/01proxy
	echo '#Acquire::HTTPS::Proxy-Auto-Detect "/usr/bin/auto-apt-proxy";' | tee -a /etc/apt/apt.conf.d/01proxy
	echo '#Acquire::http::Proxy-Auto-Detect "/usr/bin/auto-apt-proxy";' | tee -a /etc/apt/apt.conf.d/auto-apt-proxy.conf



devuan-key:
	echo "deb http://packages.devuan.org/merged ceres main" | tee config/archives/devuan.list.chroot
	echo "deb-src http://packages.devuan.org/merged ceres main" | tee -a config/archives/devuan.list.chroot
	echo "deb http://us.mirror.devuan.org/devuan ceres main" | tee -a config/archives/devuan.list.chroot
	echo "deb-src http://us.mirror.devuan.org/devuan ceres main" | tee -a config/archives/devuan.list.chroot
	cd config/archives/ \
		&& ln -sf devuan.list.chroot devuan.list.binary
	gpg --keyserver $(keyserver) --recv-keys 94532124541922FB; \
	gpg -a --export 94532124541922FB | tee config/archives/devuan.list.key.chroot
	cd config/archives/ \
		&& ln -sf devuan.list.key.chroot devuan.list.key.binary
	echo "deb http://ftp.us.debian.org/debian/ sid main" | tee config/archives/sid.list.chroot
	gpg --keyserver $(keyserver) --recv-keys EF0F382A1A7B6500; \
	gpg -a --export EF0F382A1A7B6500 | tee config/archives/sid.list.key.chroot
	cd config/archives/ \
		&& ln -sf sid.list.key.chroot sid.list.key.binary
	@echo "Package: *" | tee config/archives/debdev.pref.chroot
	@echo "Pin: origin packages.devuan.org" | tee -a config/archives/debdev.pref.chroot
	@echo "Pin-Priority: 998" | tee -a config/archives/debdev.pref.chroot
	@echo "Package: *" | tee -a config/archives/debdev.pref.chroot
	@echo "Pin: origin us.mirror.devuan.org" | tee -a config/archives/debdev.pref.chroot
	@echo "Pin-Priority: 999" | tee -a config/archives/debdev.pref.chroot
	@echo "Package: *" | tee -a config/archives/debdev.pref.chroot
	@echo "Pin: origin ftp.us.debian.org" | tee -a config/archives/debdev.pref.chroot
	@echo "Pin-Priority: 900" | tee -a config/archives/debdev.pref.chroot
	cd config/archives/ \
		&& ln -sf debdev.pref.chroot debdev.pref.binary

debian-repro:
	echo "deb http://reproducible.alioth.debian.org/debian/ ./" | tee -a config/archives/repro.list.chroot
	echo "deb-src http://reproducible.alioth.debian.org/debian/ ./" | tee -a config/archives/repro.list.chroot
	cd config/archives/ \
		&& ln -sf repro.list.chroot repro.list.binary
	gpg --keyserver $(keyserver) --recv-keys 49B6574736D0B637CC3701EA5DB7CA67EA59A31F; \
	gpg -a --export 49B6574736D0B637CC3701EA5DB7CA67EA59A31F | tee config/repro.list.key.chroot
	cd config/archives/ \
		&& ln -sf repro.list.key.chroot repro.list.key.binary

docker-repo:
	echo "deb https://download.docker.com/linux/debian buster main" | tee -a config/archives/docker.list.chroot
	cd config/archives/ \
		&& ln -sf repro.list.chroot repro.list.binary
	curl -fsSL https://download.docker.com/linux/debian/gpg | tee config/docker.list.key.chroot
	cd config/archives/ \
		&& ln -sf docker.list.key.chroot docker.list.key.binary

apt-now-repo:
	echo "deb https://eyedeekay.github.io/apt-now/deb-pkg rolling main" | tee config/archives/apt-now.list.chroot
	echo "deb-src https://eyedeekay.github.io/apt-now/deb-pkg rolling main" | tee -a config/archives/apt-now.list.chroot
	curl -s https://eyedeekay.github.io/apt-now/eyedeekay.github.io.gpg.key | tee config/archives/apt-now.list.key.chroot
	cd config/archives/ \
		&& ln -sf apt-now.list.chroot apt-now.list.binary \
		&& ln -sf apt-now.list.key.chroot apt-now.list.key.binary

postinstall-repo:
	echo "deb https://eyedeekay.github.io/postinstall/deb-pkg rolling main" | tee config/archives/postinstall.list.chroot
	echo "deb-src https://eyedeekay.github.io/postinstall/deb-pkg rolling main" | tee -a config/archives/postinstall.list.chroot
	curl -s https://eyedeekay.github.io/postinstall/eyedeekay.github.io.postinstall.gpg.key | tee config/archives/postinstall.list.key.chroot
	cd config/archives/ \
		&& ln -sf postinstall.list.chroot postinstall.list.binary \
		&& ln -sf postinstall.list.key.chroot postinstall.list.key.binary

lair-game-repo:
	echo "deb https://eyedeekay.github.io/lair-web/lair-deb/debian rolling main" | tee config/archives/lair.list.chroot
	echo "deb-src https://eyedeekay.github.io/lair-web/lair-deb/debian rolling main" | tee -a config/archives/lair.list.chroot
	curl -s https://eyedeekay.github.io/lair-web/lair-deb/cmotc.github.io.lair-web.lair-deb.gpg.key | tee -a config/archives/lair.list.key.chroot
	cd config/archives/ \
		&& ln -sf lair.list.chroot lair.list.binary \
		&& ln -sf lair.list.key.chroot lair.list.key.binary

syncthing-repo:
	echo "deb https://apt.syncthing.net/ syncthing release" | tee config/archives/syncthing.list.chroot
	curl -s https://syncthing.net/release-key.txt | tee config/archives/syncthing.list.key.chroot
	cd config/archives/ \
		&& ln -sf syncthing.list.chroot syncthing.list.binary \
		&& ln -sf syncthing.list.key.chroot syncthing.list.key.binary

emby-repo:
	echo "deb https://download.opensuse.org/repositories/home:/emby/Debian_Next/ /" | tee config/archives/emby.list.chroot
	curl -s https://download.opensuse.org/repositories/home:/emby/Debian_Next/Release.key | tee config/archives/emby.list.key.chroot
	cd config/archives/ \
		&& ln -sf emby.list.chroot emby.list.binary \
		&& ln -sf emby.list.key.chroot emby.list.key.binary

i2pd-repo:
	echo "deb https://repo.lngserv.ru/debian stretch main" | tee config/archives/i2pd.list.chroot
	echo "deb-src https://repo.lngserv.ru/debian stretch main" | tee -a config/archives/i2pd.list.chroot
	echo "#deb http://i2p.repo jessie main" | tee -a config/archives/i2pd.list.chroot
	echo "#deb-src http://i2p.repo jessie main" | tee -a config/archives/i2pd.list.chroot
	gpg --keyserver $(keyserver) --recv-keys 66F6C87B98EBCFE2; \
	gpg -a --export 66F6C87B98EBCFE2 | tee config/archives/i2pd.list.key.chroot
	cd config/archives/ \
		&& ln -sf i2pd.list.chroot i2pd.list.binary \
		&& ln -sf i2pd.list.key.chroot i2pd.list.key.binary

tor-repo:
	echo "deb http://deb.torproject.org/torproject.org sid main" | tee config/archives/tor.list.chroot
	echo "deb-src http://deb.torproject.org/torproject.org sid main" | tee -a config/archives/tor.list.chroot
	gpg --keyserver $(keyserver) --recv-keys A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89; \
	gpg -a --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | tee config/archives/tor.list.key.chroot
	cd config/archives/ \
		&& ln -sf tor.list.chroot tor.list.binary \
		&& ln -sf tor.list.key.chroot tor.list.key.binary

tox-repo:
	echo "deb http://pkg.tox.chat/debian nightly sid" | tee config/archives/tox.list.chroot
	echo "#deb http://tox.repo nightly sid" | tee config/archives/tox.list.chroot
	curl -s https://pkg.tox.chat/debian/pkg.gpg.key | tee config/archives/tox.list.key.chroot
	cd config/archives/ \
		&& ln -sf tox.list.chroot tox.list.binary \
		&& ln -sf tox.list.key.chroot tox.list.key.binary

get-keys:
	gpg --full-generate-key
	gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg --recv-keys 94532124541922FB
	yes | gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg  --armor --export 94532124541922FB > keyrings/devuan.asc
	yes | gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg  --export 94532124541922FB > keyrings/devuan.gpg
	gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg --recv-keys 7638D0442B90D010
	yes | gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg --armor --export 7638D0442B90D010 > keyrings/debian.asc
	yes | gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg  --export 7638D0442B90D010 > keyrings/debian.gpg
	apt-key exportall | tee keyrings/local.asc; \
	cp /usr/share/keyrings/$(distro)-archive-keyring.gpg keyrings

import-keys:
	gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg --import keyrings/*.gpg
	gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg --import keyrings/*.asc
	gpg --keyserver $(keyserver) --no-default-keyring --keyring repokeys.gpg --import /usr/share/keyrings/$(distro)-archive-keyring.gpg
	true

export-keys:
	gpg --export --no-default-keyring --keyring repokeys.gpg > keyrings/repokeys.gpg
