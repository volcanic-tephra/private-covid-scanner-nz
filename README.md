# Totally private Covid-19 Scanner
A totally open source Covid-19 scanner application that does not ask permission to use the internet. You can be reassured that no data, whether
it is a location scan or your vaccination passport are only every stored locally on your device.

Of course there will be limitations, you are never going to receive alerts about places of interest you may have visited.

## The Code
This application is written in Dart and Flutter. Being a personal project and the first time ever using those technologies, the quality is not assured. The application uses:

- SQLLite database for local storage.
- Materiel UI

### Android only
As all my machines are Linux there is no way to test an iOS version. I certainly am not willing to pay the Apple tax for a personal project.

## Getting Started

### Dependencies

- Android SDK
- Android Studio
- Flutter

_Install dependencies_
```
flutter pub get
```

_Run on a device_
```
flutter run
```


## License
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)