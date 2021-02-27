default: apply

clean:
	terraform destroy -auto-approve
	
connect:
	terraform init -get=false

fmt:
	terraform fmt -recursive

init:
	terraform init --upgrade

validate:
	terraform validate

apply: fmt connect validate
	terraform apply