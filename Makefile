default: azure

azure:
	cd infrastructure/azure && \
		make

image:
	cd infrastructure/images && \
		make