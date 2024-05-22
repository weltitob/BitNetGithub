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
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 341),
  NftProductSliderModal(
      nftImage: nftImage2,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 340),
  NftProductSliderModal(
      nftImage: productImg1,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 441),
];

final nftExpireProductSliderData = [
  NftProductSliderModal(
      nftImage: nftImage4,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 342),
  NftProductSliderModal(
      nftImage: productImg2,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 451),
  NftProductSliderModal(
      nftImage: nftImage10,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 541),
];
final nftExpensiveProductSliderData = [
  NftProductSliderModal(
      nftImage: nftImage10,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2293',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 241),
  NftProductSliderModal(
      nftImage: nftImage3,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 441),
  NftProductSliderModal(
      nftImage: productImg1,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 325),
];
final nftTopSellersProductSliderData = [
  NftProductSliderModal(
      nftImage: nftImage11,
      nftName: 'Crypto-Pills',
      nftMainName: 'NFToker #2256',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 841),
  NftProductSliderModal(
      nftImage: nftImage13,
      nftName: 'Dalex-Soccer',
      nftMainName: 'Summer Mediume #9354',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 741),
  NftProductSliderModal(
      nftImage: nftImage10,
      nftName: 'Guardians of the Metaverse',
      nftMainName: 'Soccer Doge #2649',
      cryptoImage: "assets/marketplace/BitCoinIcon.png",
      cryptoText: '1.845',
      columnMargin: true,
      rank: 642),
];
final mostViewListData = [
  MostViewModal(
      nftImg: nftImage8, nftName: "SevenToken", nftPrice: "\$1,91,122"),
  MostViewModal(
      nftImg: nftImage9, nftName: "GamblingApes", nftPrice: "\$2,04,826"),
  MostViewModal(nftImg: nftImage10, nftName: "Loot", nftPrice: "\$3,11,122"),
  MostViewModal(
      nftImg: nftImage11, nftName: "CryptoAdz", nftPrice: "\$4,15,937"),
  MostViewModal(
      nftImg: nftImage12, nftName: "ArtBlocks", nftPrice: "\$5,11,222"),
  MostViewModal(
      nftImg: nftImage13, nftName: "MintPassFactor", nftPrice: "\$6,26048"),
  MostViewModal(
      nftImg: nftImage14, nftName: "SipherINU", nftPrice: "\$7,11,222"),
  MostViewModal(nftImg: nftImage4, nftName: "MetaHero", nftPrice: "\$8,37,159"),
];
final notificationListData = [
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText:
        "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: Colors.white,
  ),
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText:
        "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: const Color.fromRGBO(255, 255, 255, 0.7),
  ),
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText:
        "Lex Murphy requested access to UNIX directory tree hierarchy",
    notificationTime: "Today at 9:42 AM",
    headingColor: Colors.white,
  ),
  NotificationListModal(
    notificationImage: nftImage1,
    notificationText:
        "Lex Murphy requested access to UNIX directory tree hierarchy",
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
    cryptoIcon: bitCoinIcon,
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
    cryptoIcon: bitCoinIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  ),
  TradingHistoryListModal(
    nftImage: nftImage13,
    nftName: 'NFToker #2996',
    fromText: 'daddywarbucks',
    toText: 'chuckigsterallerchuck',
    cryptoIcon: bitCoinIcon,
    cryptoText: '1.845',
    dateText: '15/9/2021',
  )
];

final gridListData = [
  GridListModal(
    id: 0,
    nftImage: nftImage1,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2293',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.045',
    columnMargin: false,
    sold: false,
    date: DateTime(2019, 3, 15),
    rank: 512,
  ),
  GridListModal(
    id: 1,
    nftImage: nftImage4,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.815',
    columnMargin: false,
    sold: false,
    date: DateTime(2018, 7, 22),
    rank: 789,
  ),
  GridListModal(
    id: 2,
    nftImage: nftImage11,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.023',
    columnMargin: false,
    sold: false,
    date: DateTime(2022, 1, 8),
    rank: 123,
  ),
  GridListModal(
    id: 3,
    nftImage: nftImage2,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2293',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.011',
    columnMargin: false,
    sold: false,
    date: DateTime(2017, 10, 5),
    rank: 456,
  ),
  GridListModal(
    id: 4,
    nftImage: nftImage10,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2293',
    cryptoImage: bitCoinIcon,
    cryptoText: '0.011',
    columnMargin: false,
    sold: false,
    date: DateTime(2020, 4, 12),
    rank: 890,
  ),
  GridListModal(
    id: 5,
    nftImage: nftImage2,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.333',
    columnMargin: false,
    sold: true,
    date: DateTime(2023, 2, 28),
    rank: 234,
  ),
  GridListModal(
    id: 6,
    nftImage: nftImage9,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.645',
    columnMargin: false,
    sold: true,
    date: DateTime(2017, 12, 10),
    rank: 567,
  ),
  GridListModal(
    id: 7,
    nftImage: nftImage13,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2293',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.555',
    columnMargin: false,
    sold: true,
    date: DateTime(2018, 5, 19),
    rank: 321,
  ),
  GridListModal(
    id: 8,
    nftImage: nftImage3,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2293',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.145',
    columnMargin: false,
    sold: true,
    date: DateTime(2021, 9, 3),
    rank: 654,
  ),
  GridListModal(
    id: 9,
    nftImage: nftImage4,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '0.945',
    columnMargin: false,
    sold: false,
    date: DateTime(2019, 11, 14),
    rank: 987,
  ),
];

final favouriteListData = [
  GridListModal(
    id: 0,
    nftImage: nftImage11,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '2.845',
    columnMargin: false,
    sold: false,
    date: DateTime(2022, 8, 17),
    rank: 789,
  ),
  GridListModal(
    id: 1,
    nftImage: nftImage4,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '0.845',
    columnMargin: false,
    sold: false,
    date: DateTime(2019, 6, 3),
    rank: 234,
  ),
  GridListModal(
    id: 2,
    nftImage: nftImage9,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.345',
    columnMargin: false,
    sold: false,
    date: DateTime(2020, 10, 12),
    rank: 567,
  ),
  GridListModal(
    id: 3,
    nftImage: nftImage2,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.645',
    columnMargin: false,
    sold: false,
    date: DateTime(2018, 4, 28),
    rank: 321,
  ),
  GridListModal(
    id: 4,
    nftImage: nftImage4,
    nftName: 'Crypto-Pills',
    nftMainName: 'NFToker #2256',
    cryptoImage: bitCoinIcon,
    cryptoText: '1.8',
    columnMargin: false,
    sold: false,
    date: DateTime(2021, 1, 5),
    rank: 456,
  ),
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
  CoinPillLabelModal(coinImg: bitCoinIcon, labelText: "Crypto-Pills"),
  CoinPillLabelModal(coinImg: bitCoinIcon, labelText: "Dalex-Soccer"),
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
