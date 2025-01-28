// first step: calculate scale factor
// second step: calculate Responsive Font Size
// third step: calculate a lower and upper limit where font size dose not exceed them
import 'package:e_commerce_with_firebase/core/extentions/responsive_extention.dart';
import 'package:flutter/cupertino.dart';

double getResponsiveFontSize(
    {required BuildContext context, required double fontSize}) {
  double scaleFactor = getScaleFactor(context: context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor({required BuildContext context}) {
  if (context.width < 600) {
    return context.width / 400;
  } else if (context.width < 900) {
    return context.width / 700;
  } else {
    return context.width / 1000;
  }
}
