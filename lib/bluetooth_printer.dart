// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BluetoothDevice {
  String? name;
  String? address;
  int? type;
  bool? connected;
  BluetoothDevice({
    this.name,
    this.address,
    this.type,
    this.connected,
  });

  BluetoothDevice copyWith({
    String? name,
    String? address,
    int? type,
    bool? connected,
  }) {
    return BluetoothDevice(
      name: name ?? this.name,
      address: address ?? this.address,
      type: type ?? this.type,
      connected: connected ?? this.connected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'type': type,
      'connected': connected,
    };
  }

  factory BluetoothDevice.fromMap(Map<String, dynamic> map) {
    return BluetoothDevice(
      name: map['name'] != null ? map['name'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      type: map['type'] != null ? map['type'] as int : null,
      connected: map['connected'] != null ? map['connected'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BluetoothDevice.fromJson(String source) =>
      BluetoothDevice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BluetoothDevice(name: $name, address: $address, type: $type, connected: $connected)';
  }

  @override
  bool operator ==(covariant BluetoothDevice other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.type == type &&
        other.connected == connected;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        type.hashCode ^
        connected.hashCode;
  }
}
