echo "ldap: configuring direct LDAP authentication"

# python-ldap reads TLS trust settings from the system store unless a custom
# CA is supplied.  The CA is public material, so the unprivileged OpenVPN
# authentication hook may read it.
if [ "${LDAP_TLS_CA_CERT}x" != "x" ] ; then
  printf '%s\n' "$LDAP_TLS_CA_CERT" > "$OPENVPN_DIR/ldap-ca.crt"
  chmod 0644 "$OPENVPN_DIR/ldap-ca.crt"
fi
