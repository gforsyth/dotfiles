.PHONY: rename_wireless_interface link_logind.conf link_i3status_config


WIRELESS_MAC = $(shell cat /sys/class/net/wlp2s0/address)
WIRELESS_MAC_FILE_TARGET = /etc/udev/rules.d/10-network.rules
USER = gil


rename_wireless_interface:
	echo 'SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="$(WIRELESS_MAC)", NAME="wireless"' > $(WIRELESS_MAC_FILE_TARGET)

link_logind.conf:
	rm /etc/systemd/logind.conf
	ln -s logind.conf /etc/systemd/logind.conf

link_i3status_config:
	rm /home/gil/.config/i3status/config
	ln -s i3/config /home/gil/.config/i3status/config

remove_dotfiles:
	rm /home/$(USER)/.xonshrc
	rm /home/$(USER)/.condarc
	rm /home/$(USER)/.doom.d
	rm /home/$(USER)/.xinitrc
	rm /home/$(USER)/.vimrc

link_dotfiles:
	ln -s xonshrc /home/$(USER)/.xonshrc
	ln -s condarc /home/$(USER)/.condarc
	ln -s doom.d /home/$(USER)/.doom.d
	ln -s .xinitrc /home/$(USER)/.xinitrc
	ln -s vimrc /home/$(USER)/.vimrc
