# Backup existing kernel configuration

cp /boot/config-$(uname -r) /boot/config-$(uname -r).bak

# Enable and configure address space layout randomization (ASLR)

echo "CONFIG_RANDOMIZE_BASE=y" >> /usr/src/linux/.config
echo "CONFIG_RANDOMIZE_MODULE_REGION_FULL=y" >> /usr/src/linux/.config

# Set a maximum address space for mmap

echo "CONFIG_DEFAULT_MMAP_MIN_ADDR=65536" >> /usr/src/linux/.config

# Disable support for unnecessary file systems

echo "CONFIG_SQUASHFS=n" >> /usr/src/linux/.config
echo "CONFIG_UDF_FS=n" >> /usr/src/linux/.config
echo "CONFIG_VFAT_FS=n" >> /usr/src/linux/.config
make oldconfig

# Restrict access to kernel logs

chmod 600 /var/log/dmesg
chmod 600 /var/log/kern.log

# Enable process execution prevention

echo "kernel.exec-shield = 1" >> /etc/sysctl.conf
echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
sysctl -p

# Restrict kernel module loading

echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf
echo "install freevxfs /bin/true" > /etc/modprobe.d/freevxfs.conf

# Disable support for legacy 16-bit x86 code

echo "CONFIG_X86_16BIT=y" >> /usr/src/linux/.config


# Check if the script is being run as root

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

echo "Enabling kernel hardening features..."

# Enable Address Space Layout Randomization (ASLR)

echo "kernel.randomize_va_space=2" >> /etc/sysctl.conf
sysctl -p

# Enable ExecShield

echo "kernel.exec-shield=1" >> /etc/sysctl.conf
sysctl -p

# Enable kernel module signing

echo "options modprobe modules.sig_enforce=1" > /etc/modprobe.d/modules.conf

# Enable strict file permissions on kernel modules

chmod 0600 /etc/modprobe.d/modules.conf

# Enable kernel module loading/unloading restrictions

echo "install usb-storage /bin/true" > /etc/modprobe.d/disable-usb-storage.conf

# Enable stricter ptrace security

echo "kernel.yama.ptrace_scope=3" >> /etc/sysctl.conf
sysctl -p

# Set core dumps to a secure location

echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
sysctl -p

# Disable kernel support for some unsafe CPU features

echo "install cramfs /bin/true" > /etc/modprobe.d/disable-cramfs.conf
echo "install freevxfs /bin/true" > /etc/modprobe.d/disable-freevxfs.conf
echo "install jffs2 /bin/true" > /etc/modprobe.d/disable-jffs2.conf
echo "install hfs /bin/true" > /etc/modprobe.d/disable-hfs.conf
echo "install hfsplus /bin/true" > /etc/modprobe.d/disable-hfsplus.conf

# Restrict access to kernel logs

chmod o-rwx /var/log/dmesg
chmod o-rwx /var/log/kern.log

echo "Kernel hardening features enabled."

# Compile and install the new kernel

make && make modules_install && make install

# Display a concluding message

echo "ANSSI Kernel Configuration Hardening applied successfully. Reboot the system to activate changes."


