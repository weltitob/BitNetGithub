class InvoiceModel {
  String r_hash;
  String payment_request;
  String add_index;
  String payment_addr;

  // Constructor
  InvoiceModel({
    required this.r_hash,
    required this.payment_addr,
    required this.add_index,
    required this.payment_request,
  });

  // Factory method to create an InvoiceModel instance from a JSON map
  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      r_hash: json['r_hash'].toString(),
      payment_addr: json['payment_addr'].toString(),
      add_index: json['add_index'].toString(),
      payment_request: json['payment_request'].toString(),
    );
  }

  // Method to convert an InvoiceModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'r_hash': r_hash,
      'payment_request': payment_request,
      'add_index': add_index,
      'payment_addr': payment_addr,
    };
  }

  // Method to create a new InvoiceModel instance from the existing instance with updated values
  InvoiceModel copyWith({
    String? r_hash,
    String? payment_request,
    String? add_index,
    String? payment_addr,
  }) {
    return InvoiceModel(
      r_hash: r_hash ?? this.r_hash,
      payment_request: payment_request ?? this.payment_request,
      add_index: add_index ?? this.add_index,
      payment_addr: payment_addr ?? this.payment_addr,
    );
  }

  @override
  String toString() {
    return 'InvoiceModel{r_hash: \$r_hash, payment_request: \$payment_request, add_index: \$add_index, payment_addr: \$payment_addr}';
  }
}
