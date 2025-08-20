import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.all(15.0),
          child: Text(
            'What would you like \nto drink today?',
            style: TextStyles.semiBold20(context),
          ),
        ),
        DefaultTabController(
          length: tabsStrings.length,
          child: TabBar(
            
            tabAlignment: TabAlignment.start,//in order to remove start(left) padding
            isScrollable: true,//in order to fix text over flow issue
            physics: BouncingScrollPhysics(),
            indicatorColor: AppColors.transparent,
              tabs: List.generate(
            tabsStrings.length,
            (index) => TabWidget(
              tabString: tabsStrings[index],
              activeTabColor: index == activeTab
                  ? AppColors.secondryColor
                  : AppColors.transparent,
              activeTabTextColor: index == activeTab
                  ? AppColors.primaryColor
                  : AppColors.secondryColor,    
            ),
          )),
        )
      ],
    );
  }
}

int activeTab = 0;
const List<String> tabsStrings = [
  'Popular',
  'Black coffe',
  'Winter special',
  'decaffe'
];

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.tabString,
    required this.activeTabColor, required this.activeTabTextColor,
  });
  final String tabString;
  final Color activeTabColor;
    final Color activeTabTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal:  15.0, vertical: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: activeTabColor,
        ),
        child: Text(
          tabString,
          maxLines: 1,
          style: TextStyle(color: activeTabTextColor),
        ));
  }
}
