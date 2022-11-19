import 'package:bloc/bloc.dart';
import 'package:elisoft/model/article.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());
}
