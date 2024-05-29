import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

class CollectionBuilder extends StatelessWidget {
  final String data;
  const CollectionBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2, vertical: AppTheme.elementSpacing / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Avatar(),
              SizedBox(width: AppTheme.elementSpacing / 2),
              Container(
                  width: AppTheme.cardPadding * 11,
                  child: Center(
                    child: Text("$data",
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
