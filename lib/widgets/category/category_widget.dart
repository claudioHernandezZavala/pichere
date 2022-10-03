import 'package:flutter/cupertino.dart';

import '../../utils/app_colors.dart';

Widget categoryWidget({required String categoryName}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
            colors: [AppColors.negativeColor1, AppColors.negativeColor2])),
  );
}
