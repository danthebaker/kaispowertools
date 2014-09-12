## ssl cert

1. signup / login to somewhere (https://www.ssls.com) as buy the cert
2. generate CSR

```bash
$ openssl req -new -newkey rsa:2048 -nodes -keyout bigstack.key -out bigstack.csr
```