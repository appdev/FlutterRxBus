import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

const String _DEFAULT_IDENTIFIER = "apkdev_eventbus_default_identifier";

class Bus {
  PublishSubject _Subject;
  String _tag;

  PublishSubject get subject => _Subject;

  String get tag => _tag;

  Bus(String tag) {
    this._tag = tag;
    _Subject = PublishSubject();
  }

  Bus.create() {
    _Subject = PublishSubject();
    this._tag = _DEFAULT_IDENTIFIER;
  }
}

class RxBus {
  static final RxBus _singleton = new RxBus._internal();

  factory RxBus() {
    return _singleton;
  }

  RxBus._internal();

  static List<Bus> _list = List();

  static RxBus get singleton => _singleton;

  /// 监听事件。每次监听开启都会新建一个[PublishSubject] 防止重复监听事件
  static Observable<T> register<T>({String tag}) {
    if (tag != null && tag == _DEFAULT_IDENTIFIER) {
      throw FlutterError('EventBus register tag Can\'t is $_DEFAULT_IDENTIFIER ');
    }
    Bus _eventBus;
    //已经注册过的tag不需要重新注册
    if (_list.isNotEmpty && tag != null) {
      _list.forEach((bus) {
        if (bus.tag == tag) {
          _eventBus = bus;
          return;
        }
      });
      if (_eventBus == null) {
        _eventBus = Bus(tag);
        _list.add(_eventBus);
      }
    } else {
      _eventBus = tag == null ? Bus.create() : Bus(tag);
      _list.add(_eventBus);
    }

    if (T == dynamic) {
      _eventBus.subject.stream;
    } else {
      return _eventBus.subject.stream.where((event) => event is T).cast<T>();
    }
  }

  ///发送事件
  static void post(event, {tag}) {
    _list.forEach((rxBus) {
      if (tag != null && tag != _DEFAULT_IDENTIFIER && rxBus.tag == tag) {
        rxBus.subject.sink.add(event);
      } else if ((tag == null || tag == _DEFAULT_IDENTIFIER) && rxBus.tag == _DEFAULT_IDENTIFIER) {
        rxBus.subject.sink.add(event);
      }
    });
  }

  ///事件关闭
  static void destroy({tag}) {
    var toRemove = [];
    _list.forEach((rxBus) {
      if (tag != null && tag != _DEFAULT_IDENTIFIER && rxBus.tag == tag) {
        rxBus.subject.close();
        toRemove.add(rxBus);
      } else if ((tag == null || tag == _DEFAULT_IDENTIFIER) && rxBus.tag == _DEFAULT_IDENTIFIER) {
        rxBus.subject.close();
        toRemove.add(rxBus);
      }
    });
    toRemove.forEach((rxBus) {
      _list.remove(rxBus);
    });
  }
}
