import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IONLoadingScreen extends StatefulWidget {
  final String loadingText;

  const IONLoadingScreen({Key? key, required this.loadingText})
      : super(key: key);

  @override
  State<IONLoadingScreen> createState() => _IONLoadingScreenState();
}

class _IONLoadingScreenState extends State<IONLoadingScreen> {
  late final Future<LottieComposition> comp;

  @override
  void initState() {
    // TODO: implement initState
    comp = loadComposition('assets/lottiefiles/blockchain_loader.json');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // prevent the user from going back
      child: bitnetScaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding * 2),
                    child: Text(
                      widget.loadingText,
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  Container(
                    color: Colors.transparent,
                    height: AppTheme.cardPadding * 10,
                    child: FutureBuilder(
                      future: comp,
                      builder: (context, snapshot) {
                        dynamic composition = snapshot.data;
                        if (composition != null) {
                          return FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Lottie(composition: composition),
                          );
                        } else {
                          return Container(
                            color: Colors.transparent,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: AppTheme.cardPadding * 2,
              child: Container(
                width: MediaQuery.of(context).size.width, // full width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      L10n.of(context)!.poweredByDIDs,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: AppTheme.elementSpacing / 2),
                      height: AppTheme.cardPadding * 2,
                      child: Image.asset("assets/images/ion.png"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        context: context,
      ),
    );
  }
}
