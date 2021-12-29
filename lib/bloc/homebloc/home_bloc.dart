import 'package:bloc/bloc.dart';
import 'package:form_validation/bloc/homebloc/home_event.dart';
import 'package:form_validation/bloc/homebloc/home_state.dart';
import 'package:form_validation/model/news_model.dart';
import 'package:form_validation/repositories/news_repository.dart';
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, NewsState> {
  NewsArticleRepository repository;

  ArticleBloc({@required this.repository}) : super(ArticleInitialState());

  @override
  // TODO: implement initialState
  NewsState get initialState => ArticleInitialState();

  @override
  Stream<NewsState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield NewsLoadingState();
      try {
        dynamic news = await repository.fetchAllNews();
        NewsModel newsModel = NewsModel.fromJson(news);
        yield NewsLoadedState(articles: newsModel.articles);
      } catch (e) {
        yield NewsErrorState(message: e.toString());
      }
    }
  }
}
