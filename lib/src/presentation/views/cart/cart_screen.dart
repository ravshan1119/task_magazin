import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_magazin/src/data/datasources/local/local_database.dart';
import 'package:task_magazin/src/domain/models/product_model_sql.dart';
import 'package:task_magazin/src/presentation/widgets/global_button.dart';
import 'package:task_magazin/src/utils/extensions/size_extension.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';
import 'package:task_magazin/src/utils/resources/app_text_styles.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  List<ProductModelSql> productList = [];

  getData() async {
    setState(() {
      isLoading = true;
    });
    productList = await LocalDatabase.getAllProducts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Text("Cart",
                    style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.c_0C1A30,
                    ))),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(12),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  children: [
                    ...List.generate(
                      productList.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: productList[index].image,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Name: ${productList[index].title}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.bodyMediumRegular
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.price_change_outlined,
                                    color: AppColors.yellow,
                                  ),
                                  Text(
                                    " Price: ${productList[index].price}",
                                    style:
                                        const TextStyle(color: AppColors.black),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RatingBar.builder(
                                itemSize: 14,
                                unratedColor: Colors.grey.shade400,
                                initialRating: productList[index].rate,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  debugPrint(rating.toString());
                                },
                              ),
                            ),
                            10.h,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GlobalButton(
                                  title: "Remove cart",
                                  onTap: () {
                                    LocalDatabase.deleteProduct(
                                        productList[index].id!);
                                    getData();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      "Product ${productList[index].title} remove to cart",
                                      style: AppTextStyle.bodyMediumRegular
                                          .copyWith(color: Colors.white),
                                    )));
                                  }),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
