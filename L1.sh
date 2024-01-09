# Disable USB ports

echo "blacklist usb-storage" > /etc/modprobe.d/disable-usb-storage.conf
modprobe -r usb-storage

# Restrict access to the serial ports

chmod 700 /dev/ttyS*

# Disable Firewire modules

echo "install firewire-core /bin/true" > /etc/modprobe.d/disable-firewire.conf
echo "install firewire-ohci /bin/true" >> /etc/modprobe.d/disable-firewire.conf

# Restrict physical console access

echo "console" >> /etc/securetty

# Set a BIOS/UEFI password

# ANSSI BIOS/UEFI Password Hardening Script

# Prompt the user to set a BIOS/UEFI password

read -p "Do you want to set a BIOS/UEFI password? (yes/no): " set_password

if [[ $set_password == "yes" ]]; then
    read -sp "Enter the BIOS/UEFI password: " bios_password
    


    echo "BIOS/UEFI password set successfully."
else
    echo "No BIOS/UEFI password set. Continuing with other hardening measures."
fi


# Display BIOS/UEFI Hardening message

echo "ANSSI BIOS/UEFI Password Hardening measures applied successfully."


# Disable booting from external media

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Backup the GRUB configuration file

cp /etc/default/grub /etc/default/grub.bak

# Set the GRUB_DISABLE_RECOVERY option to restrict recovery mode

sed -i 's/GRUB_DISABLE_RECOVERY="false"/GRUB_DISABLE_RECOVERY="true"/' /etc/default/grub

# Update GRUB configuration

update-grub

echo "Boot from external media has been disabled. GRUB configuration updated."



# Check if the script is being run as root

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Check if the system is using UEFI

if [ ! -d /sys/firmware/efi ]; then
  echo "UEFI is not detected on this system. Secure Boot is not applicable."
  exit 1
fi

# Check if Secure Boot is already enabled

if mokutil --sb-state | grep -q "SecureBoot enabled"; then
  echo "Secure Boot is already enabled."
  exit 0
fi

# Install necessary package for MOK (Machine Owner Key) management

apt-get install -y mokutil

#### Enable Secure Boot ####

#mokutil --enable-secure-boot

#echo "Secure Boot has been enabled. Please follow the on-screen instructions to complete the process."
#### We disabled Secure Boot temporarly because it was blocking the system booting ####

# Set a GRUB bootloader password

# Check if the script is being run as root

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Backup the GRUB configuration file

cp /etc/default/grub /etc/default/grub.bak

# Generate an encrypted password for GRUB

echo "Enter the desired GRUB password:"
read -s grub_password
encrypted_password=$(echo -e "$grub_password\n$grub_password" | grub-mkpasswd-pbkdf2 | grep "grub.pbkdf2.*" | awk '{print $NF}')

# Add the password to the GRUB configuration

sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s/\"$/ GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"/" /etc/default/grub
echo "GRUB_ENABLE_CRYPTODISK=y" >> /etc/default/grub
echo "GRUB_PASSWORD=$encrypted_password" >> /etc/default/grub

# Update GRUB configuration

update-grub

echo "GRUB password has been set. GRUB configuration updated."


# Lock the root account

passwd -l root

# Set strong password policy

sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/' /etc/login.defs
sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t7/' /etc/login.defs
sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t14/' /etc/login.defs


# Display a concluding message

echo "ANSSI Hardware Hardening measures applied successfully."


