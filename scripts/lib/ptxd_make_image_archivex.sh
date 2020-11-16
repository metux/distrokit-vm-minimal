#!/bin/bash
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# NOTE: workaround for broken Docker that doesn't understand GNU tar
# make sure tar uses an old format

#
# extract ipkg an generate a tgz image
#
ptxd_make_image_archivex_impl() {
    ptxd_make_image_init &&
    ptxd_get_ipkg_files ${image_pkgs} &&
    ptxd_make_image_extract_xpkg_files "${pkg_dir}" &&
    cd "${pkg_dir}" &&
    echo -ne "\nCreating $(ptxd_print_path "${image_image}") " &&
    if [ -n "${image_label}" ]; then
	echo -n "with label \"${image_label}\" "
    fi &&
    echo -ne "...\n" &&
    tar --format=oldgnu -zcf "${image_image}" .
    local ret=$?
    if [ "${ret}" != 0 ]; then
	rm -f "${image_image}"
    fi
    rm -r "${pkg_dir}"
    return "${ret}"
}
export -f ptxd_make_image_archivex_impl

ptxd_make_image_archivex() {
    fakeroot ptxd_make_image_archivex_impl
}
export -f ptxd_make_image_archivex
