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
    String endurl = category==null ? "https://newsapi.org/v2/everything?q=all&apiKey=4a891334103c49d09bc336e77ce66e2c":"https://newsapi.org/v2/everything?q=$category&apiKey=4a891334103c49d09bc336e77ce66e2c";
    final url = Uri.parse(endurl);
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      log(response.body);
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