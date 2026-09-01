AUTH_CACHE_DIR="${OPENVPN_DIR}/auth-cache"
AUTH_CACHE_KEY="${OPENVPN_DIR}/auth-cache.key"

echo "auth-cache: preparing disk cache"

install -d -o nobody -g nogroup -m 0700 "$AUTH_CACHE_DIR"

if [ ! -f "$AUTH_CACHE_KEY" ]; then
  umask 077
  openssl rand -hex 32 > "$AUTH_CACHE_KEY"
fi

chown nobody:nogroup "$AUTH_CACHE_KEY"
chmod 0600 "$AUTH_CACHE_KEY"
