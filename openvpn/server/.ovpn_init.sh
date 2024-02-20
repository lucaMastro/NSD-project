PS4='[*] '
set -x

# elimino cartelle CA precedentemente create:
rm -rf /root/CA

# GENERATE CA
# rimuovo precedenti pki
cd /usr/share/easy-rsa
rm -rf pki
./easyrsa init-pki
# nopass serve a non bloccare il certificato con una password
echo "valore usato a lezione: OVPN_NSD_CA\n"
./easyrsa build-ca nopass

# GENERATE SERVER
./easyrsa build-server-full server nopass

# genera parametro diffie-helman
./easyrsa gen-dh

# GENERATE CLIENT
./easyrsa build-client-full end_host_client nopass
./easyrsa build-client-full gw_client nopass

# genero le cartelle per i componenti:
mkdir -p /root/CA/server
mkdir -p /root/CA/end_host_client
mkdir -p /root/CA/gw_client

# copio i certificati e le chiavi
cp /usr/share/easy-rsa/pki/ca.crt /root/CA/
cp /usr/share/easy-rsa/pki/issued/server.crt /root/CA/server/
cp /usr/share/easy-rsa/pki/private/server.key /root/CA/server/
cp /usr/share/easy-rsa/pki/dh.pem /root/CA/server/
cp /usr/share/easy-rsa/pki/issued/end_host_client.crt /root/CA/end_host_client/
cp /usr/share/easy-rsa/pki/private/end_host_client.key /root/CA/end_host_client/
cp /usr/share/easy-rsa/pki/issued/gw_client.crt /root/CA/gw_client/
cp /usr/share/easy-rsa/pki/private/gw_client.key /root/CA/gw_client/


echo "Nota: la distribuzione deve essere fatta a mano: bisogna copiare e incollare"

set +x

