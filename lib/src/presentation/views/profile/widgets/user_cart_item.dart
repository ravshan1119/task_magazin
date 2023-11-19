import 'package:flutter/material.dart';
import 'package:task_magazin/src/domain/models/user_carts_model.dart';
import 'package:task_magazin/src/presentation/views/profile/widgets/user_cart_item_two.dart';

class UserCartItem extends StatefulWidget {
  const UserCartItem({super.key, required this.products});

  final List<UserCartsModel> products;

  @override
  State<UserCartItem> createState() => _UserCartItemState();
}

class _UserCartItemState extends State<UserCartItem> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...List.generate(
          widget.products.length,
          (index) => UserCartItemTwo(
            productId: widget.products[index].products[index].productId,
            quantity: widget.products[index].products[index].quantity,
          ),
        )
      ],
    );
  }
}
