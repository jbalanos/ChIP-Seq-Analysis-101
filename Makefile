
DOCKERFILES = $(shell find * -type f -name Dockerfile)
#IMAGES =  $(shell sed 's+/Dockerfile++g' $(DOCKERFILES))

MAJOR?=0
MINOR?=1
VERSION=$(MAJOR).$(MINOR)
APP_NAME = "ChIP-Seq"



repository ?= app-bio
images = base base-java base-python sra-toolkit



.PHONY: shell help build rebuild service login test clean prune

all-build-targets = $(foreach image, $(images), $( build-image-$(image) ))
build-all-images:
			for image in $(images); do \
             make build-image-$${image}; \
        	done

help:
	@echo ''
	@echo 'Usage: make [Target] [Extra_Arguments]'


#$(echo images | sed 's+build-image-++g'): %:
#	echo "target: " $@
#	docker build -f  $(shell   echo $@ | sed 's+build-image-++g' )/Dockerfile $(shell echo $@ | sed 's+build-image-++g' )

######################### Build Images Section #############################
images_to_build = $(shell  echo $(images) | sed 's/[^ ]* */build-image-&/g')

.PHONY: $(images_to_build)
$(images_to_build): build-image-%: clean-image-%
	@echo "target: " $@
	@echo "context: " ./containers/$(shell   echo $@ | sed 's+build-image-++g' )/Dockerfile
	@docker build \
	-t $(repository)/$(shell   echo $@ | sed 's+build-image-++g'):$(VERSION) \
	-f  ./containers/$(shell   echo $@ | sed 's+build-image-++g' )/Dockerfile \
	./containers/$(shell echo $@ | sed 's+build-image-++g' )
	@docker tag ${repository}/$(shell   echo $@ | sed 's+build-image-++g'):$(VERSION) \
	${repository}/$(shell   echo $@ | sed 's+build-image-++g' ):latest
	@echo 'Done.'
	@docker images --format '{{.Repository}}:{{.Tag}}\t\t Built: {{.CreatedSince}}\t\tSize: {{.Size}}' | \
	grep ${IMAGE_NAME}:${VERSION}


######################### Build Images Section No Cache #############################
images_to_rebuild = $(shell  echo $(images) | sed 's/[^ ]* */rebuild-image-&/g')
images_to_clean = $(shell  echo $(images) | sed 's/[^ ]* */clean-image-&/g')

.PHONY: $(images_to_rebuild)
$(images_to_rebuild): %:
	@echo "target: " $@
	@docker build --no-cache \
	-f  containers/$(shell   echo $@ | sed 's+rebuild-image-++g' )/Dockerfile \
	$(shell echo $@ | sed 's+rebuild-image-++g' )


.PHONY: $(images_to_clean)
$(images_to_clean): %:
	@echo "target: " $@
	@docker rmi $(repository)/$(shell   echo $@ | sed 's+clean-image-++g'):latest  || true



download-samples-data:
		docker run --rm --user $(id -u):$(id -g)  -v ./data/:/data app-bio/sra-tools prefetch




create-pipeline-folder-structure:
		mkdir -p ./data/raw-samples
		mkdir -p ./data/reference



clean-pipeline-run-data:

