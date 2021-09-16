# Terraform Blue Green deployment

[Diagram Presentation](https://lucid.app/lucidchart/invitations/accept/inv_01366e3b-f1c7-4736-b16b-cfe37c638506?viewport_loc=-480%2C-584%2C1600%2C1596%2C0_0)

This is a simple test repo of an idea on how to create a blue green deployment implementation for terraform. 

For this to work all of the work being done needs to happen inside of a module that can then be called at the root. This allows you to call the module for blue or green or both. 

possible run options supported: 

- `terraform apply` - this will deploy or modify the blue resources only. Green resources will be destroyed if this is run.
- `terraform apply -var green_enabled=true -target=module.green` - this will deploy or modify the green resources and not modify anything with the blue resources. This should be used to deploy your current changes without impacting the currently running (blue) resources. 
- `terraform apply -var green_enabled=true` - this will deploy or modify both blue and green resources. This is primarily intended to bring the blue resources to match the green resources.

The full process to roll out changes using blue/green would be the following:


```shell
# this is the initial deployment
terraform apply 

# release current changes to green instance
terraform apply -var green_enabled=true -target=module.green

# once green is up and validated, update blue to match green
terraform apply -var green_enabled=true

# once blue is back up and validated tear down blue by running an apply again without the green_enabled
terraform apply
```
