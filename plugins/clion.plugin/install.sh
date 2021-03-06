#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/clion";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://www.jetbrains.com/clion/download/download_thanks.jsp?os=linux" -O - | grep -o "https://download.jetbrains.com/cpp/clion-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/clion* "/opt/clion"
ln -sf "/opt/clion/bin/clion.sh" "/usr/bin/clion"

xdg-icon-resource install --novendor --size 128 "/opt/clion/bin/clion.svg" "clion"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/clion.desktop
[Desktop Entry]
Name=CLion
Icon=clion
Comment=This powerful IDE helps you develop in C and C++ on Linux
Exec=clion
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;C;C++;IDE;
EOF
