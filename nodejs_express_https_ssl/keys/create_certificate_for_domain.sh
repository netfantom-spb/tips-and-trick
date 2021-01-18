# Generate server Key file and Certificate Signing Request file
openssl req -new -newkey rsa:2048 -sha256 -nodes \
    -keyout ./server/server.key -out ./server/server.csr -config server.cnf
# -subj="/CN=127.0.0.1"    
# Generate Key file and Certificate file
openssl x509 -req -in ./server/server.csr -CA ./rootCA/rootCA.crt \
    -CAkey ./rootCA/rootCA.key -CAcreateserial -out ./server/server.crt -days 3650 -sha256 -extfile ./server.ext
rm ./server/server.csr ./rootCA/rootCA.srl