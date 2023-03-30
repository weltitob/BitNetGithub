// This class represents a QR code for a Bitcoin address.
class QRCodeBitcoin {
  String bitcoinAddress; // The Bitcoin address encoded in the QR code.

  // Constructor that creates a [QRCodeBitcoin] instance.
  QRCodeBitcoin({
    required this.bitcoinAddress,
  });

  // Factory method that creates a [QRCodeBitcoin] instance from a JSON map.
  factory QRCodeBitcoin.fromJson(Map<String, dynamic> json) {
    return QRCodeBitcoin(
      bitcoinAddress: json['bitcoinAddress'].toString(),
    );
  }

  // Method that converts a [QRCodeBitcoin] instance to a map.
  Map<String, dynamic> toMap() {
    return {
      'bitcoinAddress': bitcoinAddress,
    };
  }

  // Factory method that creates a [QRCodeBitcoin] instance from a map.
  factory QRCodeBitcoin.fromMap(Map<String, dynamic> map) {
    return QRCodeBitcoin(
      bitcoinAddress: map['bitcoinAddress'] ?? '',
    );
  }

  // Method that creates a copy of a [QRCodeBitcoin] instance with new values.
  QRCodeBitcoin copyWith({
    String? bitcoinAddress,
  }) {
    return QRCodeBitcoin(
      bitcoinAddress: bitcoinAddress ?? this.bitcoinAddress,
    );
  }
}