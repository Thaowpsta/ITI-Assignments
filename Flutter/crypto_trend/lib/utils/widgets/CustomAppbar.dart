import 'package:crypto_trend/utils/AppAssets.dart';
import 'package:crypto_trend/utils/AppColors.dart';
import 'package:crypto_trend/utils/AppRoutes.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBackground,
      leading: InkWell(onTap: () => Navigator.pushNamed(context, AppRoutes.profile),child: Image.asset(AppAssets.person, width: 36, height: 36,)),
      actions: [
        Image.asset(AppAssets.search, width: 36, height: 36,),
        SizedBox(width: 12,),
        Image.asset(AppAssets.notification, width: 36, height: 36,),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
