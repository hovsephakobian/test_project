import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/extentions/build_context_extention.dart';
import 'package:test_task/themes/app_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.appBarTitle});
  final String appBarTitle ;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return AppBar(
        backgroundColor: AppColors.appBarColor,
        title: AutoSizeText(
          widget.appBarTitle.tr(),
          style: textTheme.headlineMedium?.copyWith(
            color: AppColors.appWhite
          ),


    ));
  }
}
