import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/service/news_service.dart';

import 'news_datail.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> newsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ニュースアプリ(でも)'),
        centerTitle: true,
        leading: Icon(Icons.sort),
      ),
      body: Container(
        child: FutureBuilder(
          future:getNewsList('trending'),
          builder: (context ,snapshot){
            if(snapshot.hasData){
              if(newsList.length == 0){
                return Center(child: Text('見つかりませんでした'),);
              }else{
                return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return NewsDatail(news: newsList[index]);
                      },));

                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        //フェードイン　読み込み中保存される画像
                        child: FadeInImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                          placeholder: AssetImage(
                            "assets/doraemon-0.png"
                          ),
                          image: NetworkImage(
                            newsList[index].urlToImage
                          ),
                        ),
                      ),
                      title: Text(newsList[index].title),
                      subtitle: Text(newsList[index].publishedAt),
                    ),
                  );
                });
              }
            }else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }

  getNewsList(String s) async {
    newsList  = await NewsService().getNewsList(s);
    return newsList;
  }

}


