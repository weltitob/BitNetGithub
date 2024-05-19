class BitcoinAddress {
  final String addr;
  BitcoinAddress({required this.addr});

  // Factory constructor for creating a new BitcoinAddress instance from a map (JSON).
  factory BitcoinAddress.fromJson(Map<String, dynamic> json) {
    return BitcoinAddress(
      addr: json['addr'] ?? '',
    );
  }

  // Method to determine the address type
  String getAddressType() {
    if (addr.startsWith('bc1q')) {
      return 'Bech32 (SegWit)';
    } else if (addr.startsWith('bc1p')) {
      return 'Bech32m (Taproot)';
    } else if (addr.startsWith('1')) {
      return 'P2PKH';
    } else if (addr.startsWith('3')) {
      return 'P2SH';
    } else {
      return 'Unknown';
    }
  }
}
