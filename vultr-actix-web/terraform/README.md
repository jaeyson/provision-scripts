```bash
cd ./vultr-actix-web/terraform

cp terraform.tfvars.example terraform.tfvars

# idempotency and predictability
terraform plan -out=vultr.tfplan

terraform apply vultr.tfplan
```
