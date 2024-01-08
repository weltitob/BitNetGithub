import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:flutter/material.dart';

final nftDropSliderData = [
  NftDropSliderModal(
    nftImage: nftImage1,
    nftName: 'NFToker #2293',
  ),
  NftDropSliderModal(
    nftImage: nftImage2,
    nftName: 'Soccer Doge #2649',
  ),
  NftDropSliderModal(
    nftImage: nftImage3,
    nftName: 'NFToker #2293',
  ),
  NftDropSliderModal(
    nftImage: nftImage4,
    nftName: 'Soccer Doge #2649',
  ),
];

final trendingSellersSliderData = [
  TrendingSellersSliderModal(
    nftImage: nftImage5,
    nftName: 'Crypto-Pills',
    userImage: "assets/marketplace/User1.png",
  ),
  TrendingSellersSliderModal(
    nftImage: nftImage6,
    nftName: 'Dalex-Soccer',
    userImage: "assets/marketplace/User2.png",
  ),
  TrendingSellersSliderModal(
    nftImage: nftImage7,
    nftName: 'Moon-Shiller',
    userImage: "assets/marketplace/User3.png",
  )
];

final nftHotProductSliderData = [
  NftProductSliderModal(
      nftImage: nftImage1,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: "assets/marketplace/EthereumIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
  NftProductSliderModal(
      nftImage: nftImage2,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/EthereumIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
  NftProductSliderModal(
      nftImage: productImg1,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/EthereumIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
];
final nftExpireProductSliderData = [
  NftProductSliderModal(
      nftImage: nftImage4,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
  NftProductSliderModal(
      nftImage: productImg2,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
  NftProductSliderModal(
      nftImage: nftImage10,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
];
final nftExpensiveProductSliderData = [
  NftProductSliderModal(
      nftImage: nftImage10,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: "assets/marketplace/EthereumIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
  NftProductSliderModal(
      nftImage: nftImage3,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/EthereumIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
  NftProductSliderModal(
      nftImage: productImg1,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/EthereumIcon.png",
      cryptoText: '1.845',
      columnMargin: true),
];
final nftTopSellersProductSliderData = [
  NftProductSliderModal(
    nftImage: nftImage11,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: "assets/marketplace/BitCoinIcon.png",
    cryptoText: '1.845',
    columnMargin: true,
  ),
  NftProductSliderModal(
    nftImage: nftImage13,
    nftName: 'Dalex-Soccer',
    nftMainName: 'Summer Mediume #9354',
    cryptoImage: "assets/marketplace/BitCoinIcon.png",
    cryptoText: '1.845',
    columnMargin: true,
  ),
  NftProductSliderModal(
    nftImage: nftImage10,
    nftName: 'Guardians of the Metaverse',
    nftMainName: 'Soccer Doge #2649',
    cryptoImage: "assets/marketplace/BitCoinIcon.png",
    cryptoText: '1.845',
    columnMargin: true,
  ),
];
final mostViewListData = [
  MostViewModal(
      nftImg: nftImage8,
      nftName: "SevenToken",
      nftPrice: "\$1,91,122"),
  MostViewModal(
      nftImg: nftImage9,
      nftName: "GamblingApes",
      nftPrice: "\$2,04,826"),
  MostViewModal(
      nftImg: nftImage10,
      nftName: "Loot",
      nftPrice: "\$3,11,122"),
  MostViewModal(
      nftImg: nftImage11,
      nftName: "CryptoAdz",
      nftPrice: "\$4,15,937"),
  MostViewModal(
      nftImg: nftImage12,
      nftName: "ArtBlocks",
      nftPrice: "\$5,11,222"),
  MostViewModal(
      nftImg: nftImage13,
      nftName: "MintPassFactor",
      nftPrice: "\$6,26048"),
  MostViewModal(
      nftImg: nftImage14,
      nftName: "SipherINU",
      nftPrice: "\$7,11,222"),
  MostViewModal(
      nftImg: nftImage4,
      nftName: "MetaHero",
      nftPrice: "\$8,37,159"),
];
final notificationListData = [
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText: "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: Colors.white,
  ),
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText: "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: const Color.fromRGBO(255, 255, 255, 0.7),
  ),
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText: "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: Colors.white,
  ),
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText: "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: const Color.fromRGBO(255, 255, 255, 0.7),
  ),
];
final categoriesListData = [
  CategoriesListModal(
    categoriesText: "Art",
  ),
  CategoriesListModal(
    categoriesText: "Music",
  ),
  CategoriesListModal(
    categoriesText: "Domain Names",
  ),
  CategoriesListModal(
    categoriesText: "Virtual Worlds",
  ),
  CategoriesListModal(
    categoriesText: "Trading Cards",
  ),
  CategoriesListModal(
    categoriesText: "Collectibles",
  ),
  CategoriesListModal(
    categoriesText: "Sports",
  ),
  CategoriesListModal(
    categoriesText: "Utility",
  ),
];

final tradingHistoryListData = [
  TradingHistoryListModal(
    nftImage: nftImage4,
    nftName: 'NFToker #2256',
    fromText: 'Babytronz',
    toText: 'apejo',
    cryptoIcon: bitCoinIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  ),
  TradingHistoryListModal(
    nftImage: nftImage1,
    nftName: 'NFToker #2293',
    fromText: 'PapitoChongAMG',
    toText: 'Caxaas',
    cryptoIcon: ethereumIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  ),
  TradingHistoryListModal(
    nftImage: nftImage2,
    nftName: 'NFToker #2649',
    fromText: 'AnonymousCrypto',
    toText: 'Phil_C',
    cryptoIcon: bitCoinIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  ),
  TradingHistoryListModal(
    nftImage: nftImage10,
    nftName: 'NFToker #2956',
    fromText: 'cannonballcam',
    toText: 'yachtingnft',
    cryptoIcon: ethereumIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  ),
  TradingHistoryListModal(
    nftImage: nftImage13,
    nftName: 'NFToker #2996',
    fromText: 'daddywarbucks',
    toText: 'chuckigsterallerchuck',
    cryptoIcon: ethereumIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  )
];

final gridListData = [
  GridListModal(
      nftImage: nftImage1,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: ethereumIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage4,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage11,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage2,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: ethereumIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage10,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: ethereumIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage2,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage9,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage13,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: ethereumIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage3,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: ethereumIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage4,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
];

final favouriteListData = [
  GridListModal(
      nftImage: nftImage11,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage4,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage9,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage2,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
  GridListModal(
      nftImage: nftImage4,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: bitCoinIcon,
      cryptoText: '1.845',
      columnMargin: false),
];

final statusPillListData = [
  PillLabelModal(labelText: "Buy Now"),
  PillLabelModal(labelText: "New"),
  PillLabelModal(labelText: "Has Offers"),
];
final sortByPillListData = [
  PillLabelModal(labelText: "Recently Listed"),
  PillLabelModal(labelText: "Recently Created"),
  PillLabelModal(labelText: "Recently Sold"),
  PillLabelModal(labelText: "Recently Received"),
  PillLabelModal(labelText: "Ending Soon"),
  PillLabelModal(labelText: "Price: Low to High"),
  PillLabelModal(labelText: "Price: High to Low"),
  PillLabelModal(labelText: "Highest Last Sale"),
  PillLabelModal(labelText: "Most Viewed"),
  PillLabelModal(labelText: "Most Favourited"),
  PillLabelModal(labelText: "Oldest"),
];
final collectionListData = [
  CollectionFilterListModal(
      collectionImg: user1Image, collectionName: "Crypto-Pills"),
  CollectionFilterListModal(
      collectionImg: user2Image, collectionName: "Dalex-Soccer"),
  CollectionFilterListModal(
      collectionImg: user3Image, collectionName: "Moon-Shiller"),
];
final chainListData = [
  CoinPillLabelModal(
      coinImg: bitCoinIcon, labelText: "Crypto-Pills"),
  CoinPillLabelModal(
      coinImg: ethereumIcon, labelText: "Dalex-Soccer"),
];
final categoriesLabelListData = [
  PillLabelModal(labelText: "Art"),
  PillLabelModal(labelText: "Music"),
  PillLabelModal(labelText: "Domain Names"),
  PillLabelModal(labelText: "Collectibles"),
  PillLabelModal(labelText: "Virtual Worlds"),
  PillLabelModal(labelText: "Trading Cards"),
  PillLabelModal(labelText: "Sports"),
  PillLabelModal(labelText: "Utility"),
];

final propertieList = [
  PropertieListModal(
      heading: 'Headwear',
      subHeading: 'Master Helmet',
      peragraph: '7% have this trait'),
  PropertieListModal(
      heading: 'Chestwear',
      subHeading: 'Master Jacket',
      peragraph: '7% have this trait'),
  PropertieListModal(
      heading: 'Back',
      subHeading: 'Darker Black',
      peragraph: '7% have this trait'),
  PropertieListModal(
      heading: 'Type', subHeading: 'Female', peragraph: '7% have this trait'),
];
