# OpenSuse Tumbleweed Hyprland Setup -

Bare minimum hyprland setup script for `OpenSuse Tumbleweed KDE Plasma DE`, user needs to configure everything at his own and install more packages as per his taste and confg.

>Note -
>
>1. Take backup using snapper/timeshift before installing, no uninstallation script.
>2. This is minimum setup script with no configs (everything is default)
>3. Work in progress

## Setup -

Clone the repo and launch `setup.sh` script

```bash
git clone --depth=1 https://github.com/aDifferentBook/opensuse-hyprland.git
cd opensuse-tw-hyprland-setup
chmod +x setup.sh
./setup.sh
```

## Mannual  setup -

1. Enable packman repo -
Enable packman repo if already move to next step

```bash
# Update system
sudo zypper refresh
sudo zypper dist-upgrade -y

# Add packman repository
# https://en.opensuse.org/Additional_package_repositories
echo -e "${green}Adding packman repo${yellow}${1}${normal}"
sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman
sudo zypper dup --from packman --allow-vendor-change
sudo zypper refresh
```

2. Install necessary packages -

```bash
# Install hyprland
sudo zypper install -y hyprland hyprpaper waybar SwayNotificationCenter rofi-wayland NetworkManager-applet xwayland kitty
```

3. Copy default config files -

```bash
# hyprland config
mkdir -p ~/.config/hypr
cd ~/.config/hypr
curl -o hyprland.conf https://raw.githubusercontent.com/hyprwm/Hyprland/main/example/hyprland.conf

# waybar config
mkdir -p ~/.config/waybar
cp /etc/xdg/waybar/config/* ~/.config/waybar/
```

4. Basic settings -

- hyprland config - Open `~/.config/hypr/hyprland.conf` file and do following changes.

```bash
# PolicyKit
# OpenSuse Tumbleweed
exec-once = /usr/libexec/polkit-kde-authentication-agent-1 & waybar
```

- waybar config - Open `~/.config/waybar/config` and uncomment/remove `//` from the following line

```json
//"layer": "top", // Waybar at top layer

Above line should look like below one

"layer": "top", // Waybar at top layer
```

1. Install ZSH Shell -

```bash
# Install packages
sudo dnf install -y zsh powerline-fonts

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

5. Reboot system and choose `HYPRLAND` in login manager/SDDM.

```bash
# Reboot
systemctl reboot
```
