
# NGXBLD_ARGS ?= "--no-cache"
DOCKER_OPTS = $(NGXBLD_ARGS)

default: ubuntu
	@echo "Done building default target ($<)"

all: ubuntu debian alpine

%:
	@echo docker build $(DOCKER_OPTS)  -f Dockerfile.$@ -t nginxmodsec_$@ .
