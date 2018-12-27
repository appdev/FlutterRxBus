# FlutterRxBus

A Flutter EventBus using [RxDart](https://pub.dartlang.org/packages/rxdart)


[![Pub Package](https://img.shields.io/badge/RxBus-0.0.1-blue.svg)](https://pub.dartlang.org/packages/event_bus)
[![Pub Package](https://img.shields.io/github/license/huclengyue/FlutterRxBus.svg)](https://pub.dartlang.org/packages/event_bus)

[GitHub](https://github.com/huclengyue/FlutterRxBus) |
[Pub](https://pub.dartlang.org/packages/event_bus) |


## Usage

### 1. Add to pubspec.yaml
```yaml
  rxbus: latest version
```

### 2. Define Event

Any Dart class or List or any Data can be used as an event.

```dart
class ChangeTitleEvent {
  String title;

  ChangeTitleEvent(this.title);
}

```

### 3. Register RxBus

Register `RxBus`

```dart
import 'package:rxbus/rx_bus.dart';

RxBus.singleton.register<ChangeTitleEvent>().listen((event) {
      ···//do something
    print(event.title);
    });
```

### 4. Send Event

Register listeners for **specific events**:

```dart
 RxBus.singleton.post(ChangeTitleEvent("Changed by event"));
```

## License

The MIT License (MIT)
