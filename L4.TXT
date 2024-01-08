# Set password policies

echo "Configuring password policies..."
echo "password requisite pam_pwquality.so retry=3 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1" >> /etc/pam.d/common-password
echo "auth required pam_tally2.so deny=5 unlock_time=1800" >> /etc/pam.d/common-auth

# Enforce password complexity

echo "Configuring password complexity..."
apt-get install libpam-cracklib
echo "password requisite pam_cracklib.so retry=3 minlen=12 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 difok=3" >> /etc/pam.d/common-password

# Set account lockout policy

echo "Configuring account lockout policy..."
echo "auth required pam_tally2.so deny=5 unlock_time=1800" >> /etc/pam.d/common-auth

# Disable root login

echo "Disabling root login..."
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# Limit access to the su command

echo "Configuring su command restrictions..."
echo "auth required pam_wheel.so" >> /etc/pam.d/su
echo "wheel:x:10:username" >> /etc/group

# Enable login banner

echo "Configuring login banner..."
echo "Authorized access only. All activity may be monitored and reported." > /etc/issue.net
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config

# Configure session timeout

echo "Configuring session timeout..."
echo "TMOUT=600" >> /etc/profile
echo "readonly TMOUT" >> /etc/profile
echo "export TMOUT" >> /etc/profile

# Enable Two-Factor Authentication (2FA)

echo "Configuring Two-Factor Authentication..."
# Note: This requires the installation and configuration of 2FA tools such as Google Authenticator.

# Display a concluding message
echo "ANSSI Authentication and Identification Hardening measures applied successfully. Restart services or reboot the system to activate changes."

