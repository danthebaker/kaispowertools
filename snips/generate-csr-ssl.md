# generate csr for ssl certs

```
$ openssl req -x509 -nodes -newkey rsa:2048 -keyout key.pem -out cert.pem
```

http://www.thegeekstuff.com/2009/07/linux-apache-mod-ssl-generate-key-csr-crt-file/