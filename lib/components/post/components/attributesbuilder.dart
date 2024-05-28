import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/PropertieList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// USED FOR UPLOAD SCREEN (USER PICKS FILE LOCALLY)
class AttributesBuilder extends StatelessWidget {
  final String attributes;

  const AttributesBuilder({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> propertyList = [];

    try {
      final List<dynamic> jsonData = json.decode(attributes);
      final propertyList = jsonData.map((item) => {
        'trait_type': item['trait_type'],
        'value': item['value']
      }).toList();
    } catch (e) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CommonHeading(
          headingText: 'Properties',
          hasButton: false,
          collapseBtn: true,
          child: Container(
            margin: EdgeInsets.only(bottom: 30.w),
            child: Text('Error parsing attributes: $e $attributes'),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CommonHeading(
        headingText: 'Properties',
        hasButton: false,
        collapseBtn: true,
        child: Container(
          margin: EdgeInsets.only(bottom: 30.w),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.7, // 9.1 / 4.5
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: propertyList.length,
            itemBuilder: (BuildContext context, int index) {
              return PropertieList(
                heading: propertyList[index]['trait_type'] ?? '',
                subHeading: propertyList[index]['value'] ?? '',
                peragraph: '',
              );
            },
          ),
        ),
      ),
    );
  }
}
