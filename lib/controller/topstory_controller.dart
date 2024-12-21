

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/category_model.dart';
import 'package:news_app/model/headline_model.dart';
import 'package:news_app/model/top_stories_model.dart';


class TopstoryController with ChangeNotifier{
  bool isLoading = false;
  TopStoryModel? newList ;
  
  HeadlineModel? list;
  Future<void> getStories(String? source) async{
    
    final url = Uri.parse( "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=4a891334103c49d09bc336e77ce66e2c");
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      // log(response.body.toString());
      if(response.statusCode==200){
       

        
        newList =topStoryModelFromJson(response.body);
       
      }
    }catch(e){

    }
    isLoading=false;
    notifyListeners();
  }
  Future<void> getHeadlines() async{
    
    final url = Uri.parse("https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=4a891334103c49d09bc336e77ce66e2c");
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
 
}