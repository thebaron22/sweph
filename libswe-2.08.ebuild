# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Annoyingly complex and cryptically documented ephemeris library"
HOMEPAGE="https://www.astro.com/"
SRC_URI="https://www.astro.com/ftp/swisseph/swe_unix_src_2.08.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~armv7"

src_unpack() {
  unpack ${A}
  S=${WORKDIR}
}

src_compile() {
  cd src
  make && make libswe.so
}

src_install() {
  diropts -o root -g root -m0755
  insopts -o root -g root -m0644

  einstalldocs

  insinto /usr/lib64/${P}
  doins "${S}/src/libswe.so" || die "Install failed!"

  cd ${S}/src
  mkdir ${P}
  mv *.h ${P}/
  doheader -r "${S}/src/${P}" || die "Install failed!"
}

