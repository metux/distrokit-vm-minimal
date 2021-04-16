# -*-makefile-*-
#
# Copyright (C) 2021 by Enrico Weigelt, metux IT consult <info@metux.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

DOCKER ?= docker

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_DOCKER) += image-root-docker

image/archivex = \
	$(call world/image/env, $(1)) \
	ptxd_make_image_archivex


#
# Paths and names
#
IMAGE_ROOT_DOCKER	:= image-root-docker
IMAGE_ROOT_DOCKER_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_DOCKER)
IMAGE_ROOT_DOCKER_IMAGE	:= $(IMAGEDIR)/docker-root.tgz
IMAGE_ROOT_DOCKER_PKGS	= $(PTX_PACKAGES_INSTALL)
IMAGE_ROOT_DOCKER_LABEL	:= $(call remove_quotes, $(PTXCONF_IMAGE_ROOT_DOCKER_LABEL))
IMAGE_ROOT_DOCKER_MESSAGE := $(call remove_quotes, $(PTXCONF_IMAGE_ROOT_DOCKER_LABEL))

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_ROOT_DOCKER
$(IMAGE_ROOT_DOCKER_IMAGE):
	@$(call targetinfo)
	@$(call image/archivex, IMAGE_ROOT_DOCKER)
	echo "intercept me here"
	$(DOCKER) import --message="$(IMAGE_ROOT_DOCKER_MESSAGE)" $(IMAGE_ROOT_DOCKER_IMAGE) "$(IMAGE_ROOT_DOCKER_LABEL)"
	@$(call finish)
endif

# vim: syntax=make
