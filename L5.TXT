# Set restrictive permissions on sensitive files and directories

echo "Setting restrictive permissions on sensitive files and directories..."
chmod 600 /etc/shadow
chmod 644 /etc/passwd
chmod 640 /etc/group
chmod 644 /etc/hosts.allow
chmod 644 /etc/hosts.deny
chmod 644 /etc/ssh/sshd_config
chmod 600 /etc/sudoers

# Restrict access to system logs

echo "Restricting access to system logs..."
chmod 640 /var/log/auth.log
chmod 640 /var/log/syslog
chmod 640 /var/log/messages

# Set proper ownership for critical files and directories

echo "Setting proper ownership for critical files and directories..."
chown root:root /etc/passwd
chown root:shadow /etc/shadow
chown root:root /etc/group
chown root:root /etc/hosts.allow
chown root:root /etc/hosts.deny
chown root:root /etc/ssh/sshd_config
chown root:root /etc/sudoers

# Set immutable attribute to critical files

echo "Setting immutable attribute to critical files..."
chattr +i /etc/passwd
chattr +i /etc/shadow
chattr +i /etc/group
chattr +i /etc/hosts.allow
chattr +i /etc/hosts.deny
chattr +i /etc/ssh/sshd_config
chattr +i /etc/sudoers

# Secure sensitive directories

echo "Securing sensitive directories..."
chmod 700 /root
chmod 750 /var/log

# Disable world-writable permissions

echo "Disabling world-writable permissions..."
find / -type d -perm -002 -exec chmod o-w {} \;
find / -type f -perm -002 -exec chmod o-w {} \;

# Set SGID bit on critical directories

echo "Setting SGID bit on critical directories..."
chmod g+s /usr/bin
chmod g+s /usr/sbin
chmod g+s /bin
chmod g+s /sbin

# Display a concluding message
echo "ANSSI File Protection Hardening measures applied successfully."
