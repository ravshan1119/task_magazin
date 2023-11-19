import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_state.dart';
import 'package:task_magazin/src/presentation/widgets/global_button.dart';
import 'package:task_magazin/src/utils/extensions/size_extension.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';
import 'package:task_magazin/src/utils/resources/app_text_styles.dart';
import 'package:task_magazin/src/utils/ui_utils/error_message_dialog.dart';

class UserCartItemTwo extends StatefulWidget {
  const UserCartItemTwo(
      {super.key, required this.productId, required this.quantity});

  final int productId;
  final int quantity;

  @override
  State<UserCartItemTwo> createState() => _UserCartItemTwoState();
}

class _UserCartItemTwoState extends State<UserCartItemTwo> {
  getData() {
    context.read<ProductCubit>().getProductById(widget.productId);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.status == ApiStatus.failure) {
          showErrorMessage(message: state.error, context: context);
        }
      },
      builder: (context, state) {
        if (state.status == ApiStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child:Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                      imageUrl: state.product.image,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Name: ${state.product.title}",
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
                        " Price: ${state.product.price}",
                        style: const TextStyle(color: AppColors.black),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RatingBar.builder(
                    itemSize: 14,
                    unratedColor: Colors.grey.shade400,
                    initialRating: state.product.rating.rate,
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
                    title: "Order delivery",
                    onTap: () async {
                      // ProductModelSql productsModelSql = ProductModelSql(
                      //   idProduct: state.products[index].id,
                      //   title: state.products[index].title,
                      //   price: state.products[index].price,
                      //   description: state.products[index].description,
                      //   category: state.products[index].category,
                      //   image: state.products[index].image,
                      //   rate: state.products[index].rating.rate,
                      //   rateCount: state.products[index].rating.count,
                      //   count: 1,
                      // );
                      // List<ProductModelSql> products =
                      // await LocalDatabase.getProductsByQuery(
                      //     productsModelSql.title);
                      // if (products.isEmpty) {
                      //   LocalDatabase.insertProduct(
                      //       productsModelSql.copyWith(count: 1));
                      // } else {
                      //   productsModelSql.copyWith(
                      //       count: products[0].count + 1);
                      //   LocalDatabase.updateProduct(
                      //       productModelSql: productsModelSql);
                      // }
                      // if (context.mounted) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //         "Product ${state.products[index].title} added to cart",
                      //         style: AppTextStyle.bodyMediumRegular
                      //             .copyWith(color: Colors.white),
                      //       ),
                      //     ),
                      //   );
                      // }
                    },
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
