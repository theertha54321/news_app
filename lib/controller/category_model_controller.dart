import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/category_model.dart';


class CategoryModelController with ChangeNotifier{
  bool isLoading = false;
  CategoryModel? newsList ;
  Future<void> getCategories(String? category) async{
    String endurl =  "top-headlines/sources?category=$category&apiKey=f09dee59d1524d44bda79abf5b7af6f1";
    final url = Uri.parse(AppConfig.baseUrl + endurl);
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      if(response.statusCode==200){
       

        
        newsList = categoryModelFromJson(response.body);
         // Check the URL

        
      }
    }catch(e){

    }
    isLoading=false;
    notifyListeners();
  }
 
}