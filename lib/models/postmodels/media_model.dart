import 'dart:convert';

class Media {
  final String url;
  final String type;
  Media({
    required this.url,
    required this.type,
  });

  Media copyWith({
    String? url,
    String? type,
  }) {
    return Media(
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      url: map['url'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));

  @override
  String toString() => 'Media(url: $url, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media && other.url == url && other.type == type;
  }

  @override
  int get hashCode => url.hashCode ^ type.hashCode;
}