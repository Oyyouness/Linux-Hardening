# Disable unused network services

echo "Disabling unused network services..."
systemctl disable avahi-daemon
systemctl disable cups
systemctl disable nfs
systemctl disable rpcbind
systemctl disable postfix
systemctl disable bluetooth
systemctl disable apache2

# Enable and configure firewall (iptables or nftables)

echo "Configuring firewall rules..."

# In our work, we allowed SSH and blocked everything else, it all depends on the rules you want to set:

iptables -P INPUT DROP
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Enable SYN flood protection

echo "Enabling SYN flood protection..."
sysctl -w net.ipv4.tcp_syncookies=1

# Disable IP forwarding

echo "Disabling IP forwarding..."
sysctl -w net.ipv4.ip_forward=0

# Disable ICMP Redirects

echo "Disabling ICMP Redirects..."
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0

# Disable source routing

echo "Disabling source routing..."
sysctl -w net.ipv4.conf.all.accept_source_route=0
sysctl -w net.ipv4.conf.default.accept_source_route=0

# Enable ARP protection

echo "Enabling ARP protection..."
sysctl -w net.ipv4.conf.all.arp_ignore=1
sysctl -w net.ipv4.conf.default.arp_ignore=1
sysctl -w net.ipv4.conf.all.arp_announce=2
sysctl -w net.ipv4.conf.default.arp_announce=2

# Disable IPv6 if not needed

echo "Disabling IPv6..."
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

# Display a concluding message
echo "ANSSI Network Hardening measures applied successfully."
