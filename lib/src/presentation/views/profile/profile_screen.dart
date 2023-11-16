import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_magazin/src/config/router/app_routes.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/presentation/cubits/users_cubit/users_cubit.dart';
import 'package:task_magazin/src/presentation/cubits/users_cubit/users_state.dart';
import 'package:task_magazin/src/utils/resources/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  getData() async {
    await context.read<UserCubit>().getUsers();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
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
              scrolledUnderElevation: 0,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text("Users",
                  style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.c_0C1A30,
                  ))),
          body: ListView(
            children: [
              const Divider(color: Colors.grey),
              ...List.generate(
                state.users.length,
                (index) => GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.userCart,
                        extra: state.users[index]);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 40,
                        ),
                        title: Text(state.users[index].name.firstname),
                        subtitle: Text(state.users[index].email),
                      ),
                      const Divider(color: Colors.grey)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
