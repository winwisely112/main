# https://github.com/textileio/go-foldersync
LIB_NAME=go-foldersync
LIB=github.com/textileio/$(LIB_NAME)
LIB_BRANCH=master
#LIB_TAG=v1.10.1
LIB_FSPATH=$(GOPATH)/src/$(LIB)

GO111MODULE=on

SAMPLE_NAME=
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

CLOUD_PROJECT_ID=winwisely-cloudrun-gitea
CLOUD_PROJECT_URL=????

