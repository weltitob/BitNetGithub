class NftDropSliderModal {
  final nftImage;
  final nftName;

  NftDropSliderModal({
    required this.nftImage,
    required this.nftName,
  });
}

class TrendingSellersSliderModal {
  final nftImage;
  final userImage;
  final nftName;

  TrendingSellersSliderModal({
    required this.nftImage,
    required this.userImage,
    required this.nftName,
  });
}

class NftProductSliderModal {
  final nftImage;
  final cryptoImage;
  final nftName;
  final nftMainName;
  final cryptoText;
  final columnMargin;
  final rank;

  NftProductSliderModal(
      {required this.nftImage,
      required this.cryptoImage,
      required this.nftName,
      required this.nftMainName,
      required this.cryptoText,
      required this.columnMargin,
      required this.rank});
}

class MostViewModal {
  final nftImg;
  final nftName;
  final nftPrice;

  MostViewModal({
    required this.nftImg,
    required this.nftName,
    required this.nftPrice,
  });
}

class GridListModal {
  final nftImage;
  final cryptoImage;
  final nftName;
  final nftMainName;
  final cryptoText;
  final columnMargin;
  final sold;
  final DateTime date;
  final rank;
  final id;

  GridListModal(
      {required this.id,
      required this.nftImage,
      required this.cryptoImage,
      required this.nftName,
      required this.nftMainName,
      required this.cryptoText,
      required this.columnMargin,
      required this.sold,
      required this.date,
      required this.rank});
}

class PillLabelModal {
  final labelText;

  PillLabelModal({
    required this.labelText,
  });
}

class CoinPillLabelModal {
  final coinImg;
  final labelText;

  CoinPillLabelModal({
    required this.coinImg,
    required this.labelText,
  });
}

class CollectionFilterListModal {
  final collectionImg;
  final collectionName;

  CollectionFilterListModal({
    required this.collectionImg,
    required this.collectionName,
  });
}

class TradingHistoryListModal {
  final nftImage;
  final nftName;
  final fromText;
  final toText;
  final cryptoIcon;
  final cryptoText;
  final dateText;

  TradingHistoryListModal({
    required this.nftImage,
    required this.nftName,
    required this.fromText,
    required this.toText,
    required this.cryptoIcon,
    required this.cryptoText,
    required this.dateText,
  });
}

class PropertieListModal {
  final heading;
  final subHeading;
  final peragraph;

  PropertieListModal({
    required this.heading,
    required this.subHeading,
    required this.peragraph,
  });
}

class NotificationListModal {
  final notificationImage;
  final notificationText;
  final notificationTime;
  final headingColor;

  NotificationListModal({
    required this.notificationImage,
    required this.notificationText,
    required this.notificationTime,
    required this.headingColor,
  });
}

class CategoriesListModal {
  final categoriesText;

  CategoriesListModal({
    required this.categoriesText,
  });
}

class NFTAsset {
  final String id;
  final String name;
  final String collection;
  final String imageUrl;
  final String? description;
  final double? currentPrice;
  final String? owner;
  final bool isListed;

  NFTAsset({
    required this.id,
    required this.name,
    required this.collection,
    required this.imageUrl,
    this.description,
    this.currentPrice,
    this.owner,
    this.isListed = false,
  });

  /// Create an NFTAsset from an AssetCard
  static NFTAsset fromAssetCard({
    required String? assetId,
    required String? nftName,
    required String? nftMainName,
    required String? imageUrl,
    String? owner,
    bool isListed = false,
  }) {
    return NFTAsset(
      id: assetId ?? '',
      name: nftName ?? 'Asset',
      collection: nftMainName ?? 'Collection',
      imageUrl: imageUrl ?? '',
      isListed: isListed,
      owner: owner ?? '',
    );
  }

  /// Create an NFTAsset from a post with image media
  static NFTAsset fromPost({
    required String postId,
    required String postName,
    required String collection,
    required String imageUrl,
    required String owner,
    bool isListed = false,
  }) {
    return NFTAsset(
      id: postId,
      name: postName,
      collection: collection,
      imageUrl: imageUrl,
      isListed: isListed,
      owner: owner,
    );
  }
}
