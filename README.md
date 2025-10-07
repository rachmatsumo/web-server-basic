# web-server-basic
Basic auto install for runing php project on Ubuntu (Php, Mysql, PhpMyAdmin)

1. Jadikan file bisa dieksekusi:
   <script>chmod +x install-webserver.sh</script>

2. Jalankan script:
   <script>./install-webserver.sh</script>

Manual Installation :

🧰 1. Install WSL + Ubuntu

Buka Command Prompt (CMD) atau PowerShell sebagai Administrator.
Jalankan:

<script>wsl --install</script>

Ini akan otomatis menginstal WSL2 dan Ubuntu versi default (biasanya Ubuntu 22.04 LTS). Setelah instalasi selesai, restart komputer. Saat Ubuntu terbuka pertama kali, buat username dan password Linux.

✅ Cek versi WSL:

<script>wsl --list --verbose</script>

Jika belum WSL2:

<script>wsl --set-version Ubuntu-22.04 2</script>

🌐 2. Update & Upgrade Sistem Ubuntu

Buka terminal Ubuntu (dari Start Menu):

<script>
sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https curl -y
</script>

🧪 3. Install PHP 8.3 + Extensions
Tambahkan repository ondrej/php (resmi & populer untuk versi PHP terbaru):
<script>
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
</script>


Install PHP 8.3:
<script>
  sudo apt install php8.3 php8.3-cli php8.3-common php8.3-mbstring php8.3-xml php8.3-mysql php8.3-curl php8.3-zip php8.3-bcmath php8.3-intl -y
</script>

Cek versi:

php -v


✅ Output harus menunjukkan PHP 8.3.x

🛢 4. Install MySQL Server
sudo apt install mysql-server -y


Jalankan MySQL dan aktifkan auto-start:

sudo systemctl start mysql
sudo systemctl enable mysql


Amankan instalasi:

sudo mysql_secure_installation


Jawab pertanyaan dengan:

VALIDATE PASSWORD PLUGIN → boleh pilih n jika untuk lokal.

Set root password

Hapus user anonymous → Y

Disallow root login remotely → Y

Hapus test database → Y

Reload privilege → Y

Login untuk tes:

sudo mysql -u root -p

🖥 5. Install phpMyAdmin
sudo apt install phpmyadmin -y


Saat prompt pilih apache2, walau kita pakai CLI (tidak masalah, karena phpMyAdmin akan terinstal di /usr/share/phpmyadmin)

Pilih Yes untuk dbconfig-common

Masukkan password MySQL root saat diminta.

Integrasikan ke PHP built-in / Laravel:
Buat symlink ke /var/www/html:

sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin


Jika pakai PHP built-in server atau Laravel php artisan serve, cukup arahkan ke:
👉 http://localhost:8000/phpmyadmin (setelah serve)

Atau jika ingin pakai Apache:

sudo apt install apache2 libapache2-mod-php8.3 -y
sudo systemctl restart apache2


Lalu akses:
👉 http://localhost/phpmyadmin

📦 6. Install Composer

Download installer:

curl -sS https://getcomposer.org/installer -o composer-setup.php


Install secara global:

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer


Cek versi:

composer -V


✅ Output harus menampilkan Composer version ...

🧰 7. Install Git & Setup GitHub

Install Git:

sudo apt install git -y


Cek:

git --version


Konfigurasi nama & email:

git config --global user.name "Nama Kamu"
git config --global user.email "email@github.com"


Buat SSH Key untuk GitHub:

ssh-keygen -t ed25519 -C "email@github.com"


Tekan Enter saja saat diminta lokasi → pakai default ~/.ssh/id_ed25519

Jalankan agent & tambah key:

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519


Tampilkan public key untuk ditambahkan ke GitHub:

cat ~/.ssh/id_ed25519.pub


Salin hasilnya → masuk ke GitHub → Settings → SSH and GPG keys
 → klik New SSH key → paste.

Tes koneksi:

ssh -T git@github.com


Jawab yes saat pertama kali.

🧭 8. (Optional) Setup Laravel Project

Jika kamu ingin langsung jalanin project Laravel:

composer create-project laravel/laravel myapp
cd myapp
php artisan serve


Akses: 👉 http://localhost:8000

✅ Ringkasan
Komponen	Status
WSL Ubuntu	✅ Terinstal
PHP 8.3	✅ Terinstal
MySQL	✅ Terinstal
phpMyAdmin	✅ Terinstal
Composer	✅ Terinstal
GitHub (SSH)	✅ Terhubung
