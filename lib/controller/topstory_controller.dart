import 'package:flutter/material.dart';
import 'package:news_app/app_config.dart';
import 'package:news_app/model/top_stories_model.dart';
import 'package:http/http.dart' as http;

class TopstoryController with ChangeNotifier{
  bool isLoading = false;
  TopStories? headlineList ;
  Future<void> getTopHeadlinesbyVariousSources() async{
    String endurl =  "top-headlines?country=us&apiKey=7701f3d356bc4cc6a193ba4cb0d2b9cd";
    final url = Uri.parse(AppConfig.baseUrl + endurl);
    try{
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      if(response.statusCode==200){
       

        
        headlineList = topStoriesFromJson(response.body);
        
      }
    }catch(e){

    }
    isLoading=false;
    notifyListeners();
  }
}