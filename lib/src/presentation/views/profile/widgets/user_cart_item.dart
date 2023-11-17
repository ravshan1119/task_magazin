import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/product_cubit/product_state.dart';

class UserCartItem extends StatefulWidget {
  const UserCartItem({super.key, required this.id, required this.count});

  final int id;
  final int count;

  @override
  State<UserCartItem> createState() => _UserCartItemState();
}

class _UserCartItemState extends State<UserCartItem> {
  getData() async {
    await context.read<ProductCubit>().getProductById(widget.id);
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
          appBar: AppBar(
            title: const Text("User Cart"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
          ),
          body: ListTile(
            title: Text(state.product.title),
            subtitle: Text(
              state.product.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: Text(
              "${widget.count} * ${state.product.price.toString()}",
            ),
            leading: CachedNetworkImage(
              imageUrl: state.product.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
