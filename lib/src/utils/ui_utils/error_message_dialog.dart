import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_magazin/src/config/themes/get_theme.dart';
import 'package:task_magazin/src/utils/extensions/size_extension.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';
import 'package:task_magazin/src/utils/resources/app_icons.dart';
import 'package:task_magazin/src/utils/resources/app_images.dart';
void showErrorMessage({
  required String message,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor:
              getTheme(context) ? AppColors.dark2 : AppColors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(AppIcons.errorLottie),
              30.h,
              Text('ERROR!',
                  style: Theme.of(context).dialogTheme.titleTextStyle),
              16.h,
              Center(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              16.h,
              SizedBox(
                height: 78,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok")),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Future<void> showConfirmMessage({
  required String message,
  required BuildContext context,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor:
              getTheme(context) ? AppColors.dark2 : AppColors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.createNewPasswordDialog,
                width: 180,
              ),
              30.h,
              Text('Congratulations!',
                  style: Theme.of(context).dialogTheme.titleTextStyle),
              16.h,
              Center(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              16.h,
              SizedBox(
                height: 78,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok")),
              ),
            ],
          ),
        );
      },
    ),
  );
}
