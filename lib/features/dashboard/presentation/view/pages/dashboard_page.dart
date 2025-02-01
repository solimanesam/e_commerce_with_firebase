import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:e_commerce_with_firebase/core/theme/text_styles.dart';
import 'package:e_commerce_with_firebase/features/dashboard/presentation/view/pages/home_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          PopupMenuButton(
            itemBuilder: (context) {
              return List.empty();
            },
          ),
        ],
        backgroundColor: AppColors.primaryColor,
        title: Text('Good day, zyad',style: TextStyles.regular14_120(context),),
        leading: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.search)),
      ),
       body: PageView(
              controller: PageController(),
              // onPageChanged: (index) {
              //   controller.onPageChanged(index);
              // },
              children: const [
                HomePage(),
              ],
            ),
    );
  }
}
