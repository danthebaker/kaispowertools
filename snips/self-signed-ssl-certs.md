# create self signed ssl cert

```
$ openssl req -x509 -nodes -newkey rsa:2048 -keyout key.pem -out cert.pem
```

http://stackoverflow.com/questions/10175812/how-to-build-a-self-signed-certificate-with-openssl