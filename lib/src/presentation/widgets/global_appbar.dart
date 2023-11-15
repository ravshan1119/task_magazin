import 'package:flutter/material.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSize {
  const GlobalAppBar({
    Key? key,
    this.onTap,
    this.action,
    this.centerTitle,
    this.title = "",
  }) : super(key: key);

  final VoidCallback? onTap;
  final String title;
  final List<Widget>? action;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      actions: action,
      elevation: 0,
      centerTitle: centerTitle,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
      title: title.isNotEmpty
          ? Text(title, style: Theme.of(context).textTheme.headlineMedium)
          : null,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
