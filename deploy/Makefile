# global environments
SERVICE=book-service
KONG_DATA_CONFIG_SERVICE="paths[]=name=book-service --data url=http://gateway:8081"
KONG_DATA_CONFIG_ROUTE_GET_LIST="paths[]=/v1/books --data methods[]=GET --data strip_path=false"
KONG_DATA_CONFIG_ROUTE_GET_SINGLE="paths[]=/v1/books/{book_id} --data methods[]=GET --data strip_path=false"
KONG_DATA_CONFIG_ROUTE_POST="paths[]=/v1/books --data methods[]=POST --data strip_path=false"

# add service to kong
kong-register-service:
	@curl -i -X POST http://localhost:8001/services \
	  --data ${KONG_DATA_CONFIG_SERVICE}

# add route to service
kong-register-service-route-get-list:
	@curl -i -X POST http://localhost:8001/services/${SERVICE}/routes \
      --data ${KONG_DATA_CONFIG_ROUTE_GET_LIST}

# add route to service
kong-register-service-route-get-single:
	@curl -i -X POST http://localhost:8001/services/${SERVICE}/routes \
       --data ${KONG_DATA_CONFIG_ROUTE_GET_SINGLE}

# add route to service
kong-register-service-route-post:
	@curl -i -X POST http://localhost:8001/services/${SERVICE}/routes \
       --data ${KONG_DATA_CONFIG_ROUTE_POST}