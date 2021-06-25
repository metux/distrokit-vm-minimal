# -*-makefile-*-
#
# Copyright (C) 2008 by Carsten Schlote
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SRVFS_TEST) += srvfs-test

#
# Paths and names
#
SRVFS_TEST_VERSION	:= 4.1
#SRVFS_TEST_MD5		:= e2981debb4a822a279be7e45a0ede988
SRVFS_TEST		:= srvfs-test-$(SRVFS_TEST_VERSION)
SRVFS_TEST_SUFFIX	:= tar.xz
#SRVFS_TEST_URL		:= https://www.kernel.org/pub/software/utils/srvfs-test/$(SRVFS_TEST).$(SRVFS_TEST_SUFFIX)
#SRVFS_TEST_SOURCE	:= $(SRCDIR)/$(SRVFS_TEST).$(SRVFS_TEST_SUFFIX)
SRVFS_TEST_URL		:= file://$(PTXDIST_WORKSPACE)/local_src/srvfs-test
SRVFS_TEST_DIR		:= $(BUILDDIR)/$(SRVFS_TEST)
#SRVFS_TEST_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SRVFS_TEST_CONF_TOOL := NO

SRVFS_TEST_MAKE_ENV := \
	$(CROSS_ENV)

# install the header files to include/srvfs-test
# this way they don't collide with the toolchain's i2c headers
SRVFS_TEST_INSTALL_OPT := \
	PREFIX=/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/srvfs-test.targetinstall:
	@$(call targetinfo)

	@$(call install_init, srvfs-test)
	@$(call install_fixup, srvfs-test,PRIORITY,optional)
	@$(call install_fixup, srvfs-test,SECTION,base)
	@$(call install_fixup, srvfs-test,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, srvfs-test,DESCRIPTION,missing)

	@$(call install_copy, srvfs-test, 0, 0, 0755, -, /usr/bin/test-localfile)
	@$(call install_copy, srvfs-test, 0, 0, 0755, -, /usr/bin/init-srvfs)

	@$(call install_finish, srvfs-test)

	@$(call touch)

# vim: syntax=make
