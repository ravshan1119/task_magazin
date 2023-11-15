import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_magazin/src/utils/resources/app_icons.dart';



void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(),
          child:  Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(AppIcons.loadingLottie),
            ),
          ),
        ),
      );
    },
  );
}

void hideLoading({required BuildContext? context}) async {
  if (context != null) Navigator.pop(context);
}
