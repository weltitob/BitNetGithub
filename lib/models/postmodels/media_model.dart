import 'dart:convert';

class Media {
  final String data;
  final String type;

  Media({
    required this.data,
    required this.type,
  });

  Media copyWith({
    String? data,
    String? type,
  }) {
    return Media(
      data: data ?? this.data,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'type': type,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      data: map['data'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));

  @override
  String toString() => 'Media(data: $data, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media && other.data == data && other.type == type;
  }

  @override
  int get hashCode => data.hashCode ^ type.hashCode;
}
