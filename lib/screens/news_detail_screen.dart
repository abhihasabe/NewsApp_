import 'package:flutter/material.dart';
import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatelessWidget {
  Articles article;

  ArticleDetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("${article.source.name}"),
      ),
      body: ListView(
        children: <Widget>[
          article.urlToImage != null
              ? Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                )
              : Container(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(article.title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          article.content != null ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.content),
          ) : Container(),
          SizedBox(
            height: 10,
          ),
          article.url != null
              ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                    child: InkWell(
                      onTap: () {
                        _launchURL(article.url);
                      },
                      child: Text("Read More...",
                          style: TextStyle(color: Colors.blueAccent)),
                    ),
                    alignment: Alignment.topRight,
                  ),
              )
              : Container()
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
