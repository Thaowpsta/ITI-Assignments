import 'package:crypto_trend/utils/AppAssets.dart';
import 'package:crypto_trend/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/widgets/CustomRow.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        leading: Icon(Icons.arrow_back, color: AppColors.white,),
        title: Text("Settings", style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          CustomRow(property: "Language", propertyTitle: "English", icon: AppAssets.lang,),
          CustomRow(property: "Currency", propertyTitle: "USD", icon: AppAssets.currency,),
          CustomRow(property: "Appearance", propertyTitle: "Use Device Settings", icon: AppAssets.appearance,),
          CustomRow(property: "Preference", propertyTitle: "Customize", icon: AppAssets.preferences,),
          CustomRow(property: "About Us", propertyTitle: "v1.2.3", icon: AppAssets.aboutUs,),
        ],
      ),
    );
  }
}
