import 'package:flutter/material.dart';

import '../AppColors.dart';

class CustomRow extends StatelessWidget {

  String? icon;
  String propertyTitle;
  String property;

  CustomRow({super.key, required this.property, required this.propertyTitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return           Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          icon != null? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(icon!),
          ) : SizedBox.shrink(),
          Text(propertyTitle, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.lightGrey),),
          Spacer(),
          Text(property, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey),),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.arrow_forward, color: AppColors.grey,),
          )
        ],
      ),
    );
  }
}
