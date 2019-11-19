ifndef $(GOPATH)
    GOPATH=$(shell go env GOPATH)
    export GOPATH
endif
LIB_NAME=main
LIB=github.com/winwisely99/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

GO111MODULE=on

SAMPLE_NAME=server/go-server
ifeq ($(OS),Windows_NT)
SAMPLE_NAME=server/go-server
LIB_FSPATH=$(subst \,/,$(subst C:\,/c/,$(GOPATH)/src/$(LIB)))
SAMPLE_FSPATH=$(subst \,/,$(subst C:\,/c/,$(LIB_FSPATH)/$(SAMPLE_NAME)))
PROTO_OUTPUT=$(subst /c/,C:\,$(subst \,/,$(SAMPLE_FSPATH)))
PROTO_PATH=$(subst /c/,C:\,$(subst \,/,$(LIB_FSPATH)))
else
LIB_FSPATH=$(GOPATH)/src/$(LIB)
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)
endif 

CLOUD_PROJECT_ID=winwisely-cloudrun-main

# URL created from cloud-deploy
CLOUD_PROJECT_URL=????
#CLOUD_PROJECT_URL=????https://identicon-generator-ts4lgtxcbq-ew.a.run.app