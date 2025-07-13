```bash
packer init .

packer validate -var-file=secret.pkrvars.hcl .

packer build -var-file=secret.pkvars.hcl packer.pkr.hcl
```