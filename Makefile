DOCKER_CMD=docker-compose run --rm

#
###### ANSIBLE ######
#

ANSIBLE_COMP_CMD=$(DOCKER_CMD) ansible
ANSIBLE_INVENTORY=-i inventory/k8s_cluster.sh -i inventory/executers.yml
ANSIBLE_ENTRY_PB=site.yml
ANSIBLE_CMD=$(ANSIBLE_COMP_CMD) ansible-playbook $(ANSIBLE_INVENTORY) $(ANSIBLE_ENTRY_PB)

.PHONY: ansible_syntax ansible_task ansible_dry ansible_apply ansible_inventory ansible_apply_trace
ansible_inventory:
	$(ANSIBLE_COMP_CMD) ansible-inventory $(ANSIBLE_INVENTORY) --list

ansible_syntax:
	$(ANSIBLE_CMD) --syntax-check

ansible_task:
	$(ANSIBLE_CMD) --list-task

ansible_dry:
	$(ANSIBLE_CMD) --check

ansible_apply:
	$(ANSIBLE_CMD)

ansible_apply_trace:
	$(ANSIBLE_CMD) -vvvv

#
###### TERRAFORM ######
#

TERRAFORM_COMP_CMD=$(DOCKER_CMD) terraform
TERRAFORM_VARF=vars.tfvars
TERRAFORM_CMD=$(TERRAFORM_COMP_CMD)

.PHONY: terraform_init terraform_plan terraform_apply terraform_destroy

terraform_init:
	$(TERRAFORM_CMD) init

terraform_plan:
	$(TERRAFORM_CMD) plan -var-file=$(TERRAFORM_VARF)

terraform_apply:
	$(TERRAFORM_CMD) apply -var-file=$(TERRAFORM_VARF)

terraform_destroy:
	$(TERRAFORM_CMD) destroy -var-file=$(TERRAFORM_VARF)
