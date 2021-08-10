import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
import 'package:url_launcher/url_launcher.dart';

class NewsDatail extends StatefulWidget {
  final News news ;
  NewsDatail({this.news});

  @override
  _NewsDatailState createState() => _NewsDatailState();
}

class _NewsDatailState extends State<NewsDatail> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeiht = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeiht + kToolbarHeight;
    return Scaffold(
      body: extended.NestedScrollView(
        headerSliverBuilder: (context , innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              title: Text(widget.news.title),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(widget.news.urlToImage,fit: BoxFit.fill,),
              ),
            )
          ];
        },
          pinnedHeaderSliverHeightBuilder: () => pinnedHeaderHeight,
        body: Container(
          child: Card(
            borderOnForeground: true,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.news.title,
                    style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    widget.news.description,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: InkWell(
                      onTap: () async{
                        if(await canLaunch(widget.news.url)){
                          await launch(widget.news.url);
                        }else{
                          log('not launching');
                        }
                      },
                      child: Text(
                        widget.news.url,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,

                        ),
                      ),
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
