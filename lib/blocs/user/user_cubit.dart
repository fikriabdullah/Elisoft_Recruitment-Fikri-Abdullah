import 'package:bloc/bloc.dart';
import 'package:elisoft/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(String email, String password)async{
    String token = "lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB";
    final jsonBody = jsonEncode({"email": email, "password": password});

   try{
     emit(UserLoading());
     Response response = await post(Uri.parse('https://demo.treblle.com/api/v1/auth/login'),
         headers: {
           'Content-Type': 'application/json',
           'Authorization': 'Bearer $token'
         },
         body:jsonBody
     );
     if(jsonDecode(response.body)['status'] == true && response.statusCode == 200){
       emit(UserLoaded(
           UserModel(
               name: jsonDecode(response.body)['user']['name'],
               phoneNumber: jsonDecode(response.body)['user']['phone_number'],
               email: jsonDecode(response.body)['user']['email'],
               Uid: jsonDecode(response.body)['user']['uuid'])
          )
       );
     }else{
       emit(UserError("Login Failed : ${jsonDecode(response.body)['errors']['email']}"));
     }
   }catch(e){
     emit(UserError("User Fecthing Error : ${e.toString()}"));
   }


  }
}
