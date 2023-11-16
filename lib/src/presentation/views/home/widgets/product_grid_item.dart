import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_state.dart';
import 'package:task_magazin/src/utils/extensions/size_extension.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';
import 'package:task_magazin/src/utils/resources/app_text_styles.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductGridItem extends StatefulWidget {
  const ProductGridItem({super.key, required this.category});

  final String category;

  @override
  State<ProductGridItem> createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  getData() async {
    await context
        .read<ProductCubit>()
        .getProductByCategoryName(widget.category);
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error"),
          ));
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
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            children: [
              ...List.generate(
                state.products.length,
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
                            imageUrl: state.products[index].image,
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
                          "Name: ${state.products[index].title}",
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
                              " Price: ${state.products[index].price}",
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
                          initialRating: state.products[index].rating.rate,
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
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
