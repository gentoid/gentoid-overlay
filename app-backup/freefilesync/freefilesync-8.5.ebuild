# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

WX_GTK_VER="3.0"
inherit wxwidgets

DESCRIPTION="FreeFileSync is a folder comparison and synchronization tool"
HOMEPAGE="http://www.freefilesync.org"
SRC_URI="http://www.freefilesync.org/download/FreeFileSync_${PV}_Source.zip"
LICENSE="GPL-3"

RESTRICT="fetch"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""



DEPEND="app-arch/unzip
	x11-libs/wxGTK:3.0[X]
	>=dev-libs/zenxml-2.1"

RDEPEND="x11-libs/wxGTK[X]
	dev-libs/boost"

S=${WORKDIR}

src_compile(){
    cd FreeFileSync/Source
    sed -i 's/-lboost_system/-lboost_system -lrt/' Makefile
    emake launchpad || die "emake failed for FreeFileSync"
    cd RealTimeSync
    sed -i 's/-lboost_system/-lboost_system -lrt/' Makefile
    emake launchpad || die "emake failed for RealtimeSync"
}

src_install(){
    cd FreeFileSync/Source
    emake DESTDIR="${D}" install || die "Install failed for FreeFileSync"
    cd RealTimeSync
    emake DESTDIR="${D}" install || die "Install failed for RealtimeSync"

    unzip ../../Build/Resources.zip FreeFileSync.png RealTimeSync.png

    newicon FreeFileSync.png FreeFileSync.png
    make_desktop_entry "FreeFileSync" "Synchronize files and folders" "FreeFileSync" "System;Utility"

    newicon RealTimeSync.png RealTimeSync.png
    make_desktop_entry "RealTimeSync" "Synchronize files and folders in realtime" "RealTimeSync" "System;Utility"
}
