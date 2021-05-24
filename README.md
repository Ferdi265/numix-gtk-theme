# Numix Solarized

Numix Solarized is a fork of the Numix GTK theme with a focus on the
[Solarized](https://ethanschoonover.com/solarized/) color scheme. It provides
a light and dark theme with multiple available accent colors.

## Color Options

- Yellow
- Orange
- Red
- Magenta
- Violet
- Blue
- Cyan
- Green

## Brightness Options

- Light
- Dark
- Light with dark top (experimental, currently only with Blue accent color)

## Screenshots

### Light Green

with Numix Light icon theme

![Light Green theme on Ubuntu 20.04](/screenshots/lightgreen-ubuntu-numixlight.png)

### Dark Magenta

with Numix icon theme

![Dark Magenta theme on Ubuntu 20.04](/screenshots/darkmagenta-ubuntu-numix.png)

## Installation Instructions

### Release Archives

Infrequent releases are available pre-built for download on the
[Releases](https://github.com/Ferdi265/numix-solarized-gtk-theme/releases) page.

Install them by copying the individual theme folders into `/usr/share/themes/`.

### AUR

This theme is available on the Arch User Repository:

- [gtk-theme-numix-solarized](https://aur.archlinux.org/packages/gtk-theme-numix-solarized/)
  for release packages
- [gtk-theme-numix-solarized-git](https://aur.archlinux.org/packages/gtk-theme-numix-solarized-git/)
  for the latest commit of this repository

### Building it yourself

For building this theme, you need the following programs:

- `make`
- `sassc`
- `inkscape` (0.9x or 1.x)
- `glib-compile-resources` from `glib2`

Then, run `make THEME=$ThemeVariant install`, where `$ThemeVariant` is the name
(without extension) of one of the `*.color` files in this repository.
Optionally, you can also provide a value for `DESTDIR` to specify an alternate
installation directory.

Note: Make sure to _not_ run `make` with additional threads, as the `Makefile`
is not robust to being used with multiple threads. To be sure, you can replace
`make` with `make -j1`.

## Numix (original README)
##### A modern flat theme with a combination of light and dark elements. It supports GNOME, Unity, Xfce and Openbox.
[![By The Numix Project](https://img.shields.io/badge/By-The%20Numix%20Project-f0544c.svg?style=flat-square)](https://numixproject.org/) &nbsp;[![Circle CI](https://img.shields.io/circleci/project/numixproject/numix-gtk-theme/master.svg?circle-token=b14acf911433d315298235b0c2fbf7b2670a92a8&maxAge=3600&style=flat-square)](https://circleci.com/gh/numixproject/numix-gtk-theme/tree/master) &nbsp;[![GitHub release](https://img.shields.io/github/release/numixproject/numix-gtk-theme.svg?maxAge=3600&style=flat-square)](https://github.com/numixproject/numix-gtk-theme/releases/latest) &nbsp;![Supports GTK+ 3.18](https://img.shields.io/badge/GTK%2B-3.18-4a90d9.svg?style=flat-square) &nbsp;![Supports GTK+ 3.24](https://img.shields.io/badge/GTK%2B-3.24-4a90d9.svg?style=flat-square)

## Install It

### Distro Packages
|Distro|Install Command/Links|
|:----:|:----:|
|![arch][arch] &nbsp;![antergos][antergos]|`sudo pacman -S numix-gtk-theme`|
|![opensuse][opensuse]|[1 Click Install](http://software.opensuse.org/ymp/openSUSE:Factory/standard/numix-gtk-theme.ymp) &nbsp;\|&nbsp; [OBS Repo](http://software.opensuse.org/download.html?project=openSUSE%3AFactory&package=numix-gtk-theme)|
|![fedora][fedora]|`sudo dnf install numix-gtk-theme`|
|![debian][debian] &nbsp;![ubuntu][ubuntu]|`sudo apt install numix-gtk-theme`|

## Build It

First, you need to compile the theme using the [Sass](http://sass-lang.com/) compiler.

You will need to install SassC (`sassc`) which is likely to be available as a package in your distribution's software repositories.

You'll also need the ```glib-compile-schemas``` and  ```gdk-pixbuf-pixdata``` commands in your path to generate the gresource binary. Install them using your distribution's package manager.

|Distro|Commands|
|:----:|:----:|
|![arch][arch] &nbsp;![antergos][antergos]|`sudo pacman -S sassc glib2 gdk-pixbuf2`|
|![opensuse][opensuse]|`sudo zypper install sassc glib2-devel gdk-pixbuf-devel`|
|![fedora][fedora]|`sudo dnf install sassc glib2-devel gdk-pixbuf2-devel`|
|![debian][debian] &nbsp;![ubuntu][ubuntu]|`sudo apt-get install sassc libglib2.0-dev libgdk-pixbuf2.0-dev libxml2-utils`|

After installing all the dependencies, change to the cloned directory and, run the following in Terminal,

```sh
sudo make install
```

To set the theme in GNOME, run the following commands in Terminal,

```sh
gsettings set org.gnome.desktop.interface gtk-theme "Numix"
gsettings set org.gnome.desktop.wm.preferences theme "Numix"
```

To set the theme in Xfce, run the following commands in Terminal,

```sh
xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"
```

In Openbox you can set the theme with [ObConf](http://openbox.org/wiki/ObConf:About) tool. Alternatively, you can set the theme by changing the `<name> `key value to `Numix` in the `<theme>` section of your rc.xml file.

### For contributors
Start by reviewing the [guidelines for contributing](https://github.com/numixproject/numix-gtk-theme/blob/master/.github/CONTRIBUTING.md).

#### For developers
If you want to hack on the theme, make sure you have the `inotifywait` command available, which is used for watching and automatically building the files.

To start watching for changes, run the following,

```sh
make watch
```

If you change any assets, you'll need to regenerate the `gtk.gresource.xml` and `gtk.gresource` files. You can use [grrr](https://github.com/satya164/grrr) to do it easily.

### Requirements

GTK+ 3.18 or above

Murrine theme engine

### Code and license

Report bugs or contribute at [GitHub](https://github.com/numixproject/numix-gtk-theme)

License: GPL-3.0+


[antergos]: https://antergos.com/distro-logos/logo-square26x26.png "antergos"
[arch]: https://antergos.com/distro-logos/archlogo26x26.png "arch"
[fedora]: https://antergos.com/distro-logos/fedora-logo.png "fedora"
[openSUSE]: https://antergos.com/distro-logos/Geeko-button-bling7.png "openSUSE"
[ubuntu]: https://antergos.com/distro-logos/ubuntu_orange_hex.png "ubuntu"
[debian]: https://antergos.com/distro-logos/openlogo-nd-25.png "debian"

