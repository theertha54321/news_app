import 'package:flutter/material.dart';
import 'package:news_app/controller/category_model_controller.dart';

import 'package:news_app/controller/topstory_controller.dart';
import 'package:news_app/view/bottom_nav/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://flutter.dev');
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
        ChangeNotifierProvider(create: (context)=>TopstoryController()),
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       
        home: BottomNav(),
      ),
    );
  }
  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
}