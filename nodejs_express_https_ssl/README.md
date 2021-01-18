# NodeJS + Express + HTTPS + SSL self-signed

## Create self-signed SSL certificate
### Step 1 - Generate ROOT CA Key and certificate
Edit the **Common Name** (CN) in configuration file **root.cnf**. **Common Name** will be shown as **Issued To** and **Issued By** in cert description.
```
[ req ]
prompt = no
distinguished_name = req_distinguished_name

[ req_distinguished_name ]
#C = RU
#ST = Test State
#L = Test Locality
#O = Org Name
#OU = Org Unit Name
CN = ROOT CA
#emailAddress = test@email.com
```

Then run **create_root_cert_and_key.ssh**
```
$ cd ./keys
$ ./create_root_cert_and_key.sh
Generating a RSA private key
....+++++
.....................................+++++      
writing new private key to './rootCA/rootCA.key'
-----
```

This will the create the root certificate and key, that you have to use during server cetrificate signification. 

Keep safe the rootCA.key file!

### Step 2 - Create self-signed SSL key
Edit the **Common Name** (CN) in configuration file **root.cnf**. **Common Name** will be shown as **Issued To** and **Issued By** in cert description.

```
[ req ]
prompt = no
distinguished_name = req_distinguished_name

[ req_distinguished_name ]
#C = RU
#ST = Test State
#L = Test Locality
#O = Org Name
#OU = Org Unit Name
CN = Test Server Name
#emailAddress = test@email.com
```

Edit IP and/or DNS list in **server.ext**

```
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
#keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage=serverAuth,clientAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = *.localhost
IP.1 = 127.0.0.1
```

Run **create_certificate_for_domain.sh**

```
$ ./create_certificate_for_domain.sh
Generating a RSA private key
.....................................................+++++
......................+++++
writing new private key to './server/server.key'
-----
Signature ok
subject=CN = Test Server Name
Getting CA Private Key
```

## Use server SSL certificates
Copy **server.crt** and **server.key** to target http server and configure it using documentation.

For example for NodeJS server

[src/bin/www](https://github.com/netfantom-spb/tips-and-tricks/blob/main/nodejs_express_https_ssl/src/bin/www)
```
var https = require( "https" );
var fs = require( "fs" );
...
var port = normalizePort(process.env.PORT || '443');
app.set('port', port);

httpsOptions = {
  key: fs.readFileSync("../keys/server/server.key"), 
  cert: fs.readFileSync("../keys/server/server.crt")
};
...
var server = https.createServer(httpsOptions, app);
```

## Add root certificate to the Trusted root certification authorities list
### Windows
Open certification manager from command line `certmgr. msc`
