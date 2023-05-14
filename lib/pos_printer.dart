library pos_printer;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pos_printer/line.dart';
import 'package:sstream/sstream.dart';

import 'bluetooth_printer.dart';
import 'line_text.dart';

class BluetoothPrint {
  static const namespace = 'pos_printer';
  static const connected = 1;
  static const disconnected = 0;

  static const MethodChannel _channel = MethodChannel('$namespace/methods');
  static const EventChannel _stateChannel = EventChannel('$namespace/state');

  Stream<MethodCall> get _methodStream => _methodStreamController.stream;
  final StreamController<MethodCall> _methodStreamController =
      StreamController.broadcast();
  factory BluetoothPrint() => _instance;
  BluetoothPrint._() {
    _channel.setMethodCallHandler((MethodCall call) async {
      _methodStreamController.add(call);
      return;
    });
  }
  static final BluetoothPrint _instance = BluetoothPrint._();

  static BluetoothPrint get instance => _instance;

  Future<bool> get isAvailable async =>
      await _channel.invokeMethod('isAvailable').then<bool>((d) => d);

  Future<bool> get isOn async =>
      await _channel.invokeMethod('isOn').then<bool>((d) => d);

  Future<bool?> get isConnected async =>
      await _channel.invokeMethod('isConnected');

  final SStream<bool> _isScanning = false.stream;

  Stream<bool> get isScanning => _isScanning.stream;

  final SStream<List<BluetoothDevice>> scanResults = SStream([]);

  /// Gets the current state of the Bluetooth module
  Stream<int> get state async* {
    yield await _channel.invokeMethod('state').then((s) => s);

    yield* _stateChannel.receiveBroadcastStream().map((s) => s);
  }

  Stream<BluetoothDevice> scan() async* {
    if (_isScanning.value == true) {
      throw Exception('Another scan is already in progress.');
    }

    // Emit to isScanning
    _isScanning.add(true);
    scanResults.add(<BluetoothDevice>[]);

    try {
      await _channel.invokeMethod('startScan');
    } catch (e) {
      if (kDebugMode) {
        print('Error starting scan.');
      }
      _isScanning.add(false);
      rethrow;
    }

    yield* _instance._methodStream
        .where((m) => m.method == "ScanResult")
        .map((m) => m.arguments)
        .map((map) {
      final device = BluetoothDevice.fromMap(Map<String, dynamic>.from(map));
      final List<BluetoothDevice> list = scanResults.value;
      int newIndex = -1;
      list.asMap().forEach((index, e) {
        if (e.address == device.address) {
          newIndex = index;
        }
      });

      if (newIndex != -1) {
        list[newIndex] = device;
      } else {
        list.add(device);
      }
      scanResults.add(list);
      return device;
    });
  }

  Future startScan({
    Duration? timeout,
  }) async {
    await scan().drain();
    return scanResults.value;
  }

  /// Stops a scan for Bluetooth Low Energy devices
  Future stopScan() async {
    await _channel.invokeMethod('stopScan');
    _isScanning.add(false);
  }

  Future<dynamic> connect(BluetoothDevice device) =>
      _channel.invokeMethod('connect', device.toJson());

  Future<dynamic> disconnect() => _channel.invokeMethod('disconnect');

  Future<dynamic> destroy() => _channel.invokeMethod('destroy');

  Future<dynamic> printReceipt(
      Map<String, dynamic> config, List<LineText> data) {
    Map<String, Object> args = {};
    args['config'] = config;
    args['data'] = data.map((m) {
      return m.toMap();
    }).toList();

    _channel.invokeMethod('printReceipt', args);
    return Future.value(true);
  }

  Future<dynamic> printLabel(Map<String, dynamic> config, List<Line> data) {
    Map<String, Object> args = {};
    args['config'] = config;
    args['data'] = data.map((m) {
      return m.toMap();
    }).toList();

    _channel.invokeMethod('printLabel', args);
    return Future.value(true);
  }

  Future<dynamic> printTest() => _channel.invokeMethod('printTest');
}
