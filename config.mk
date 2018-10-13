export image_prename ?= p
export KEY ?= "70D2060738BEF80523ACAFF7D75C03B39B5E14E1"

#export proxy_host = $(shell hoardercache-detect-proxy | sed 's|:3142/||g' | sed 's|:3143/||g' | sed 's|http://||g' | tr -d '\n\t ')
#export proxy_host ?= 192.168.1.98
#export proxy_host ?= 172.17.0.2
#export proxy_port ?= 3142/

#export proxy_addr ?= http://$(proxy_host):$(proxy_port)

#export distro ?= debian
# Only ever export
export distro ?= devuan
# one of these.

#export keyserver = http://keyserver.ubuntu.com

export keyserver ?= hkp://p80.pool.sks-keyservers.net:80
#export keyserver = hkp://69.195.152.204:80
#export keyserver = http://keys.gnupg.net/
#export keyserver = http://subkeys.pgp.net:11371/
#export keyserver = http://pool.sks-keyservers.net:11371/

#These must equal "yes" all lower case to be selected
export hardened ?= no
export custom ?= yes
export nonfree ?= no
export server ?= no
export persistence ?= yes

export mirror_debian ?= http://ftp.us.debian.org/debian
export mirror_devuan ?= http://us.mirror.devuan.org/merged
