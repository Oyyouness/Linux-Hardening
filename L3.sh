# Ensure /tmp is on a separate partition

echo "Creating a separate partition for /tmp..."
dd if=/dev/zero of=/tmp_partition bs=1M count=512
mkfs.ext4 /tmp_partition
mount -o loop /tmp_partition /tmp
echo "/tmp_partition /tmp ext4 loop 0 0" >> /etc/fstab

# Set noexec, nosuid, and nodev options for /tmp

echo "Setting noexec, nosuid, and nodev options for /tmp..."
mount -o remount,noexec,nosuid,nodev /tmp

# Set appropriate permissions for /var/tmp

echo "Setting appropriate permissions for /var/tmp..."
chmod 1777 /var/tmp

# Separate partitions for /home, /var, and /usr

echo "Creating separate partitions for /home, /var, and /usr..."
# We adjust the partition sizes based on our system and requirements
dd if=/dev/zero of=/home_partition bs=1M count=10240
mkfs.ext4 /home_partition
mount -o loop /home_partition /home
echo "/home_partition /home ext4 loop 0 0" >> /etc/fstab

dd if=/dev/zero of=/var_partition bs=1M count=20480
mkfs.ext4 /var_partition
mount -o loop /var_partition /var
echo "/var_partition /var ext4 loop 0 0" >> /etc/fstab

dd if=/dev/zero of=/usr_partition bs=1M count=40960
mkfs.ext4 /usr_partition
mount -o loop /usr_partition /usr
echo "/usr_partition /usr ext4 loop 0 0" >> /etc/fstab


# Disable unnecessary mounts

echo "Disabling unnecessary mounts..."
echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid,nodev 0 0" >> /etc/fstab

# Display a concluding message
echo "ANSSI Disk Partition Hardening measures applied successfully. Reboot the system to activate changes."

