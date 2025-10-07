# 🚀 Web Server Basic - Ubuntu Setup

Automated installation script for running PHP projects on Ubuntu with PHP 8.3, MySQL, and phpMyAdmin.

## ⚡ Quick Start

### Automated Installation

1. Make the script executable:
```bash
chmod +x install-webserver.sh
```

2. Run the installation script:
```bash
./install-webserver.sh
```

---

## 📋 Manual Installation Guide

### 1. 🧰 Install WSL + Ubuntu

Open Command Prompt (CMD) or PowerShell as Administrator and run:

```bash
wsl --install
```

This will automatically install WSL2 and the default Ubuntu version (usually Ubuntu 22.04 LTS). After installation completes, restart your computer. When Ubuntu opens for the first time, create a Linux username and password.

**Check WSL version:**
```bash
wsl --list --verbose
```

**If not using WSL2, upgrade it:**
```bash
wsl --set-version Ubuntu-22.04 2
```

---

### 2. 🌐 Update & Upgrade Ubuntu System

Open Ubuntu terminal (from Start Menu):

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common ca-certificates lsb-release apt-transport-https curl -y
```

---

### 3. 🧪 Install PHP 8.3 + Extensions

Add the ondrej/php repository (official & popular for latest PHP versions):

```bash
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
```

Install PHP 8.3:

```bash
sudo apt install php8.3 php8.3-cli php8.3-common php8.3-mbstring php8.3-xml php8.3-mysql php8.3-curl php8.3-zip php8.3-bcmath php8.3-intl -y
```

**Verify installation:**
```bash
php -v
```

✅ Output should show PHP 8.3.x

---

### 4. 🛢 Install MySQL Server

```bash
sudo apt install mysql-server -y
```

**Start MySQL and enable auto-start:**
```bash
sudo systemctl start mysql
sudo systemctl enable mysql
```

**Secure the installation:**
```bash
sudo mysql_secure_installation
```

Answer the prompts:
- VALIDATE PASSWORD PLUGIN → Choose `n` for local development
- Set root password
- Remove anonymous users → `Y`
- Disallow root login remotely → `Y`
- Remove test database → `Y`
- Reload privileges → `Y`

**Test login:**
```bash
sudo mysql -u root -p
```

---

### 5. 🖥 Install phpMyAdmin

```bash
sudo apt install phpmyadmin -y
```

During installation:
- Select `apache2` when prompted (even if using PHP built-in server)
- Choose `Yes` for dbconfig-common
- Enter MySQL root password when asked

**Create symlink to web directory:**
```bash
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
```

**Access phpMyAdmin:**
- With PHP built-in server or Laravel: `http://localhost:8000/phpmyadmin`
- With Apache: `http://localhost/phpmyadmin`

**Optional - Install Apache:**
```bash
sudo apt install apache2 libapache2-mod-php8.3 -y
sudo systemctl restart apache2
```

---

### 6. 📦 Install Composer

Download installer:
```bash
curl -sS https://getcomposer.org/installer -o composer-setup.php
```

Install globally:
```bash
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

**Verify installation:**
```bash
composer -V
```

✅ Output should display Composer version

---

### 7. 🧰 Install Git & Setup GitHub

**Install Git:**
```bash
sudo apt install git -y
```

**Verify installation:**
```bash
git --version
```

**Configure Git:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your-email@github.com"
```

**Generate SSH Key for GitHub:**
```bash
ssh-keygen -t ed25519 -C "your-email@github.com"
```

Press Enter to use default location: `~/.ssh/id_ed25519`

**Start SSH agent and add key:**
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**Display public key:**
```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the output → Go to GitHub → Settings → SSH and GPG keys → Click "New SSH key" → Paste

**Test connection:**
```bash
ssh -T git@github.com
```

Type `yes` when prompted for the first time.

---

### 8. 🧭 (Optional) Setup Laravel Project

Create and run a new Laravel project:

```bash
composer create-project laravel/laravel myapp
cd myapp
php artisan serve
```

Access your Laravel app at: 👉 http://localhost:8000

---

## 🛠 What's Included

- ✅ PHP 8.3 with essential extensions
- ✅ MySQL Server
- ✅ phpMyAdmin
- ✅ Composer
- ✅ Git with GitHub SSH setup
- ✅ Ready for Laravel development

---

## 📝 Requirements

- Windows 10/11 with WSL2 support
- Ubuntu 22.04 LTS (or compatible version)
- Administrator privileges

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 💡 Troubleshooting

### MySQL won't start
```bash
sudo systemctl status mysql
sudo journalctl -u mysql
```

### phpMyAdmin access denied
Make sure you're using the correct MySQL root password and that the user has proper permissions.

### SSH connection to GitHub fails
Verify your SSH key is added to GitHub and the ssh-agent is running.

--- 

---

Made with ❤️ for PHP developers
