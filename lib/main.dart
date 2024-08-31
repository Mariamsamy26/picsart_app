import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/img_Providers.dart';
import 'layout/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImgProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // Ensure this widget is below the Provider in the tree
    );
  }
}
