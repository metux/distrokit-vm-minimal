PACKAGES-$(PTXCONF_RUNC) += runc

RUNC_VERSION       := 1.0.0-rc93
RUNC_MD5           := dd5b4ac7abf7f97479960078e19fe974
RUNC               := runc-$(RUNC_VERSION)
RUNC_SUFFIX        := tar.xz
RUNC_URL           := git://github.com/opencontainers/runc.git;tag=v$(RUNC_VERSION)
RUNC_SOURCE        := $(SRCDIR)/$(RUNC).$(RUNC_SUFFIX)
RUNC_DIR           := $(BUILDDIR)/$(RUNC)
RUNC_LICENSE       := GPL-2.0-only AND GPL-2.0-or-later AND MIT AND BSD-1-Clause AND BSD-2-Clause AND BSD-3-Clause
# RUNC_BUILD_OOT     := YES

ifeq ($(PTXCONF_ARCH_STRING),x86_64)
GOARCH := amd64
else
GOARCH := $(PTXCONF_ARCH_STRING)
endif

RUNC_MAKE_ENV    := PREFIX=/usr CC=$(CROSS_CC) GOARCH=$(GOARCH)
RUNC_INSTAL_ENV  := $(RUNC_MAKE_ENV)

RUNC_MAKE_OPT    := all
RUNC_INSTALL_OPT := install

ifeq ($(RUNC_ENABLE_MAN),true)
RUNC_INSTALL_OPT += install-man
RUNC_MAKE_OPT    += man
endif

$(STATEDIR)/runc.targetinstall:
	@$(call targetinfo)
	@$(call install_init, runc)
	@$(call install_fixup, runc, PACKAGE, runc)
	@$(call install_fixup, runc, PRIORITY, optional)
	@$(call install_fixup, runc, VERSION, $(RUNC_VERSION))
	@$(call install_fixup, runc, SECTION, base)
	@$(call install_fixup, runc, AUTHOR, "Enrico Weigelt, metux IT consult <info@metux.net>")
	@$(call install_fixup, runc, DEPENDS,)
	@$(call install_fixup, runc, DESCRIPTION, "OCI conformant container runtime")
	@$(call install_copy, runc, 0, 0, 0755, $(RUNC_DIR)/runc, /usr/sbin/runc)
	@$(call install_copy, runc, 0, 0, 0755, $(RUNC_DIR)/contrib/cmd/recvtty/recvtty, /usr/sbin/recvtty)
	@$(call install_finish, runc)
	@$(call touch)
