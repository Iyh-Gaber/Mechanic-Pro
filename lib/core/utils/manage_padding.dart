

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ManagePadding on num {
  
  EdgeInsets get all => EdgeInsets.all(sp);

 
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: sp);

 
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: sp);
  

  EdgeInsets get top => EdgeInsets.only(top:sp);
  // padding: 17.all, 
}