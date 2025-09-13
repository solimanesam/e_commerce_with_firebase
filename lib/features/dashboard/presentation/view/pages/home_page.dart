import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/cubit/getcoffee_cubit.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/display_user_coffee.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> tabsStrings = [
    'Popular',
    'Black coffee',
    'Winter special',
    'Decaffe',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabsStrings.length, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'What would you like \nto drink today?',
            style: TextStyles.semiBold20(context),
          ),
        ),
        // التبويبات
        TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          indicatorColor: AppColors.transparent,
          tabs: List.generate(
            tabsStrings.length,
            (index) => TabWidget(
              tabString: tabsStrings[index],
              activeTabColor: _tabController.index == index
                  ? AppColors.secondryColor
                  : AppColors.transparent,
              activeTabTextColor: _tabController.index == index
                  ? AppColors.primaryColor
                  : AppColors.secondryColor,
            ),
          ),
        ),

        // عشان نعرض body حسب التبويب
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              DisplayUserCoffee(getKindCoffee: GetKindCoffee.popular),
              DisplayUserCoffee(getKindCoffee: GetKindCoffee.blackCoffee),
              DisplayUserCoffee(getKindCoffee: GetKindCoffee.winterSpecial),
              DisplayUserCoffee(getKindCoffee: GetKindCoffee.decaffee)
            ],
          ),
        ),
      ],
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabString,
    required this.activeTabColor,
    required this.activeTabTextColor,
  });

  final String tabString;
  final Color activeTabColor;
  final Color activeTabTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: activeTabColor,
      ),
      child: Text(
        tabString,
        maxLines: 1,
        style: TextStyle(color: activeTabTextColor),
      ),
    );
  }
}
