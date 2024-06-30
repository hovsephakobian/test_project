import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/warehouse_screen.dart';

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home:  StockView(),
    );
  }
}
