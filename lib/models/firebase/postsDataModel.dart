import 'dart:convert';

PostsDataModel postsDataModelFromJson(String str) =>
    PostsDataModel.fromJson(json.decode(str));

class PostsDataModel {
  bool hasLiked;
  bool hasPrice;
  bool hasLikeButton;
  String nftName;
  String postId;
  String nftMainName;
  String cryptoText;
  int createdAt;

  PostsDataModel({
    required this.hasLiked,
    required this.hasPrice,
    required this.hasLikeButton,
    required this.postId,
    required this.nftName,
    required this.nftMainName,
    required this.cryptoText,
    required this.createdAt,
  });

  factory PostsDataModel.fromJson(Map<String, dynamic> json) => PostsDataModel(
        hasLiked: json["hasLiked"],
        hasPrice: json["hasPrice"],
        hasLikeButton: json["hasLikeButton"],
        nftName: json["nftName"],
        nftMainName: json["nftMainName"],
        postId: json["postId"],
        cryptoText: json["cryptoText"],
        createdAt: json["createdAt"],
      );
}
