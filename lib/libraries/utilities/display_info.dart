import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}
double displayDensity(BuildContext context){
  return displaySize(context).height+displaySize(context).width;
}

Orientation displayOrientation(BuildContext context){
  return MediaQuery.of(context).orientation;
}