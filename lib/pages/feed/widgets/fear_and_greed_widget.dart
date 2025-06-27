import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/model/fear_gear_chart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

class FearAndGreedWidget extends StatefulWidget {
  const FearAndGreedWidget({super.key});

  @override
  State<FearAndGreedWidget> createState() => _FearAndGreedWidgetState();
}

class _FearAndGreedWidgetState extends State<FearAndGreedWidget> {
  String formattedDate = '';
  bool _loading = false;
  FearGearChartModel fearGearChartModel = FearGearChartModel();

  @override
  void initState() {
    super.initState();
    getFearChart();
  }

  getFearChart() async {
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;
    var dio = Dio();
    try {
      setState(() {
        _loading = true;
      });
      var response =
          await dio.get('https://fear-and-greed-index.p.rapidapi.com/v1/fgi',
              options: Options(headers: {
                'X-RapidAPI-Key':
                    'd9329ded30msh2e4ed90bed55972p1162f9jsn68d0a91b20ff',
                'X-RapidAPI-Host': 'fear-and-greed-index.p.rapidapi.com'
              }));

      if (response.statusCode == 200) {
        fearGearChartModel = FearGearChartModel.fromJson(response.data);
        if (fearGearChartModel.lastUpdated != null) {
          DateTime dateTime =
              DateTime.parse(fearGearChartModel.lastUpdated!.humanDate!)
                  .toUtc()
                  .add(Duration(milliseconds: loc.currentTimeZone.offset));
          formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
        }
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 220, // Reduced height for slider design
      customShadow: Theme.of(context).brightness == Brightness.dark ? [] : null,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and View More Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  L10n.of(context)!.fearAndGreedIndex,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.push('/wallet/bitcoinscreen/fearandgreed');
                  },
                  child: Text(
                    'View more',
                    style: TextStyle(color: AppTheme.colorBitcoin),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppTheme.elementSpacing),

            // Content
            _loading
                ? Center(child: dotProgress(context))
                : Column(
                    children: [
                      // Value indicator text
                      Align(
                        alignment:
                            (fearGearChartModel.fgi?.now?.value ?? 0) >= 25
                                ? (fearGearChartModel.fgi?.now?.value ?? 0) > 75
                                    ? Alignment.topRight
                                    : Alignment.topCenter
                                : Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            text: L10n.of(context)!.now,
                            style: Theme.of(context).textTheme.titleMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: fearGearChartModel.fgi?.now?.valueText ??
                                    "N/A",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: (fearGearChartModel
                                                        .fgi?.now?.value ??
                                                    0) >=
                                                25
                                            ? (fearGearChartModel
                                                            .fgi?.now?.value ??
                                                        0) >
                                                    75
                                                ? AppTheme.successColor
                                                : AppTheme.colorBitcoin
                                            : AppTheme.errorColor),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: AppTheme.elementSpacing),

                      // Slider with gradient background
                      Container(
                        height: 60,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Gradient background bar
                            Container(
                              height: 16,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.errorColor,
                                    AppTheme.errorColor,
                                    AppTheme.colorBitcoin,
                                    AppTheme.colorBitcoin,
                                    AppTheme.successColor,
                                    AppTheme.successColor,
                                  ],
                                  stops: [0.0, 0.25, 0.25, 0.75, 0.75, 1.0],
                                ),
                              ),
                            ),
                            // Value indicator
                            Positioned(
                              left: ((fearGearChartModel.fgi?.now?.value ?? 0) /
                                      100) *
                                  (MediaQuery.of(context).size.width -
                                      AppTheme.cardPadding * 4),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Value bubble
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color:
                                          (fearGearChartModel.fgi?.now?.value ??
                                                      0) >=
                                                  25
                                              ? (fearGearChartModel.fgi?.now
                                                              ?.value ??
                                                          0) >
                                                      75
                                                  ? AppTheme.successColor
                                                  : AppTheme.colorBitcoin
                                              : AppTheme.errorColor,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      '${fearGearChartModel.fgi?.now?.value ?? 0}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  // Pointer arrow
                                  CustomPaint(
                                    size: Size(12, 6),
                                    painter: TrianglePainter(
                                      color:
                                          (fearGearChartModel.fgi?.now?.value ??
                                                      0) >=
                                                  25
                                              ? (fearGearChartModel.fgi?.now
                                                              ?.value ??
                                                          0) >
                                                      75
                                                  ? AppTheme.successColor
                                                  : AppTheme.colorBitcoin
                                              : AppTheme.errorColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: AppTheme.elementSpacing),

                      // Fear/Greed labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Extreme Fear',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.errorColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            'Extreme Greed',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.successColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),

                      // Last updated date
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          '${L10n.of(context)!.lastUpdated} $formattedDate',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
