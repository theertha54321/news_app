import 'package:flutter/material.dart';
import 'package:news_app/controller/category_model_controller.dart';
import 'package:news_app/controller/topstory_controller.dart';
import 'package:news_app/view/bottom_nav/bottom_nav.dart';
import 'package:provider/provider.dart';

void main(){
runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CategoryModelController()),
        ChangeNotifierProvider(create: (context)=>TopstoryController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNav(),
      ),
    );
  }
}