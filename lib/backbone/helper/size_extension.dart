import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeExtensionSafe on num {
  double get ws => kIsWeb ? this.toDouble() : ScreenUtil().setWidth(this);
  double get hs => kIsWeb ? this.toDouble() : ScreenUtil().setHeight(this);

}