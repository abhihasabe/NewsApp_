import 'package:flutter/material.dart';
import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/screens/news_detail_screen.dart';

class NewsArticlesWidget extends StatefulWidget {
  List<Articles> articles;

  NewsArticlesWidget({Key key, this.articles}) : super(key: key);

  @override
  _NewsArticlesWidgetState createState() => _NewsArticlesWidgetState();
}

class _NewsArticlesWidgetState extends State<NewsArticlesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.articles.length,
      itemBuilder: (ctx, pos) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.articles[pos].urlToImage != null
                  ? Image.network(
                      widget.articles[pos].urlToImage,
                      fit: BoxFit.cover,
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Container(),
              Text(widget.articles[pos].title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 15,
              )
            ],
          ),
          onTap: () {
            navigateToArticleDetailPage(context, widget.articles[pos]);
          },
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }
}
