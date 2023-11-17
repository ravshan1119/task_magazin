import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/cart_cubit/cart_state.dart';
import 'package:task_magazin/src/presentation/views/profile/widgets/user_cart_item.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key, required this.userId});

  final int? userId;

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  getData() async {
    context.read<CartCubit>().getSingleCart(widget.userId!);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
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
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "User Carts",
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: [
              ...List.generate(
                state.userCarts.products.length,
                (index) => UserCartItem(
                  id: state.userCarts.products[index].productId,
                  count: state.userCarts.products[index].quantity,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
