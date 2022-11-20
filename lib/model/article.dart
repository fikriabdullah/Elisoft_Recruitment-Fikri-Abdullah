class ArticleModel {
  bool status;
  List articles;

  ArticleModel({required this.articles, required this.status});

  factory ArticleModel.fromJson(Map<String, dynamic> json){
    return ArticleModel(
        articles: json['articles'],
        status: json['status']
    );
  }
}