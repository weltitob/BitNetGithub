import 'dart:convert';

class Swap {
  final int amt;
  final String id;
  final String idBytes;
  final String type;
  final String state;
  final String failureReason;
  final int initiationTime;
  final int lastUpdateTime;
  final String htlcAddress;
  final String htlcAddressP2wsh;
  final String htlcAddressP2tr;
  final int costServer;
  final int costOnchain;
  final int costOffchain;
  final String lastHop;
  final List<dynamic> outgoingChanSet;
  final String label;

  Swap({
    required this.amt,
    required this.id,
    required this.idBytes,
    required this.type,
    required this.state,
    required this.failureReason,
    required this.initiationTime,
    required this.lastUpdateTime,
    required this.htlcAddress,
    required this.htlcAddressP2wsh,
    required this.htlcAddressP2tr,
    required this.costServer,
    required this.costOnchain,
    required this.costOffchain,
    required this.lastHop,
    required this.outgoingChanSet,
    required this.label,
  });

  factory Swap.fromJson(Map<String, dynamic> json) {
    return Swap(
      amt: json['amt'],
      id: json['id'],
      idBytes: json['id_bytes'],
      type: json['type'],
      state: json['state'],
      failureReason: json['failure_reason'],
      initiationTime: json['initiation_time'],
      lastUpdateTime: json['last_update_time'],
      htlcAddress: json['htlc_address'],
      htlcAddressP2wsh: json['htlc_address_p2wsh'],
      htlcAddressP2tr: json['htlc_address_p2tr'],
      costServer: json['cost_server'],
      costOnchain: json['cost_onchain'],
      costOffchain: json['cost_offchain'],
      lastHop: json['last_hop'],
      outgoingChanSet: List<dynamic>.from(json['outgoing_chan_set']),
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amt': amt,
      'id': id,
      'id_bytes': idBytes,
      'type': type,
      'state': state,
      'failure_reason': failureReason,
      'initiation_time': initiationTime,
      'last_update_time': lastUpdateTime,
      'htlc_address': htlcAddress,
      'htlc_address_p2wsh': htlcAddressP2wsh,
      'htlc_address_p2tr': htlcAddressP2tr,
      'cost_server': costServer,
      'cost_onchain': costOnchain,
      'cost_offchain': costOffchain,
      'last_hop': lastHop,
      'outgoing_chan_set': outgoingChanSet,
      'label': label,
    };
  }
}

class SwapList {
  final List<Swap> swaps;

  SwapList({required this.swaps});

  factory SwapList.fromJson(Map<String, dynamic> json) {
    return SwapList(
      swaps: List<Swap>.from(json['swaps'].map((x) => Swap.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'swaps': List<dynamic>.from(swaps.map((x) => x.toJson())),
    };
  }
}