import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSockets extends StatelessWidget {
  const ViewSockets({super.key});

  @override 
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      body:Obx(()=> ListView.builder(
        itemCount: controller.socketsData.length,
        itemBuilder: (context, index) => Text(
          '${controller.socketsData[index]}]]] \n\n',
        ),
      ),
    ));
  }
}
