import 'dart:convert';

class PrivateIONKey {
  String kty;
  //only d here holds the true private key
  String d;
  String crv;
  String x;
  String y;

  PrivateIONKey({
    required this.kty,
    required this.d,
    required this.crv,
    required this.x,
    required this.y,
  });

  factory PrivateIONKey.fromJson(Map<String, dynamic> json) {
    return PrivateIONKey(
      kty: json['kty'],
      d: json['d'],
      crv: json['crv'],
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kty'] = this.kty;
    data['d'] = this.d;
    data['crv'] = this.crv;
    data['x'] = this.x;
    data['y'] = this.y;
    return data;
  }

  factory PrivateIONKey.fromString(String keyString) {
    keyString = keyString
        .replaceAll('{', '{"')
        .replaceAll(': ', '": "')
        .replaceAll(', ', '", "')
        .replaceAll('}', '"}');

    Map<String, dynamic> keyMap = jsonDecode(keyString);

    if (keyMap.containsKey('kty') &&
        keyMap.containsKey('d') &&
        keyMap.containsKey('crv') &&
        keyMap.containsKey('x') &&
        keyMap.containsKey('y')) {
      return PrivateIONKey(
        kty: keyMap['kty'],
        d: keyMap['d'],
        crv: keyMap['crv'],
        x: keyMap['x'],
        y: keyMap['y'],
      );
    } else {
      throw const FormatException('Invalid key string format');
    }
  }

  @override
  String toString() {
    return '{kty: $kty, d: $d, crv: $crv, x: $x, y: $y}';
  }
}
