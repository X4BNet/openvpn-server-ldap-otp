# The OpenVPN process drops to nobody before it runs the direct
# authentication hook.  Keep TOTP seeds readable only by that account.
if [ "$ENABLE_OTP" == "true" ]; then
  echo "otp: preparing local TOTP state"
  install -d -o nobody -g nogroup -m 0700 /etc/openvpn/otp
  find /etc/openvpn/otp -maxdepth 1 -type f -name '*.google_authenticator' -exec chown nobody:nogroup {} \; -exec chmod 0600 {} \;
else
  echo "otp: disabled"
fi
