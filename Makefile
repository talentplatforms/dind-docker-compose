################################################################################
# start / stop / prepare
################################################################################

init:
	npm install

################################################################################
# releases
################################################################################

# patches a version
patch:
	npm run release:patch

# minor up
minor:
	npm run release:minor

# major up
release:
	npm run release

################################################################################
# docker building stuff
################################################################################
# you have to know what you're doing if your using this ;)


DOCKER_VERSION=19.03.8
DOCKER_COMPOSE_VERSION=1.25.5
TAG_COMPOSE=d-${DOCKER_VERSION}-dc-${DOCKER_COMPOSE_VERSION}
REGISTRY=talentplatforms/docker-compose
VCS_URL=https://github.com/talentplatforms/docker-compose

# DO NOT OVERRIDE!
_BUILD_DATE=$(shell echo $$(date -u +'%Y-%m-%dT%H:%M:%SZ'))
_VCS_REF=$(shell echo $$(git rev-parse --verify HEAD))
_IMAGE=${REGISTRY}:${TAG_COMPOSE}
_IMAGE_LATEST=${REGISTRY}:latest

build:
	docker build \
	--rm \
	--build-arg DOCKER_VERSION=${DOCKER_VERSION} \
	--build-arg DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION} \
	--build-arg BUILD_DATE=${_BUILD_DATE} \
	--build-arg VCS_URL=${VCS_URL} \
	--build-arg VCS_REF=${_VCS_REF} \
	--build-arg BUILDKIT_INLINE_CACHE=1 \
	-t ${_IMAGE} \
	-t ${_IMAGE_LATEST} \
	.

push:
	docker push ${_IMAGE}
	docker push ${_IMAGE_LATEST}
