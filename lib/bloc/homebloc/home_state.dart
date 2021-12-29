import 'package:equatable/equatable.dart';
import 'package:form_validation/model/news_model.dart';
import 'package:meta/meta.dart';

abstract class NewsState extends Equatable {}

class ArticleInitialState extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsLoadingState extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsLoadedState extends NewsState {

  List<Articles> articles;

  NewsLoadedState({@required this.articles});

  @override
  // TODO: implement props
  List<Object> get props => [articles];
}

class NewsErrorState extends NewsState {

  String message;

  NewsErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}