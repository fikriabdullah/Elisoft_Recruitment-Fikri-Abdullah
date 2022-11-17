import 'package:flutter/material.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: usernameCtrl,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value)=> value == null || value.isEmpty ? "Please Fill Your Username" : null,
                ),
                TextFormField(
                  focusNode: passwordFocusNode,
                  onTap: () => passwordFocusNode.requestFocus(),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: (value)=> value == null || value.isEmpty ? "Please Fill your Password" : null,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all(Colors.tealAccent[400])
                      ),
                        onPressed: (){
                          print("${usernameCtrl.text}");
                        },
                        child: Text("Login")
                    )
                  ],
                )
              ],
            )
        ),
      )
    );
  }
}

