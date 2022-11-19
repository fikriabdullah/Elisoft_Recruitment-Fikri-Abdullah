part of 'article_cubit.dart';

@immutable
abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState{
  //constructor accept widget for indefinite spinner widget
}

class ArticleLoaded extends ArticleState{
  final ArticleModel articleModel;
  const ArticleLoaded(this.articleModel);
}
class ArticleError extends ArticleState{
  final String? articleErrorMessage;
  const ArticleError(this.articleErrorMessage);
}
