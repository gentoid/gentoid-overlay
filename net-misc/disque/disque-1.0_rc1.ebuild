# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit versionator

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="Disque is a distributed message broker"
HOMEPAGE="https://github.com/antirez/disque"
SRC_URI="https://github.com/antirez/disque/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
  >=dev-libs/hiredis-0.13.1
  >=dev-libs/jemalloc-4.0
  dev-libs/linenoise
"

PATCHES=(
  "${FILESDIR}"/${P}-dont-build-deps.patch
  "${FILESDIR}"/${P}-dont-define-je_-prefix-for-malloc.patch
)

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
  PREFIX="${D}/usr" make install
  dodoc COPYING README.md
}
