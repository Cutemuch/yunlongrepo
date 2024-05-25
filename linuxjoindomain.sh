#!/bin/bash

# 请将以下变量替换为你的实际域名和管理员用户名
DOMAIN="YOUR_DOMAIN_NAME"
ADMIN_USER="YourAdminUser"

# 安装必要软件包
echo "Installing necessary packages..."
sudo apt update && sudo apt install -y realmd sssd adcli krb5-user packagekit

# 发现域信息
echo "Discovering domain $DOMAIN..."
sudo realm discover "$DOMAIN"

# 加入域
echo "Joining domain $DOMAIN..."
sudo realm join --user="$ADMIN_USER" "$DOMAIN"

# 确认SSSD配置
# 注意：这一部分可能需要根据你的具体需求来调整配置
echo "Confirming SSSD configuration..."
SSSD_CONF_PATH="/etc/sssd/sssd.conf"
if [ -f "$SSSD_CONF_PATH" ]; then
    sudo bash -c "cat > $SSSD_CONF_PATH" <<EOF
[sssd]
services = nss, pam
config_file_version = 2
domains = $DOMAIN

[domain/$DOMAIN]
id_provider = ad
access_provider = ad
EOF
else
    echo "Error: The sssd.conf file does not exist. Please check your installation."
    exit 1
fi

# 更新PAM和NSS（通常由SSSD自动处理）

# 启用创建家目录
echo "Enabling mkhomedir for domain users..."
sudo pam-auth-update --enable mkhomedir

# 重启SSSD服务
echo "Restarting SSSD service..."
sudo systemctl restart sssd

# 显示加入域的状态
echo "Displaying domain join status..."
realm list

# 提示完成
echo "The script has completed. Please verify the domain join status above and attempt to log in with a domain account."

