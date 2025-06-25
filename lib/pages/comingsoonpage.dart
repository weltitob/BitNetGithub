import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:get/get.dart';

class ButtonController extends GetxController {
  var isLoading = false.obs; // Observable variable

  void toggleButtonState() {
    isLoading.value =
        !isLoading.value; // Toggle the state between true and false
  }
}

class ComingSoonPage extends StatelessWidget {
  ComingSoonPage({super.key});

  final ButtonController controller =
      Get.put(ButtonController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/monkey.webp',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: AppTheme.cardPadding * 2),
            Text(
              'Coming soon...',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.cardPadding * 2),
            Obx(() => BottomCenterButton(
                  buttonTitle: "Testbutton",
                  buttonState: controller.isLoading.value
                      ? ButtonState.loading
                      : ButtonState.idle,
                  onButtonTap: () {
                    controller.toggleButtonState();
                    // Simulate a network call or process
                    Future.delayed(Duration(seconds: 2), () {
                      // Toggle the state back after 2 seconds
                      controller.toggleButtonState();
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }
}
