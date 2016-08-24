# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="A small self-contained alternative to readline and libedit"
HOMEPAGE="https://github.com/antirez/linenoise"
SRC_URI="https://github.com/antirez/linenoise/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
  rm ${S}/Makefile
  cp ${FILESDIR}/${P}-Makefile ${S}/Makefile
  default_src_prepare
}

src_install() {
  dodir /usr/include/linenoise
  insinto /usr/include/linenoise
  doins linenoise.h

  insinto /usr/$(get_libdir)
  doins liblinenoise.a

  dodoc LICENSE README.markdown
}
