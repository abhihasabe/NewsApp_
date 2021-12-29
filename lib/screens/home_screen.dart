import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/bloc/authbloc/authentication_bloc.dart';
import 'package:form_validation/bloc/authbloc/authentication_event.dart';
import 'package:form_validation/bloc/homebloc/home_bloc.dart';
import 'package:form_validation/bloc/homebloc/home_event.dart';
import 'package:form_validation/bloc/homebloc/home_state.dart';
import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/screens/news_detail_screen.dart';
import 'package:form_validation/theme/app_colors.dart';
import 'package:form_validation/helper/dialog_helper.dart';
import 'package:form_validation/widgets/news_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context)
      ..add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('News'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationEventLoggedOut());
            },
          )
        ],
      ),
      body: BlocListener<ArticleBloc, NewsState>(
        listener: (context, state) {
          if (state is NewsErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            });
          }
        },
        child: BlocBuilder<ArticleBloc, NewsState>(
          builder: (context, state) {
            if (state is ArticleInitialState) {
              return DialogHelper.buildLoading();
            } else if (state is NewsLoadingState) {
              return DialogHelper.buildLoading();
            } else if (state is NewsLoadedState) {
              return NewsArticlesWidget(articles: state.articles);
            } else if (state is NewsErrorState) {
              return buildErrorUi(state.message);
            }
          },
        ),
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              articles[pos].urlToImage != null
                  ? Image.network(
                      articles[pos].urlToImage,
                      fit: BoxFit.cover,
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                    )
                  : Container(),
              Text(articles[pos].title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 15,
              )
            ],
          ),
          onTap: () {
            navigateToArticleDetailPage(context, articles[pos]);
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
