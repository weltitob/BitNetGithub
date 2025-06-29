import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);
  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [
      _ChartData('Jan', 18),
      _ChartData('Feb', 21),
      _ChartData('Mar', 28),
      _ChartData('Apr', 39),
      _ChartData('May', 46),
      _ChartData('Jun', 55),
      _ChartData('Jul', 55),
      _ChartData('Aug', 46),
      _ChartData('Sep', 39),
      _ChartData('Oct', 28),
      _ChartData('Nov', 20),
      _ChartData('Dec', 18),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  String dropdownvalue = 'Last 7 Days';
  var items = [
    'Last 7 Days',
    'Last 1 Month',
    'Last 6 Months',
    'Last 1 Year',
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 30.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color.fromRGBO(255, 255, 255, 0.1),
      ),
      width: size.width,
      child: Column(
        children: [
          Container(
            height: 20.h,
            margin: EdgeInsets.only(bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '7 Days avg. price',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                ),
                DropdownButton(
                  value: dropdownvalue,
                  icon: Container(
                    width: 10.w,
                    height: 10.w,
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: const Color.fromRGBO(255, 255, 255, 0.1),
                    ),
                    child: Image.asset(
                      bottomArrowIcon,
                      width: 4.w,
                      height: 2.w,
                    ),
                  ),
                  dropdownColor: const Color.fromRGBO(24, 31, 39, 1),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                  underline: Container(
                    height: 0,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(255, 255, 255, 0.5),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          SfCartesianChart(
            margin: EdgeInsets.all(0.w),
            plotAreaBorderWidth: 0,
            enableAxisAnimation: false, // Disable animation for consistent UX
            primaryXAxis: CategoryAxis(
              majorTickLines: const MajorTickLines(color: Colors.transparent),
              maximumLabels: 12,
              labelStyle: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Lexend",
                color: const Color.fromRGBO(255, 255, 255, 0.5),
              ),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: AxisLine(
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                width: 2.h,
                dashArray: <double>[5, 5],
              ),
            ),
            primaryYAxis: NumericAxis(
              minorTickLines: const MinorTickLines(color: Colors.transparent),
              majorTickLines: const MajorTickLines(color: Colors.transparent),
              labelStyle: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Lexend",
                color: const Color.fromRGBO(255, 255, 255, 0.5),
              ),
              labelFormat: '\${value}k',
              axisLine: AxisLine(width: 0.h),
              majorGridLines: MajorGridLines(
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                width: 2.h,
                dashArray: const <double>[5, 5],
              ),
            ),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                color: const Color.fromRGBO(97, 90, 232, 1),
                animationDuration: 0, // Disable animation for consistent UX
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
