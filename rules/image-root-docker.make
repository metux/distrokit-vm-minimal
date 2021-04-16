# -*-makefile-*-
#
# Copyright (C) 2021 by Enrico Weigelt, metux IT consult <info@metux.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ROOT_DOCKER) += image-root-docker

#
# Paths and names
#
IMAGE_ROOT_DOCKER	:= image-root-docker
IMAGE_ROOT_DOCKER_DIR	:= $(BUILDDIR)/$(IMAGE_ROOT_DOCKER)
IMAGE_ROOT_DOCKER_IMAGE	:= $(IMAGEDIR)/docker-root.tgz
IMAGE_ROOT_DOCKER_PKGS	= $(PTX_PACKAGES_INSTALL)
IMAGE_ROOT_DOCKER_LABEL	:= $(call remove_quotes, $(PTXCONF_IMAGE_ROOT_DOCKER_LABEL))

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_ROOT_DOCKER
$(IMAGE_ROOT_DOCKER_IMAGE):
	@$(call targetinfo)
	@$(call image/archive, IMAGE_ROOT_TGZ)
	echo "intercept me here"
	@$(call finish)
endif

# vim: syntax=make
