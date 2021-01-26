default: base

base:
	cd infrastructure/azure/base && \
		make

agents:
	cd infrastructure/azure/agents && \
		make