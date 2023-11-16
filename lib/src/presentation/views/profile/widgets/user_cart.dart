import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/cart_cubit/cart_state.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key, required this.userId});

  final int? userId;

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  getData() async {
    context.read<CartCubit>().getUsers(widget.userId!);
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
        return ListView(
          children: [
            ...List.generate(
                state.carts.length,
                (index) => ListTile(
                      title: Text(state.carts[index].products[index].productId
                          .toString()),
                      subtitle: Text(state.carts[index].products[index].quantity
                          .toString()),
                    ))
          ],
        );
      },
    );
  }
}
