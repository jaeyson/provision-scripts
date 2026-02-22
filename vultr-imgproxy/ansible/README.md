> [!IMPORTANT]
> This is being used as provisioner for packer image

> [!WARNING]
> Only run the playbook manually if you know what you're doing

This playbook is to be ran on user's machine (e.g. from mac to remote servers)

```bash
ansible-galaxy install -r requirements.yml

# use this if you need vault
ansible-vault create group_vars/all/vault.yml

# no vault
ansible-playbook -i hosts.ini playbook.yml

# vault
ansible-playbook playbook.yml --ask-vault-pass
```
