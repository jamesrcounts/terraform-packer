TEMPLATE_PATH:="linux/ubuntu2004.json"
default: build

build: validate
	packer build    -var "capture_name_prefix=$ResourcesNamePrefix" \
					-var "client_id=$ClientId" \
					-var "client_secret=$ClientSecret" \
					-var "install_password=$InstallPassword" \
					-var "github_feed_token=$GitHubFeedToken" \
					-var "location=$Location" \
					-var "resource_group=$ResourceGroup" \
					-var "storage_account=$StorageAccount" \
					-var "subscription_id=$SubscriptionId" \
					-var "temp_resource_group_name=$TempResourceGroupName" \
					-var "tenant_id=$TenantId" \
					-var "virtual_network_name=$VirtualNetworkName" \
					-var "virtual_network_resource_group_name=$VirtualNetworkRG" \
					-var "virtual_network_subnet_name=$VirtualNetworkSubnet" \
					-var "run_validation_diskspace=$env:RUN_VALIDATION_FLAG" \
					$(TEMPLATE_PATH)

validate: info
	packer validate -syntax-only $(TEMPLATE_PATH)

info:
	packer --version