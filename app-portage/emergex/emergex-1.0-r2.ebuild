EAPI=8

DESCRIPTION="Wrapper around emerge with autounmask and automatic etc-update"
HOMEPAGE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
RDEPEND="app-portage/unmask"
S="${WORKDIR}"

src_install() {
    newbin "${FILESDIR}/${PN}" emergex
}