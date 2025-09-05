#!/bin/sh

sudo dnf copr enable solopasha/hyprland

sudo dnf update

sudo dnf install meson ninja-build wayland-devel wayland-protocols-devel gtk4-devel gobject-introspection gobject-introspection-devel gtk-doc python3 vala valadoc tar cliphist python python-gobject python-pam gtk4 gtk4-devel gtk4 dbus dbus-glib dbus-devel python-pillow cairo cairo-devel NetworkManager-libnm NetworkManager-libnm-devel python-cython upower upower-devel python-pywayland python-pywayland xdg-dbus-proxy xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils polkit greetd python-cairo NetworkManager xdg-desktop-portal-hyprland hyprpicker hyprsunset hyprland-git hyprshot cliphist python-pip wireplumber-devel git python-devel adw-gtk3-theme

git clone https://github.com/wmww/gtk4-layer-shell

cd gtk4-layer-shell

meson setup -Dexamples=true -Ddocs=true -Dtests=true build
ninja -C build
sudo ninja -C build install
sudo ldconfig

wget https://github.com/sass/dart-sass/releases/download/1.92.0/dart-sass-1.92.0-linux-x64.tar.gz

sudo tar xvf dart-sass* -C /opt/

echo 'export PATH="/opt/dart-sass:$PATH"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export GI_TYPELIB_PATH=/usr/local/lib64/girepository-1.0:$GI_TYPELIB_PATH' >> ~/.bashrc
echo 'export GI_EXTRA_PATH=/usr/local/share/gir-1.0:$GI_EXTRA_PATH' >> ~/.bashrc
source ~/.bashrc

pip3 install materialyoucolor --upgrade

git clone https://github.com/aylur/astal.git
cd astal/lib/bluetooth
meson setup build
meson install -C build

cd ../wireplumber
meson setup build
meson install -C build

cd ../network
meson setup build
meson install -C build

cd ../../../

cd material-symbols
sudo cp * /usr/share/fonts/
cd ../

git clone --depth=1 https://github.com/koeqaife/hyprland-material-you.git
cd hyprland-material-you/hypryou/
./build.sh
cd ..
sudo cp hypryou/ /usr/lib/hypryou/ -r
sudo cp hypryou-assets/ /usr/share/hypryou/ -r
cd build
./build.sh
sudo cp hypryouctl /usr/bin/
sudo cp hypryou-start /usr/bin/
sudo cp hypryou-crash-dialog /usr/bin/
cd ..
sudo cp assets/hypryou.desktop /usr/share/wayland-sessions/
cd hypryou-utils/
gcc "hyprland-dialog.c" -o hyprland-dialog $(pkg-config --cflags --libs gtk4) \
        -Wall -Wextra -Wpedantic -Wshadow -Wformat=2 -Wcast-align -Wconversion -Wstrict-overflow=5 -O2
sudo cp hyprland-dialog /usr/bin/hyprland-dialog
cd ../greeter
sudo cp config.toml /usr/share/hypryou-greeter/config.toml
sudo useradd -M -G video greeter
sudo mkdir -p /home/greeter
sudo chown greeter:greeter /home/greeter
sudo chown greeter:greeter /etc/greetd/
sudo chmod 700 /home/greeter
sudo usermod -d /home/greeter greeter 2>/dev/null || true
sudo cp /usr/share/hypryou-greeter/config.toml /etc/greetd/config.toml
sudo systemctl enable greetd.service

git clone https://github.com/vinceliuice/Tela-circle-icon-theme
cd Tela-circle-icon-theme

./install.sh nord
