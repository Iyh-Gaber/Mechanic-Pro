import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension MangeSpacing on num {
  Widget get verticalSpace => SizedBox(height: sp);

  Widget get horizontalSpace => SizedBox(width: w);
}

// used     ----- 100.verticalSpace,
