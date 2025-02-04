import 'package:bloc/bloc.dart';
import 'package:e_commerce_with_firebase/core/theme/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState(selectedTapIndex: 0));
  List<BottomNavigationBarItem> get bottomNavigationBarItems {
    return [
      buildNavItem(Icons.home_outlined, 0),
      buildNavItem(Icons.shopping_cart_outlined, 1),
      buildNavItem(Icons.favorite_border, 2),
      buildNavItem(Icons.person_2_outlined, 3),
    ];
  }

  int selectedTapIndex = 0;
  final PageController pageController = PageController();

  void onPageChanged(int index) {
    selectedTapIndex = index;
    emit(DashboardState(selectedTapIndex: index));
  }

  void onChangeTabIndex(int index) {
    if (index != selectedTapIndex) {
      selectedTapIndex = index;
      pageController.jumpToPage(selectedTapIndex);
      emit(DashboardState(selectedTapIndex: index));
    }
  }

  BottomNavigationBarItem buildNavItem(IconData icon, int index) {
    bool isActive = selectedTapIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: [
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondryColor : AppColors.transparent,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
          ),
         Transform.translate(
          offset: Offset(0, 10), 
          child: Icon(icon),
        ),
        ],
      ),
      label: '',
    );
  }
}
