import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class CollectionBuilder extends StatelessWidget {
  final String data;
  const CollectionBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
      child: GlassContainer(
        borderRadius: AppTheme.elementSpacing * 1.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing,
              vertical: AppTheme.elementSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Collection",
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis),
              Container(
                  child: Text("$data",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }
}
