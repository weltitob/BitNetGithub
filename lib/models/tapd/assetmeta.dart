import 'dart:convert';

import 'package:bitnet/models/postmodels/media_model.dart';

class AssetMetaResponse {
  final String data;
  final dynamic type;
  final String metaHash;

  AssetMetaResponse(
      {required this.data, required this.type, required this.metaHash});

  factory AssetMetaResponse.fromJson(Map<String, dynamic> json) {
    return AssetMetaResponse(
      data: json['data'],
      type: json['type'],
      metaHash: json['meta_hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'type': type,
      'meta_hash': metaHash,
    };
  }

  String decodeData() {
    try {
      List<int> decodedBytes = base64Decode(data);
      return utf8.decode(decodedBytes);
    } catch (e) {
      return "Could not decode data: $data";
    }
  }

  String getType() {
    return type;
  }

  String getShortenedData() {
    String decoded = decodeData();
    if (decoded.length > 500) {
      String firstPart = decoded.substring(0, 500);
      String lastPart = firstPart.substring(firstPart.length - 20);
      return firstPart + lastPart;
    } else {
      return decoded;
    }
  }

  List<Media> toMedias() {
    String decodedData = decodeData();
    Map<String, dynamic> jsonMap;
    List<Media> medias = [];
    try {
      jsonMap = jsonDecode(decodedData);

      jsonMap.forEach((key, value) {
        medias.add(Media(type: key, data: value.toString()));
      });
    } catch (e) {
      medias = [
        Media(
            data: "Decoded data is not a valid JSON: $decodedData",
            type: "text")
      ];
    }

    return medias;
  }

  // String? findCollectionValue() {
  //   String decodedData = decodeData();
  //   Map<String, dynamic> jsonMap;
  //   try {
  //     jsonMap = jsonDecode(decodedData);
  //
  //     if (jsonMap.containsKey('collection')) {
  //       return jsonMap['collection'].toString();
  //     }
  //   } catch (e) {
  //     // Handle error if decoding or parsing fails
  //   }
  //   return null;
  // }
}
