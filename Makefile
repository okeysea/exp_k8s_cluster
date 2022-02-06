DOCKER_CMD=docker-compose run --rm

#
###### ANSIBLE ######
#

ANSIBLE_COMP_CMD=$(DOCKER_CMD) ansible
ANSIBLE_INVENTORY=inventory/k8s_cluster.sh
ANSIBLE_ENTRY_PB=site.yml
ANSIBLE_CMD=$(ANSIBLE_COMP_CMD) ansible-playbook -i $(ANSIBLE_INVENTORY) $(ANSIBLE_ENTRY_PB)

.PHONY: ansible_syntax ansible_task ansible_dry ansible_apply
ansible_syntax:
	$(ANSIBLE_CMD) --syntax-check

ansible_task:
	$(ANSIBLE_CMD) --list-task

ansible_dry:
	$(ANSIBLE_CMD) --check

ansible_apply:
	$(ANSIBLE_CMD)

#
###### TERRAFORM ######
#

TERRAFORM_COMP_CMD=$(DOCKER_CMD) terraform
TERRAFORM_VARF=vars.tfvars
TERRAFORM_CMD=$(TERRAFORM_COMP_CMD)

.PHONY: terraform_init terraform_plan terraform_apply

terraform_init:
	$(TERRAFORM_CMD) init

terraform_plan:
	$(TERRAFORM_CMD) plan -var-file=$(TERRAFORM_VARF)

terraform_apply:
	$(TERRAFORM_CMD) apply -var-file=$(TERRAFORM_VARF)