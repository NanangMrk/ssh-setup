# SSH CONFIG MRK 🚀

Simple Ubuntu SSH configuration script for enabling Root Login and Password Authentication.

Created for VPS deployment, remote administration, and quick server setup.

---

## ✨ Features

* Enable SSH Root Login
* Enable Password Authentication
* Backup existing SSH configuration
* Restart SSH service automatically
* One-command installation
* Supports Ubuntu 20.04, 22.04, and 24.04

---

## 📋 Requirements

* Ubuntu 20.04 / 22.04 / 24.04
* Root access
* Internet connection

---

## 📥 Installation

### One-Line Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/NanangMrk/ssh-setup/master/install.sh)"
```

### Manual Install

```bash
git clone https://github.com/NanangMrk/ssh-setup.git
cd ssh-setup
chmod +x install.sh
sudo ./install.sh
```

---

## ⚙️ What This Script Does

Updates package repository:

```bash
apt update
```

Enables SSH Root Login:

```text
PermitRootLogin yes
```

Enables Password Authentication:

```text
PasswordAuthentication yes
```

Restarts SSH service:

```bash
systemctl restart ssh
```

---

## 📂 Backup

Before making changes, the script automatically creates:

```text
/etc/ssh/sshd_config.bak
```

Restore backup:

```bash
cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
systemctl restart ssh
```

---

## ⚠️ Security Notice

This script enables direct root login through SSH.

For production servers, it is recommended to:

* Change the root password immediately
* Use a strong password
* Restrict SSH access with a firewall
* Install Fail2Ban
* Change the default SSH port

---

## 🖥️ Tested On

| Ubuntu Version | Status |
| -------------- | ------ |
| Ubuntu 20.04   | ✅      |
| Ubuntu 22.04   | ✅      |
| Ubuntu 24.04   | ✅      |

---

## 👨‍💻 Author

**NanangMrk**

GitHub Repository:

https://github.com/NanangMrk/ssh-setup

---

## ⭐ Support

If this project helps you, please give it a star on GitHub.
