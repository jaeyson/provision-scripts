> [!TIP]
> If you are using snapshots for terraform, use the `snapshot_id`,
> then remove if there's `image_id` in `terraform.tfvars`.

```bash
cd ./vultr/terraform

cp terraform.tfvars.example terraform.tfvars

terraform init

terraform validate

# idempotency and predictability
terraform plan -out=vultr.tfplan

terraform apply vultr.tfplan
```
