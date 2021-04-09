PACKAGES-$(PTXCONF_RUNC) += runc

#
# Paths and names
#
RUNC_VERSION := 1

# ----------------------------------------------------------------------------
# omit the 'get' stage (due to the fact, the files are already present)
# ----------------------------------------------------------------------------

$(STATEDIR)/runc.get:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'extract' stage (due to the fact, all files are already present)
# ----------------------------------------------------------------------------

$(STATEDIR)/runc.extract:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'prepare' stage (due to the fact, nothing is to be built)
# ----------------------------------------------------------------------------

$(STATEDIR)/runc.prepare:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'compile' stage (due to the fact, nothing is to be built)
# ----------------------------------------------------------------------------

$(STATEDIR)/runc.compile:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'install' stage (due to the fact, nothing is to be installed into the sysroot)
# ----------------------------------------------------------------------------

$(STATEDIR)/runc.install:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/runc.targetinstall:
	@$(call targetinfo)
	
	@$(call install_init, runc)
	@$(call install_fixup, runc,PACKAGE,runc)
	@$(call install_fixup, runc,PRIORITY,optional)
	@$(call install_fixup, runc,VERSION,$(RUNC_VERSION))
	@$(call install_fixup, runc,SECTION,base)
	@$(call install_fixup, runc,AUTHOR,"Enrico Weigelt, metux IT consult <info@metux.net>")
	@$(call install_fixup, runc,DEPENDS,)
	@$(call install_fixup, runc,DESCRIPTION,"A few binary example files")
	$(call install_alternative, runc, 0, 0, 555, /testing.dtb)


#
# Install the single binary file on demand
#
#ifdef PTXCONF_RUNC_FILE
#	@$(call install_copy, runc, 0, 0, 0755, /example)
#	@$(call install_copy, runc, 0, 0, 0644, \
#		$(PTXDIST_WORKSPACE)/local_src/runc/ptx_logo.png, \
#		/example/ptx_logo.png)
#endif

#
# Install the whole archive on demand
#
#ifdef PTXCONF_RUNC_ARCHIVE
#	@$(call install_archive, runc, -, -, \
#		$(PTXDIST_WORKSPACE)/local_src/archive_example/pictures.tgz, \
#		/)
# note: the third parameter is the 'user id', the forth parameter the 'group id'.
# If given as '-', the ID from the archive is used. If given as number, this
# number is used, instead of the ID in the archive.
#endif

	@$(call install_finish, runc)
	@$(call touch)
