import 'package:elisoft/blocs/article/article_cubit.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<ArticleCubit>().getArticle();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget progresIndicator(){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    String username = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome, $username", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  BlocBuilder<ArticleCubit, ArticleState>(
                      builder: (context, state){
                        if(state is ArticleLoading){
                          return progresIndicator();
                        }else if(state is ArticleLoaded){
                          return SizedBox(
                            width: 350,
                            height: 150,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.articleModel.articles.length,
                                itemBuilder: (context, index){
                                  return SizedBox(
                                    height: 100,
                                    width: 200,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 1
                                        )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Flexible(child: Text("${state.articleModel.articles[index]['title']}", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.lightBlue[800]
                                            ),)),
                                            Flexible(child: Text("${state.articleModel.articles[index]['content']}"))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                        }else if(state is ArticleError){
                          return AlertDialog(
                            title: Text("${state.articleErrorMessage}"),
                          );
                        }
                        print("Article State OB");
                        return Container();
                      }
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<ArticleCubit, ArticleState>(
                  builder: (context, state){
                    if(state is ArticleLoading){
                      print("Article Loading");
                      return progresIndicator();
                    }else if(state is ArticleLoaded){
                      return SizedBox(
                        height: 585,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.articleModel.articles.length,
                            itemBuilder: (context, index){
                              DateTime dateTime = DateTime.parse(state.articleModel.articles[index]['created']['date']);
                              String date = DateFormat.yMMMMEEEEd().format(dateTime);
                              String time = DateFormat.Hms().format(dateTime);
                              return SizedBox(
                                height: 225,
                                width: 200,
                                child: Card(
                                  color: Colors.lightBlue.shade50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network("${state.articleModel.articles[index]['image']}"),
                                            ),
                                            SizedBox(width: 10,),
                                            Flexible(child: Text("${state.articleModel.articles[index]['title']}", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.lightBlue[800]
                                            ),)),
                                          ],
                                        ),
                                        Flexible(child: Text("${state.articleModel.articles[index]['content']}")),
                                        SizedBox(height: 50,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("$date"),
                                            SizedBox(width: 5,),
                                            Text("$time")
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    }else if(state is ArticleError){
                      return AlertDialog(
                        title: Text("${state.articleErrorMessage}"),
                      );
                    }
                    print("Article State OB");
                    return Container();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
