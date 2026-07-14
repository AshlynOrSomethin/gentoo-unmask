# unmask

Tiny Gentoo helper that appends a `~amd64` keyword entry for a package atom.

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

This repository now contains a minimal local overlay for `app-portage/unmask`.

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

## Test without touching `/etc`

```bash
mkdir -p /tmp/unmask-test/etc/portage/package.accept_keywords
PORTAGE_CONFIG_ROOT=/tmp/unmask-test/etc/portage ./unmask sys-kernel/cachyos-sources
cat /tmp/unmask-test/etc/portage/package.accept_keywords/sys-kernel
```