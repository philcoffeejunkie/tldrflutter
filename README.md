<p align="center"><img src="android/app/src/main/ic_launcher-playstore.png" alt="tldrflutter" width="100" height="100"></p>

<h1 align="center">tldrflutter</h1>

A Flutter client for [tldr manpages](https://github.com/tldr-pages/tldr/)

<a href="https://play.google.com/store/apps/details?id=de.philcoffeejunkie.tldrflutter" target="_blank"><img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" alt="Get it on Google Play" height="80"/></a>

## How to build

In order to always provide the most recent version of tldr pages, you need to run the download script first:

```
cd ./scripts
./preparePages.bsh
```

It is important to change to the directory (the script is not very sophisticated yet).

When the pages are present under ./assets you can proceed with the standard flutter commands, such as:

```
flutter run
```

## Planned features / TODO

* Auto-complete for search input field
* Release on F-Droid
* Settings like preferred platform
* Improve color scheme
* Provide other color schemes (i.e. light mode)
* Windows version for preparePages.bsh

Feel free to contribute :)

## Screenshots

![](screenshots/Screenshot_1606576927.png?raw=true)
![](screenshots/Screenshot_1606576967.png?raw=true)

