import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/category_cubit/category_state.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:task_magazin/src/presentation/views/home/widgets/category_item.dart';
import 'package:task_magazin/src/presentation/views/home/widgets/product_grid_item.dart';
import 'package:task_magazin/src/presentation/views/home/widgets/text_see_all.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController();
  String categoryId = "";

  getData() {
    context.read<CategoryCubit>().getCategories();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state.status == ApiStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error"),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == ApiStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.white,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: AppColors.white),
            title: Text(
              "Mega Mall",
              style: TextStyle(
                  fontFamily: "DMSans",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c_3669C9),
            ),
            centerTitle: true,
            elevation: 1,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25.h),
                TextSeeAll(
                  text: "Categories",
                  seeAll: "",
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 60.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          categoryId = "";
                          context
                              .read<ProductCubit>()
                              .getProductByCategoryName(categoryId);
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 9.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          height: 50.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: categoryId == ""
                                  ? Colors.tealAccent
                                  : Colors.amber,
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
                              const Text(
                                "All",
                              ),
                            ],
                          ),
                        ),
                      ),
                      ...List.generate(
                        state.categories.length,
                        (index) => GestureDetector(
                          onTap: ()async {
                            categoryId = state.categories[index];
                            setState(() {});
                          },
                          child: CategoryItem(
                            categoryId: categoryId,
                            categoryName: state.categories[index],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                TextSeeAll(
                  text: categoryId == "" ? "All" : categoryId,
                  seeAll: "see all",
                  onTap: () {},
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  child: ProductGridItem(
                    category: categoryId,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
