import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/MostView.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/components/marketplace_widgets/TrendingSellersSlider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/firebase/postsDataModel.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.ctrler}) : super(key: key);
  final ScrollController? ctrler;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double _marginHorizontal = 30.0;
  final double _marginVertical = 15.0;
  final controller = Get.put(HomeController());
  int selectedDayIndex = 0;
  List<String> days = ['Day', 'Week', 'Month', 'Year'];
  List<ChartLine> chartData = [];
  List<Tab> myTabs = [
    Tab(text: 'Art'),
    Tab(text: 'Music'),
    Tab(text: 'Video'),
    Tab(text: 'Sport'),
  ];
  List<PostsDataModel> postsDataList = [];

  @override
  void initState() {
    super.initState();
    // Fetch posts directly
    controller.fetchPosts().then((value) {
      if (value != null) {
        setState(() {
          postsDataList = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    List<TradeData> tradeData = [
      TradeData('0', 2.2),
      TradeData('1', 3.4),
      TradeData('2', 2.8),
      TradeData('3', 1.6),
      TradeData('4', 2.3),
      TradeData('5', 2.5),
      TradeData('6', 2.9),
      TradeData('7', 3.8),
      TradeData('8', 3.7),
    ];

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: bitnetScaffold(
        context: context,
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            SizedBox(height: AppTheme.cardPadding * 0.75.h),
            // ------------------ Banner ------------------
            CarouselSlider.builder(
              options: CarouselOptions(
                height: size.height * 0.32,
                aspectRatio: 343 / 171,
                viewportFraction: 0.9,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.15,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                return FutureBuilder<List<PostsDataModel>?>(
                  future: controller.fetchPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.isNotEmpty) {
                      List<PostsDataModel> postsData = snapshot.data!;
                      if (postsData.isEmpty ||
                          postsData.length <= index) {
                        return const Center(
                          child: Text('No data'),
                        );
                      }
                      return FutureBuilder<bool?>(
                        future: controller.fetchHasLiked(
                          postsData[index].postId,
                          Auth().currentUser!.uid,
                        ),
                        builder: (context, snapshot) {
                          return AssetCard(
                            postId: postsData[index].postId,
                            hasLiked: snapshot.data ?? false,
                            hasLikeButton: true,
                            nftName: postsData[index].nftName,
                            nftMainName: postsData[index].nftMainName,
                            cryptoText: postsData[index].cryptoText,
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No data'),
                      );
                    }
                  },
                );
              },
            ),

            SizedBox(height: AppTheme.cardPadding * 0.75.h),

            // ------------------ Most Viewed ------------------
            CommonHeading(
              headingText: 'Most Viewed',
              hasButton: true,
              onPress: 'most_viewed',
            ),
            Row(
              children: [
                Expanded(
                  child: MostView(
                    nftImg: 'assets/marketplace/NftImage1.png',
                    nftName: 'Cosmic Perspective #1',
                    nftPrice: '0.45 BTC',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: MostView(
                    nftImg: 'assets/marketplace/NftImage2.png',
                    nftName: 'Cosmic Perspective #2',
                    nftPrice: '0.35 BTC',
                  ),
                ),
              ],
            ),

            SizedBox(height: AppTheme.cardPadding),

            // ------------------ Trending Sellers ------------------
            CommonHeading(
              headingText: 'Trending Sellers',
              hasButton: true,
              onPress: 'trending_sellers',
            ),
            // Using widget directly instead of function to fix error
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/marketplace/User${index+1}.png'),
                        ),
                        SizedBox(height: 8),
                        Text('User ${index+1}', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                        Text('0.${index+2} BTC', style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        )),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: AppTheme.cardPadding),

            // ------------------ Hot Drops ------------------
            Container(
              margin: EdgeInsets.symmetric(vertical: _marginVertical),
              child: Column(
                children: [
                  // Heading with more button
                  CommonHeading(
                    headingText: 'Hot Drops',
                    hasButton: true,
                    onPress: 'hot_drops',
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black12
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.colorBitcoin.withOpacity(0.3)
                              : AppTheme.colorBitcoin.withOpacity(0.2),
                        ),
                        labelColor: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.colorBitcoin
                            : AppTheme.colorBitcoin,
                        unselectedLabelColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        tabs: myTabs,
                      ),
                    ),
                  ),

                  Container(
                    height: 280,
                    child: TabBarView(
                      children: [
                        FutureBuilder<List<PostsDataModel>?>(
                          future: controller.fetchPosts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              List<PostsDataModel> postsData = snapshot.data!;
                              return ListView.builder(
                                itemCount: postsData.length > 10
                                    ? 10
                                    : postsData.length,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                itemBuilder: (context, index) {
                                  return FutureBuilder<bool?>(
                                    future: controller.fetchHasLiked(
                                      postsData[index].postId,
                                      Auth().currentUser!.uid,
                                    ),
                                    builder: (context, snapshot) {
                                      return AssetCard(
                                        postId: postsData[index].postId,
                                        hasLiked: snapshot.data ?? false,
                                        hasLikeButton: true,
                                        nftName: postsData[index].nftName,
                                        nftMainName: postsData[index].nftMainName,
                                        cryptoText: postsData[index].cryptoText,
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('No data'),
                              );
                            }
                          },
                        ),
                        ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return AssetCard(
                              postId: 'music-$index',
                              hasLiked: false,
                              hasLikeButton: true,
                              nftName: 'Music NFT',
                              nftMainName: 'Music Collection',
                              cryptoText: '0.5',
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return AssetCard(
                              postId: 'video-$index',
                              hasLiked: false,
                              hasLikeButton: true,
                              nftName: 'Video NFT',
                              nftMainName: 'Video Collection',
                              cryptoText: '0.8',
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return AssetCard(
                              postId: 'sport-$index',
                              hasLiked: false,
                              hasLikeButton: true,
                              nftName: 'Sport NFT',
                              nftMainName: 'Sport Collection',
                              cryptoText: '1.2',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 200.h),
          ],
        ),
      ),
    );
  }
}

class TradeData {
  final String x;
  final double y;

  TradeData(this.x, this.y);
}