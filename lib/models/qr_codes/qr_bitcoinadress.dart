// This class represents a QR code for a Bitcoin address.
class QR_BitcoinAddress {
  String bitcoinAddress; // The Bitcoin address encoded in the QR code.

  // Constructor that creates a [QRCodeBitcoin] instance.
  QR_BitcoinAddress({
    required this.bitcoinAddress,
  });

  // Factory method that creates a [QRCodeBitcoin] instance from a JSON map.
  factory QR_BitcoinAddress.fromJson(Map<String, dynamic> json) {
    return QR_BitcoinAddress(
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
  factory QR_BitcoinAddress.fromMap(Map<String, dynamic> map) {
    return QR_BitcoinAddress(
      bitcoinAddress: map['bitcoinAddress'] ?? '',
    );
  }

  // Method that creates a copy of a [QRCodeBitcoin] instance with new values.
  QR_BitcoinAddress copyWith({
    String? bitcoinAddress,
  }) {
    return QR_BitcoinAddress(
      bitcoinAddress: bitcoinAddress ?? this.bitcoinAddress,
    );
  }
}
