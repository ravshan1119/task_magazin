import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key, required this.categoryId, required this.categoryName});

  final String categoryId;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 9.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: categoryId == categoryName ? Colors.tealAccent : Colors.amber,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
            )
          ]),
      child: Row(
        children: [
          SizedBox(
              height: 30.h,
              width: 30.h,
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.category,
                ),
              )),
          SizedBox(width: 10.w),
          Text(
            categoryName,
          ),
        ],
      ),
    );
  }
}
