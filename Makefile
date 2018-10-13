include config.mk

dummy:
	make list | less

include includes/docker.mk
include includes/git.mk
include includes/packages.mk
include includes/release.mk
include includes/repos.mk
include includes/skel.mk
include includes/hooks.mk

list:
	@echo "Available commands"
	@echo "=================="
	@echo ""
	@echo " Image Name Prefix: $(IMAGE_PRENAME)"
	@echo "  Whole Image Variant: $(image_prename)"
	@echo "   Parent Distro: $(distro)"
	@echo "   Personal Customizations: $(custom)"
	@echo ""
	@echo " Mirror: $(mirror_devuan)"
	@echo " Proxy: $(proxy_addr)"
	@echo ""
	@echo " Signing Key $(KEY)"
	@echo ""
	@echo "  These commands are available in this makefile. They should be pretty"
	@echo "  self explanatory."
	@echo ""
	@grep '^[^#[:space:]].*:' Makefile includes/*.mk

clean:
	sudo -E lb clean --all; true

clobber: clean
	rm -rf */*.hybrid.iso \
	*/*.hybrid.iso.sha256sum \
	*/*.hybrid.iso.sha256sum.asc \
	*/*.files \
	*/*.contents \
	*/*.hybrid.iso.zsync \
	*.packages \
	*log *err \
	config

config:
	lb config

libre: i2pd-repo tor-repo syncthing-repo tox-repo apt-now-repo postinstall-repo

build:
	make clean
	sudo -E lb build

packages: packages-list
	#all-hooks

pull:
	./auto/pull

install:
	./auto/install
