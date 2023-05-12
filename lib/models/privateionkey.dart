class PrivateIONKey {
  String kty;
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
}
