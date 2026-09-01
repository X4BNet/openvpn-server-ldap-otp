AUTH_CACHE_DIR="${OPENVPN_DIR}/auth-cache"
AUTH_CACHE_KEY="${OPENVPN_DIR}/auth-cache.key"

echo "auth-cache: preparing disk cache"

# OpenVPN drops to nobody before it invokes authenticate-user.  Permit that
# account to traverse the persistent volume without making its contents
# listable; the cache, key, and OTP directories retain their own strict modes.
chmod o+x "$OPENVPN_DIR"
install -d -o nobody -g nogroup -m 0700 "$AUTH_CACHE_DIR"

if [ ! -f "$AUTH_CACHE_KEY" ]; then
  umask 077
  openssl rand -hex 32 > "$AUTH_CACHE_KEY"
fi

chown nobody:nogroup "$AUTH_CACHE_KEY"
chmod 0600 "$AUTH_CACHE_KEY"
