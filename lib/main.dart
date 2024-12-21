import 'package:flutter/material.dart';
import 'package:news_app/controller/category_model_controller.dart';
import 'package:news_app/controller/saved_screen_controller.dart';

import 'package:news_app/controller/topstory_controller.dart';
import 'package:news_app/view/bottom_nav/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavedScreenController.initDb();
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CategoryModelController()),
        ChangeNotifierProvider(create: (context)=>TopstoryController()),
       ChangeNotifierProvider(create: (context)=>SavedScreenController()),
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       
        home: BottomNav(),
      ),
    );
  }
  
}