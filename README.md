# web-server-basic
Basic auto install for runing php project on Ubuntu (Php, Mysql, PhpMyAdmin)

1. Jadikan file bisa dieksekusi:
   <code>chmod +x install-webserver.sh</code>

2. Jalankan script:
   <code>./install-webserver.sh</code>

Manual Installation :

<ol>
   <li> 🧰 Install WSL + Ubuntu</li>
   
   Buka Command Prompt (CMD) atau PowerShell sebagai Administrator.
   Jalankan:
   
   <code>wsl --install</code>
   
   Ini akan otomatis menginstal WSL2 dan Ubuntu versi default (biasanya Ubuntu 22.04 LTS). Setelah instalasi selesai, restart komputer. Saat Ubuntu terbuka pertama kali, buat username dan password Linux.
   
   ✅ Cek versi WSL:
   
   <code>wsl --list --verbose</code>
   
   Jika belum WSL2:
   
   <code>wsl --set-version Ubuntu-22.04 2</code>
   
   <li> 🌐 Update & Upgrade Sistem Ubuntu</li>
   
   Buka terminal Ubuntu (dari Start Menu):
   
   
   <code>sudo apt update && sudo apt upgrade -y</code>
   <code>sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https curl -y</code>
   
   <li> 🧪 Install PHP 8.3 + Extensions</li>
   Tambahkan repository ondrej/php (resmi & populer untuk versi PHP terbaru): 
   <code>sudo add-apt-repository ppa:ondrej/php -y</code>
   <code>sudo apt update</code>
   
   
   Install PHP 8.3:
   <code>sudo apt install php8.3 php8.3-cli php8.3-common php8.3-mbstring php8.3-xml php8.3-mysql php8.3-curl php8.3-zip php8.3-bcmath php8.3-intl -y</code>
   
   Cek versi:
   
   <code>php -v</code>
   
   
   ✅ Output harus menunjukkan PHP 8.3.x
   
   <li> 🛢 Install MySQL Server</li>
   <code>sudo apt install mysql-server -y</code>
   Jalankan MySQL dan aktifkan auto-start:
   <code>sudo systemctl start mysql<code>
   <code>sudo systemctl enable mysql</code>
   Amankan instalasi:
   <code>sudo mysql_secure_installation</code>
   Jawab pertanyaan dengan:
   
   VALIDATE PASSWORD PLUGIN → boleh pilih n jika untuk lokal.
   
   Set root password
   
   Hapus user anonymous → Y
   Disallow root login remotely → Y
   Hapus test database → Y
   Reload privilege → Y
   Login untuk tes:
   <code>sudo mysql -u root -p</code>
   
   <li> 🖥 Install phpMyAdmin</li>
   <code>sudo apt install phpmyadmin -y</code>   
   Saat prompt pilih apache2, walau kita pakai CLI (tidak masalah, karena phpMyAdmin akan terinstal di /usr/share/phpmyadmin)
   Pilih Yes untuk dbconfig-common
   Masukkan password MySQL root saat diminta.
   Integrasikan ke PHP built-in / Laravel:
   Buat symlink ke /var/www/html:
   <code>sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin</code>
   Jika pakai PHP built-in server atau Laravel php artisan serve, cukup arahkan ke:
   👉 http://localhost:8000/phpmyadmin (setelah serve)
   Atau jika ingin pakai Apache:
   
   <code>sudo apt install apache2 libapache2-mod-php8.3 -y</code>
   <code>sudo systemctl restart apache2</code>
   
   
   Lalu akses:
   👉 http://localhost/phpmyadmin
   
   <li> 📦 Install Composer</li>
   Download installer:
   
   <code>curl -sS https://getcomposer.org/installer -o composer-setup.php</code>
   
   Install secara global:
   <code>sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer</code>

   Cek versi:
   
   <code>composer -V</code>
   
   
   ✅ Output harus menampilkan Composer version ...
   
   <li> 🧰 Install Git & Setup GitHub </li>
   Install Git:
   <code>sudo apt install git -y</code>
   Cek:
   <code>git --version
   
   Konfigurasi nama & email:
   
   <code>git config --global user.name "Nama Kamu"</code>
   <code>git config --global user.email "email@github.com"</code>
   
   Buat SSH Key untuk GitHub:
   
   <code>ssh-keygen -t ed25519 -C "email@github.com"</code>
   
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
   
   <li> 🧭 (Optional) Setup Laravel Project</li>
   
   Jika kamu ingin langsung jalanin project Laravel:
   
   <code>composer create-project laravel/laravel myapp</code>
   <code>cd myapp</code>
   <code>php artisan serve</code>
      
   Akses: 👉 http://localhost:8000

</ol> 
