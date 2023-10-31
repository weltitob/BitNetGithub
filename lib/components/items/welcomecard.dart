import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            const BalanceBackground2(),
            Positioned(
              right: -AppTheme.elementSpacing,
              bottom: -AppTheme.elementSpacing,
              child: SizedBox(
                height: AppTheme.cardPadding * 8,
                width: AppTheme.cardPadding * 8,
                child: LottieBuilder.asset(
                  "assets/lottiefiles/rocket.json",
                  repeat: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to your',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "NexusWallet",
                    // NumberFormat.simpleCurrency().format(MockBalance.data.last),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing,
                          vertical: AppTheme.elementSpacing / 2),
                      child: Text(
                        "Simple & Fast",
                        // NumberFormat.simpleCurrency().format(MockBalance.data.last),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
