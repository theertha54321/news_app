import 'package:flutter/material.dart';
import 'package:news_app/view/home_screen/home_screen.dart';
import 'package:news_app/view/section_screen/section_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex=0;
  List screen = [
    HomeScreen(),
    SectionScreen()
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 54,
        child: BottomNavigationBar(
          
          selectedIconTheme: IconThemeData(size: 18),
          unselectedIconTheme: IconThemeData(size: 18),
          backgroundColor: const Color.fromARGB(255, 2, 8, 35),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: currentIndex,
          onTap: (index){
            currentIndex=index;
            setState(() {
              
            });
          },
          items:[ 
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.category),label: "Section")
          ]
          ),
      ),

        body:screen[currentIndex] ,
    );
  }
}