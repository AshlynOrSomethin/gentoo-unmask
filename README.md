# unmask

Small Gentoo helper repo with two commands:

- `unmask` appends a `~amd64` keyword entry for a package atom.
- `emergex` runs `emerge` with autounmask enabled, then runs `etc-update --automode -5`.

## Behavior

Running:

```bash
sudo unmask sys-kernel/cachyos-sources
```

adds:

```text
sys-kernel/cachyos-sources ~amd64
```

to one of these locations:

- `/etc/portage/package.accept_keywords/sys-kernel` when `package.accept_keywords` is a directory
- `/etc/portage/package.accept_keywords` when it is a file

The category part before the slash is used as the file name when Gentoo is configured with a directory.

## Overlay setup

This repository now contains a minimal local overlay for `app-portage/unmask` and `app-portage/emergex`.

Add it as a repository:

```bash
sudo mkdir -p /etc/portage/repos.conf
sudo tee /etc/portage/repos.conf/unmask.conf >/dev/null <<'EOF'
[unmask]
location = /home/ashlyn/Documents/GitHub/unmask
masters = gentoo
auto-sync = no
EOF
```

Then install the package:

```bash
sudo emerge --ask app-portage/unmask
```

After that, use it normally:

```bash
sudo unmask sys-kernel/cachyos-sources
```

To install the wrapper that auto-writes USE changes and auto-merges trivial config updates:

```bash
sudo emerge --ask app-portage/emergex
```

Then use it like this:

```bash
emergex -av cachyos-sources
```

`emergex` internally runs:

```bash
sudo emerge --autounmask-write --autounmask-continue ...
sudo etc-update --automode -5
```

If emerge fails because a package is masked by the `~amd64` keyword,
`emergex` reads the masked package suggestions, runs `unmask` for those
atoms automatically, and retries the emerge command once.

## Test without touching `/etc`

```bash
mkdir -p /tmp/unmask-test/etc/portage/package.accept_keywords
PORTAGE_CONFIG_ROOT=/tmp/unmask-test/etc/portage ./unmask sys-kernel/cachyos-sources
cat /tmp/unmask-test/etc/portage/package.accept_keywords/sys-kernel
```