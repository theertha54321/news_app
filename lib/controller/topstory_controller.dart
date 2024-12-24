

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/app_config.dart';
import 'package:news_app/model/category_model.dart';
import 'package:news_app/model/headline_model.dart';
import 'package:news_app/model/top_stories_model.dart';


class TopstoryController with ChangeNotifier{
  bool isLoading = false;
  TopStoryModel? newList ;
  HeadlineModel? list;
  CategoryModel? searchResults ;
  
  
  Future<void> getStories(String? source) async{
    
    final url = Uri.parse( "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=7701f3d356bc4cc6a193ba4cb0d2b9cd");
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
     
      if(response.statusCode==200){
       

        
        newList =topStoryModelFromJson(response.body);
       
      }
    }catch(e){

    }
    isLoading=false;
    notifyListeners();
  }
  Future<void> getHeadlines() async{
    
    final url = Uri.parse("https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=7701f3d356bc4cc6a193ba4cb0d2b9cd");
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      log(response.body.toString());
      if(response.statusCode==200){
       

        
        list = headlineModelFromJson(response.body);
        
      }
    }catch(e){

    }
    isLoading=false;
    notifyListeners();
    
  }
Future<void> searchNews(String query) async {
  final searchUrl = Uri.parse(AppConfig.baseUrl+"everything?q=$query&apiKey=7701f3d356bc4cc6a193ba4cb0d2b9cd");
  try {
    isLoading = true;
    notifyListeners();

    
    final response = await http.get(searchUrl);

    if (response.statusCode == 200) {
      searchResults =categoryModelFromJson(response.body); 
      
    }
  } catch (e) {
    print(e);
  }
  isLoading = false;
  notifyListeners();
}
  
}