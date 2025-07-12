# Deployment steps

## add the necessary creds for packer, ansible & terraform

Things like Vultr API key. Make sure your ipv4 address is allowed in API page.

## create a packer image
Refer readme in packer dir

## run terraform based on snapshot ID and firewall (optional)

Refer readme in terraform dir

## Certbot for HTTPS

Verify if Certbot installs a systemd timer:

```bash
systemctl list-timers | grep certbot
```

Assuming you already have domain name and you pointed it to VPS:

```bash
certbot certonly --standalone -d example.co
```

This generates:

- `/etc/letsencrypt/live/example.co/fullchain.pem`
- `/etc/letsencrypt/live/example.co/privkey.pem`
