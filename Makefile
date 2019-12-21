# general housekeeping stuff

# Pick a version to want !!
TAG_NAME=v1.0.3


help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print
	@echo
	@echo LIB_NAME: $(TAG_NAME)
	@echo

git-tag-create: ## git-tag-create
	# this will create a local tag on your current branch and push it to Github.

	git tag $(TAG_NAME)

	# push it up
	git push origin --tags

git-tag-delete: ## git-tag-delete
	# this will delete a local tag and push that to Github

	git push --delete origin $(TAG_NAME)
	git tag -d $(TAG_NAME)
