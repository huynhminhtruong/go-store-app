# INIT SERVICE WORKDIR FOLLOWS HEXAGONAL ARCHITECTURE
# default env values
ROOT = ./src
BIZ = biz
CMD = cmd
CONFIG = config
SERVICES = services
ADAPTER = adapters
APPLICATION = application
CORE = core

#  make init-service NAME=go-store-order ADAPTER_V1=db ADAPTER_V2=grpc CORE_V1=api CORE_V2=domain
init-service:
	@./init_service.sh ${NAME} ${ADAPTER_V1} ${ADAPTER_V2} ${CORE_V1} ${CORE_V2}
