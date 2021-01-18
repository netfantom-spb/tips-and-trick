# Generate root Key file and Certificate file
openssl req -new -x509 -days 3560 -nodes -out ./rootCA/rootCA.crt \
  -keyout ./rootCA/rootCA.key -config root.cnf