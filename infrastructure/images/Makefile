TEMPLATE_PATH:="linux/ubuntu2004.json"
default: validate

validate: info
	packer validate -syntax-only $(TEMPLATE_PATH)

info:
	packer --version