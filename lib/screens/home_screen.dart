
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tuwaiq_project/helper/extinsion/size_config.dart';
import 'package:tuwaiq_project/screens/all_project_screen.dart';
import 'package:tuwaiq_project/screens/bottomNavBloc/bottomnav_bloc.dart';
import 'package:tuwaiq_project/screens/profile/profile_screen.dart';
import 'package:tuwaiq_project/screens/search_screen.dart';
import 'package:tuwaiq_project/screens/user_project_screen.dart';
import 'package:tuwaiq_project/shape/auth_shape.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final List<Widget> tabs = const [
    AllProjectScreen(),
    UserProjectScreen(),
    SearchScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomnavBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<BottomnavBloc>();
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BlocBuilder<BottomnavBloc, BottomnavState>(
            builder: (context, state) {
              int selectedIndex = 0;
              if (state is IndexChangeState) {
                selectedIndex = state.index;
              }
              return FlashyTabBar(
                onItemSelected: (index) {
                  bloc.add(NavigatorBetweenScreenEvent(selectedIndex: index));
                },
                selectedIndex: selectedIndex,
                items: [
                  FlashyTabBarItem(
                    icon: const Icon(
                      Iconsax.home_bold,
                      color: Color(0x889B37FF),
                      size: 30,
                    ),
                    title: const Text('Home'),
                  ),
                  FlashyTabBarItem(
                    icon: const Icon(
                      Iconsax.card_add_bold,
                      color: Color(0x889B37FF),
                      size: 30,
                    ),
                    title: const Text('my project'),
                  ),
                  FlashyTabBarItem(
                    icon: const Icon(
                      LineAwesome.search_solid,
                      color: Color(0x889B37FF),
                      size: 30,
                    ),
                    title: const Text('Search'),
                  ),
                  FlashyTabBarItem(
                    icon: const Icon(
                      Iconsax.profile_2user_bold,
                      color: Color(0x889B37FF),
                      size: 30,
                    ),
                    title: const Text('Profile'),
                  ),
                ],
              );
            },
          ),
          body: Column(
            children: [
              CustomPaint(
                size: Size(context.getWidth(multiply: 1),
                    context.getHeight(multiply: 0.1)),
                painter: AuthShape(),
              ),
              BlocBuilder<BottomnavBloc, BottomnavState>(
                builder: (context, state) {
                  int selectedIndex = 0;
                  if (state is IndexChangeState) {
                    selectedIndex = state.index;
                  }
                  return tabs[selectedIndex];
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}