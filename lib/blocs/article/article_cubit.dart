import 'package:bloc/bloc.dart';
import 'package:elisoft/model/article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'dart:convert';

part 'article_state.dart';

///TODOS : convert article objet to list so it can be used for listview.builder in dashboard
///

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());
  
  void getArticle()async{
    try{
      emit(ArticleLoading());
      String token = "lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB";
      Response response = await get(Uri.parse('https://demo.treblle.com/api/v1/articles'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if(response.statusCode == 200 && jsonDecode(response.body)['status'] == true){
        emit(ArticleLoaded(
            ArticleModel(
                articles: jsonDecode(response.body)['articles'],
                status: jsonDecode(response.body)['status']
            )
          )
        );
      }else{
        emit(ArticleError("Fetching Article Failed : ${response.statusCode}"));
        print("Fetching Article Failed : ${response.statusCode} || ${jsonDecode(response.body)}");
      }
    }catch(e){
      emit(ArticleError("Fetching Article Error : ${e.toString()}"));
      print("Fetching Article Error : ${e.toString()}");
    }
  }
}
