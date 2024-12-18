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
    String endurl = category==null ? "top-headlines/sources?apiKey=7701f3d356bc4cc6a193ba4cb0d2b9cd" : "top-headlines/sources?category=$category&apiKey=7701f3d356bc4cc6a193ba4cb0d2b9cd";
    final url = Uri.parse(AppConfig.baseUrl + endurl);
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      if(response.statusCode==200){
       

        
        newsList = categoryModelFromJson(response.body);
        
      }
    }catch(e){

    }
    isLoading=false;
    notifyListeners();
  }
 
}