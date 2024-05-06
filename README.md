
## This script generates self-signed SSL certificates for domains.

### Usage

1. Download and run it.
2. Enter the domain name that needs to be signed (wildcards are supported).
3. Press Enter key and done!
```bash
curl -O "https://raw.githubusercontent.com/gnup/self-signed-ssl/main/self-ssl.sh" && bash self-ssl.sh
```

**List of files after running**
```bash
.
├── example.com.crt
├── example.com.csr
├── example.com.key
├── rootCA.crt
├── rootCA.key
├── rootCA.srl
└── self-ssl.sh
```

**Tips**：
1. The [OpenSSL](https://www.openssl.org/) dependency is required.
2. By default, the domain certificate is valid for 365 days and the CA certificate is valid for 1024 days. You can modify these settings in the `self-ssl.sh` file.


### Example

1. Install the domain certificates `example.com.srt`, `example.com.key` into the server (e.g. Nginx).
2. Install `rootCA.crt` in your browser or OS.
3. Connect again `https://example.com/` warning will disappear.

### About

Source page: https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309


