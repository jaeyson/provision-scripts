# Provision scripts

## Packer-specific stuffs

### Creating image snapshot in vultr

```bash
cd vultr/packer

packer validate .

packer build -var-file=secret.pkvars.hcl packer.pkr.hcl
```

output:

```bash
❯ packer build -var-file=secret.pkrvars.hcl packer.pkr.hcl
vultr.base: output will be in this color.

==> vultr.base: Running Vultr builder...
==> vultr.base: Creating temporary SSH key...
==> vultr.base: Creating Vultr instance...
==> vultr.base: Waiting 2700s for server ssssssss-eeee-rrrr-vvvv-eeeeeeeeeeee to power on...
==> vultr.base: Using SSH communicator to connect: 111.111.11.111
==> vultr.base: Waiting for SSH to become available...
==> vultr.base: Connected to SSH!
==> vultr.base: Performing graceful shutdown...
==> vultr.base: Sleeping to ensure that server is shut down...
==> vultr.base: Waiting 2700s for snapshot 00000000-1111-2222-3333-444444444444 to complete...
==> vultr.base: Destroying server ssssssss-eeee-rrrr-vvvv-eeeeeeeeeeee
==> vultr.base: Deleting temporary SSH key...
Build 'vultr.base' finished after 10 minutes 2 seconds.

==> Wait completed after 10 minutes 2 seconds

==> Builds finished. The artifacts of successful builds are:
--> vultr.base: Vultr Snapshot: Packer Base 2025-05-18 14:10:49 (11111111-0000-2222-3333-444444444444)
```

Where `11111111-0000-2222-3333-444444444444` (snapshot id) is the newly created snapshot.

## Terraform-specific stuffs

> [!TIP]
> If you are using snapshots for terraform, use the `snapshot_id`,
> then remove if there's `image_id` in `terraform.tfvars`.

```bash
cd ./vultr/

cp .tfvars.example terraform.tfvars

# idempotency and predictability
terraform plan -out=vultr.tfplan

terraform apply vultr.tfplan
```

## Vultr-specific stuffs

### get ipv4 addr for whitelisting PAT

```bash
curl ifconfig.io

curl ifconfig.me

curl whatsmyip.org
```
