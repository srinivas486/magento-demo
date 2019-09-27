CUSTOMER_NAME ?= customer1
BASE_DOMAIN ?= magento.com
BASE_URL ?= https://${CUSTOMER_NAME}.${BASE_DOMAIN}
DB_HOST ?= mysql.mysql
DB_NAME ?= magento_${CUSTOMER_NAME}
DB_USER ?= root
DB_PASS ?= root
ADMIN_FIRST_NAME ?= admin
ADMIN_LAST_NAME ?= admin
ADMIN_USERNAME ?= admin
ADMIN_PASSWORD ?= admin1234
ADMIN_EMAIL ?= admin@admin.com
CURRENCY ?= AUD
LANGUAGE ?= en_US
TIMEZONE ?= Australia/Sydney
BACKEND_FRONTNAME ?= admin

ENVIRONMENT ?= LOCAL
REPLICAS ?= 1

PACKAGE ?= magento-base
VERSION ?= $(shell git describe --tags --always --dirty --match="v*" 2> /dev/null || cat $(CURDIR)/.version 2> /dev/null || echo v0)
K8S_DIR       ?= ./k8s
K8S_BUILD_DIR ?= ./build_k8s
K8S_FILES     := $(shell find $(K8S_DIR) -name '*.yaml' | sed 's:$(K8S_DIR)/::g')
DOCKER_REGISTRY_DOMAIN ?= $(shell minikube ip):5000
DOCKER_REGISTRY_PATH   ?= magento-demo
DOCKER_IMAGE           ?= $(DOCKER_REGISTRY_PATH)/$(PACKAGE):$(VERSION)
DOCKER_IMAGE_DOMAIN    ?= $(DOCKER_REGISTRY_DOMAIN)/$(DOCKER_IMAGE)
DOCKER_IMAGE_DOMAIN_LOCALHOST    ?= localhost:5000/$(DOCKER_IMAGE)

MAKE_ENV += CUSTOMER_NAME BASE_DOMAIN BASE_URL DB_HOST DB_NAME DB_USER DB_PASS ADMIN_FIRST_NAME ADMIN_LAST_NAME ADMIN_USERNAME ADMIN_PASSWORD ADMIN_EMAIL CURRENCY LANGUAGE TIMEZONE BACKEND_FRONTNAME PACKAGE VERSION DOCKER_IMAGE DOCKER_IMAGE_DOMAIN DOCKER_IMAGE_DOMAIN_LOCALHOST REPLICAS
SHELL_EXPORT := $(foreach v,$(MAKE_ENV),$(v)='$($(v))' )

.PHONY: set-env
set-env:
		eval $(minikube docker-env)

.PHONY: build-docker
build-docker: set-env
		docker build . -t "$(DOCKER_IMAGE_DOMAIN)"

.PHONY: push-docker
push-docker: build-docker
		docker push "$(DOCKER_IMAGE_DOMAIN)"

# Builds the Kubernetes build directory if it does not exist
# The @ symbol prevents Make from echoing the results of the
# command.
$(K8S_BUILD_DIR):
		@mkdir -p $(K8S_BUILD_DIR)
		
.PHONY: build-k8s
build-k8s: $(K8S_BUILD_DIR)
		@for file in $(K8S_FILES); do \
				mkdir -p `dirname "$(K8S_BUILD_DIR)/$$file"` ; \
				$(SHELL_EXPORT) envsubst <$(K8S_DIR)/$$file >$(K8S_BUILD_DIR)/$$file ;\
		done

.PHONY: deploy
deploy: deploy-prerequisites build-k8s ssl-cert push-docker
		kubectl apply -f $(K8S_BUILD_DIR)/magento.yaml
		kubectl delete secret magento-web-secret --ignore-not-found
		kubectl create secret tls magento-web-secret --key $(K8S_BUILD_DIR)/tls.key --cert $(K8S_BUILD_DIR)/tls.crt -n $(CUSTOMER_NAME)
		kubectl apply -f $(K8S_BUILD_DIR)/ingress.yaml
		kubectl get ingress --namespace $(CUSTOMER_NAME)

.PHONY: deploy-prerequisites
deploy-prerequisites: build-k8s push-docker
		kubectl apply -f $(K8S_BUILD_DIR)/storageClass.yaml
		kubectl apply -f $(K8S_BUILD_DIR)/mysql.yaml

.PHONY: ssl-cert
ssl-cert: 
		openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(K8S_BUILD_DIR)/tls.key -out $(K8S_BUILD_DIR)/tls.crt -subj "/CN=$(CUSTOMER_NAME).$(BASE_DOMAIN)"