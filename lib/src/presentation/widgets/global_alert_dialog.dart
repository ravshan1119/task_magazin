import 'package:flutter/material.dart';
import 'package:task_magazin/src/config/themes/get_theme.dart';
import 'package:task_magazin/src/presentation/widgets/global_button.dart';
import 'package:task_magazin/src/utils/extensions/size_extension.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';
import 'package:task_magazin/src/utils/resources/app_text_styles.dart';

void showGlobalAlertDialog(
    {required BuildContext context,
    required String title,
    String text = "",
    required String image,
    required VoidCallback onTap}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Container(
          padding: const EdgeInsets.only(top: 40, left: 32, right: 32, bottom: 32),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                width: 160,
                height: 160,
              ),
              32.h,
              Text(
                title,
                style: AppTextStyle.h4Bold
                    .copyWith(color: getTheme(context) ? AppColors.primary : AppColors.c_900),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              16.h,
              Text(
                text,
                style: AppTextStyle.bodyLargeRegular
                    .copyWith(color: getTheme(context) ? AppColors.white : AppColors.c_900),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              32.h,
              GlobalButton(
                title: "ok",
                textColor: AppColors.c_900,
                onTap: onTap,
                radius: 100,
              )
            ],
          ),
        ),
        contentPadding: EdgeInsets.zero,
      );
    },
  );
}
