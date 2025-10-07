#!/usr/bin/env bash

set -e

echo "=============================="
echo " 🚀 SETUP LINGKUNGAN LARAVEL"
echo " Ubuntu + PHP 8.3 + MySQL + phpMyAdmin + Composer + Git"
echo "=============================="

# 1️⃣ Update dan install dependencies dasar
echo "🔸 Update & install dependencies..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common ca-certificates lsb-release apt-transport-https curl unzip zip git

# 2️⃣ Install PHP 8.3
echo "🔸 Install PHP 8.3 dan ekstensi..."
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php8.3 php8.3-cli php8.3-common php8.3-mbstring php8.3-xml php8.3-mysql php8.3-curl php8.3-zip php8.3-bcmath php8.3-intl

php -v

# 3️⃣ Install MySQL
echo "🔸 Install MySQL Server..."
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql

# Jalankan secure installation otomatis tanpa interaktif (default aman)
echo "🔸 Konfigurasi MySQL Secure Installation..."
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES;"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE IF EXISTS test;"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# 4️⃣ Install phpMyAdmin
echo "🔸 Install phpMyAdmin..."
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password root" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password root" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password root" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
sudo apt install -y phpmyadmin

# Buat symlink ke /var/www/html
if [ ! -L "/var/www/html/phpmyadmin" ]; then
    sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
fi

# 5️⃣ Install Apache (optional untuk phpMyAdmin)
echo "🔸 Install Apache2 untuk akses phpMyAdmin..."
sudo apt install -y apache2 libapache2-mod-php8.3
sudo systemctl restart apache2

# 6️⃣ Install Composer
echo "🔸 Install Composer..."
EXPECTED_SIGNATURE="$(curl -s https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
    >&2 echo 'ERROR: Invalid composer installer signature'
    rm composer-setup.php
    exit 1
fi

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php
composer -V

# 7️⃣ Konfigurasi Git & SSH GitHub
echo "🔸 Install Git dan setup SSH..."
git --version || sudo apt install -y git

read -p "Masukkan nama Git Anda: " GIT_NAME
read -p "Masukkan email GitHub Anda: " GIT_EMAIL

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# Generate SSH key jika belum ada
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f ~/.ssh/id_ed25519 -N ""
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi

echo "=============================="
echo "📝 Public key SSH GitHub Anda:"
echo "=============================="
cat ~/.ssh/id_ed25519.pub
echo "=============================="
echo "👉 Salin key di atas dan tambahkan ke GitHub:"
echo "   https://github.com/settings/keys"
echo "=============================="

# 8️⃣ Info akhir
echo "✅ Instalasi Selesai!"
echo "🌐 phpMyAdmin: http://localhost/phpmyadmin"
echo "🧰 MySQL Root User: root | Password: root"
echo "📝 Jalankan project Laravel dengan: composer create-project laravel/laravel myapp"
