import 'package:chat/helper/helper_functions.dart';
import 'package:chat/screens/chat_room_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/utilites/background.dart';
import 'package:chat/utilites/or_divider.dart';
import 'package:chat/utilites/rounded_button.dart';
import 'package:chat/utilites/social_icon.dart';
import 'package:chat/utilites/texts.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordNameController = TextEditingController();

  final AuthMethods _authMethods = AuthMethods();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  DatabaseMethodes databaseMethodes = DatabaseMethodes();

  @override
  void dispose() {
    _userNameController.dispose();
    _userEmailController.dispose();
    _passwordNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text('Sign up'),
        centerTitle: true,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Background(child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(

                        width: 230,
                        child: Lottie.asset('assets/icons/chat.json'),

        ),
                      // SizedBox(height: 15,),
                      // Transform.translate(
                      //   offset: Offset(0, -10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       RichText(
                      //         text: TextSpan(
                      //           children: <TextSpan>[
                      //             textSpanMarkTitle('< '),
                      //             textSpanTitle('Aboelkhaer '),
                      //             textSpanTitle('Fadel'),
                      //             textSpanMarkTitle(' />'),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter name please';
                          } else if (value.length < 2) {
                            return 'Minmum characters is 2';
                          }
                          return null;
                        },
                        controller: _userNameController,
                        style: textStyle(),
                        decoration: textFieldInputDecoration(
                            lableText: 'user name',
                            icon: Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        validator: (value) {
                          return RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)
                              ? null
                              : 'Please enter a valid email';
                        },
                        controller: _userEmailController,
                        style: textStyle(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldInputDecoration(
                            lableText: 'email', icon: Icon(Icons.email)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordNameController,
                        validator: (value) {
                          return value.length > 5
                              ? null
                              : 'Please provide password 5+ character';
                        },
                        style: textStyle(),
                        obscureText: true,
                        decoration: textFieldInputDecoration(
                            lableText: 'password',
                            icon: Icon(Icons.lock)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _myButton(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have account? ',
                    style: textStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ), ),
    );
  }

  Widget _myButton() {
    // return InkWell(
    //   onTap: () {
    //     _signUp();
    //   },
    //   child: Container(
    //     height: 50,
    //     width: MediaQuery.of(context).size.width * 0.5,
    //     decoration: BoxDecoration(
    //       color: Color(0xFFDEE7F6),
    //       shape: BoxShape.rectangle,
    //       boxShadow: [
    //         BoxShadow(
    //             color: Colors.black26,
    //             offset: Offset(4.0, 4.0),
    //             blurRadius: 15,
    //             spreadRadius: 1),
    //         BoxShadow(
    //             color: Colors.white,
    //             offset: Offset(-4.0, -4.0),
    //             blurRadius: 8,
    //             spreadRadius: 1),
    //       ],
    //     ),
    //     child: Container(
    //       alignment: Alignment.center,
    //       child: Text(
    //         'Sign up',
    //         style: TextStyle(color: Colors.grey[800]),
    //       ),
    //     ),
    //   ),
    // );

    return RoundedButton(
      text: 'Sign up',
      textColor: Colors.white,
      color: Colors.grey[700],
      press: (){
        _signUp();
      },
    );



  }

  _signUp() {
    if (_formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        'name': _userNameController.text,
        'email': _userEmailController.text,
      };

      HelperFunctions.saveUserEmailSharedPreference(_userEmailController.text);
      HelperFunctions.saveUserNameSharedPreference(_userNameController.text);

      setState(() {
        isLoading = true;
      });
      _authMethods
          .signUpWithEmailAndPassword(
              _userEmailController.text, _passwordNameController.text)
          .then((value) {
        print('success');
        Fluttertoast.showToast(
            msg: 'Welcome :)',
            backgroundColor: Colors.white,
            textColor: Colors.green);

        databaseMethodes.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChateRome()));
      });
    }
  }
}
