**Local setup**

- Open git bash sheel
- Change dir to ./environments/dev i.e. `cd environments/dev`
- In order to configure remote storage accound details run command  
   `source test.sh`
- Run `terraform init -upgrade`
- Execute `terraform validate` ( Optional )
- Execute `terraform plan -out main.tfplan`
- Execute `terraform apply main.tfplan`
- Execute `terraform plan -destroy -out main.destroy.tfplan`
- Execute `terraform apply main.destroy.tfplan`

**Github ACtions setup**
