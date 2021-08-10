import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';

class NewsService {
  static String BASE_URL = "https://newsapi.org/v2/top-headlines?country=jp&category=business";
  getNewsList(String) async{
    var response = await http.get(Uri.parse(BASE_URL+"&apiKey=3f7fc42689eb48688abb421158425784"));
    if(response.statusCode ==200){
      List<News>newsList ;
      var finalResult = json.decode(response.body);
      newsList = (finalResult['articles'] as List).map((i) => News.fromJson(i)).toList();
      return newsList;

    }else{
      log('error occur');
    }
  }
}