import 'package:elisoft/blocs/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/article/article_cubit.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late FocusNode passwordFocusNode;
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordFocusNode.dispose();
    usernameCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget loadingDialog(){
      return Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            strokeWidth: 10,
          ),
        )
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Image(image: AssetImage('assets/Capture.png'))
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 10),
                      child: TextFormField(
                        controller: usernameCtrl,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            label: const Text("Username"),
                            filled: true,
                            fillColor: Colors.blue[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (value)=> value == null || value.isEmpty ? "Please Fill Your Username" : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50,0, 50, 10),
                      child: TextFormField(
                        controller: passwordCtrl,
                        focusNode: passwordFocusNode,
                        onTap: () => passwordFocusNode.requestFocus(),
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                            label: const Text("Password"),
                            filled: true,
                            fillColor: Colors.blue[100],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: Icon(
                                    passwordVisible ? Icons.visibility_off : Icons.visibility
                                ))
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (value)=> value == null || value.isEmpty ? "Please Fill your Password" : null,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                            child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    context.read<UserCubit>().setUser(usernameCtrl.text, passwordCtrl.text);
                                    context.read<ArticleCubit>().getArticle();
                                  }
                                },
                                style:ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.teal[600])
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text("Login",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state){
               if(state is UserLoaded){
                  Navigator.pushReplacementNamed(context, '/dashboard', arguments: state.userModel.name);
                }else if(state is UserError){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.userErrorStringMessage}")));
                }
              },
              builder: (context, state){
                if(state is UserLoading){
                  return loadingDialog();
                }else if(state is UserLoaded){
                  print("User Loaded");
                }
                print("State OB no widget return");
                return Container();
              },
            )
          ],
        )
      )
    );
  }
}

