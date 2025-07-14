# Deployment steps

> [!NOTE]
> `deploy.yml.bak` is already written, you just have to rename it in
> order for the runner to pick up the workflow.

A bare-bones guide on simple CI/CD

Some parts we're done manually, because we're starting of making immutable images,
then using terraform/ansible for provision/configs.

So the part where we do manual edits is:
- enable HTTPS on a domain using certbot
- auto-renew hooks
- set ownerships for cert files

## add the necessary creds for packer, ansible & terraform

Things like Vultr API key, snapshot id, plan, region, etc. Make
sure your ipv4 address is allowed in API page. Also, add the
`secrets.HOST` and `secrets.PASSWORD` in github repo secrets.

source: https://github.com/<ORG_OR_USERNAME>//settings/secrets/actions/new

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
certbot certonly --standalone -d test.domain.co
```

This generates:

- `/etc/letsencrypt/live/test.domain.co/fullchain.pem`
- `/etc/letsencrypt/live/test.domain.co/privkey.pem`

Enable auto-renew certs with hooks

```bash
# verify certbot systemd timer
systemctl list-timers | grep certbot

mkdir -p /etc/letsencrypt/renewal-hooks/deploy
vim /etc/letsencrypt/renewal-hooks/deploy/restart-actix.sh
```

then write

```bash
#!/bin/bash
systemctl restart web_app.service
```

and make it executable

```bash
chmod +x /etc/letsencrypt/renewal-hooks/deploy/restart-actix.sh
```

Also set ownerships to those files

```bash
chown root:sslreaders /etc/letsencrypt/archive/test.domain.co/*.pem
chmod 640 /etc/letsencrypt/archive/test.domain.co/*.pem
```

Automate permissions on cert renewal

```bash
vim /etc/letsencrypt/renewal-hooks/deploy/ssl-perms.sh
```

then write

```bash
#!/bin/bash
chown root:sslreaders /etc/letsencrypt/archive/test.domain.co/*.pem
chmod 640 /etc/letsencrypt/archive/test.domain.co/*.pem
```

and make it executable

```bash
chmod +x /etc/letsencrypt/renewal-hooks/deploy/ssl-perms.sh
```

You could run these as steps if you want it to be automated:

```yaml
steps:
  - name: Check if service is enabled
    id: check_service
    run: |
      status=$(systemctl is-enabled web_app.service || echo 'disabled')
      echo "Service status: $status"
      echo "service_status=$status" >> $GITHUB_OUTPUT
  - name: Enable service if not enabled
    if: ${{ steps.check_service.outputs.service_status != 'enabled' }}
    run: |
      sudo systemctl enable web_app.service
      echo "Service has been enabled."
```

Otherwise run the command manually:

```bash
systemctl enable web_app.service
```
