class QRCodeBitcoin {
  String bitcoinAddress;

  QRCodeBitcoin({
    required this.bitcoinAddress,
  });

  factory QRCodeBitcoin.fromJson(Map<String, dynamic> json) {
    return QRCodeBitcoin(
      bitcoinAddress: json['bitcoinAddress'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bitcoinAddress': bitcoinAddress,
    };
  }

  factory QRCodeBitcoin.fromMap(Map<String, dynamic> map) {
    return QRCodeBitcoin(
      bitcoinAddress: map['bitcoinAddress'] ?? '',
    );
  }

  QRCodeBitcoin copyWith({
    String? bitcoinAddress,
  }) {
    return QRCodeBitcoin(
      bitcoinAddress: bitcoinAddress ?? this.bitcoinAddress,
    );
  }
}
