import 'package:chat/helper/helper_functions.dart';
import 'package:chat/screens/chat_room_screen.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/utilites/background.dart';
import 'package:chat/utilites/rounded_button.dart';
import 'package:chat/utilites/texts.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods _authMethods = AuthMethods();
  DatabaseMethodes _databaseMethodes = DatabaseMethodes();
  QuerySnapshot _snapshotUserInfo;

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text('Login'),
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
                        // height: 150,
                        // width: 150,
                        // child: Image(
                        //   image:
                        //   ExactAssetImage('assets/images/logo.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        // child: SvgPicture.asset(
                        //   "assets/icons/login.svg",
                        //   height: MediaQuery.of(context).size.height * 0.35,
                        // ),
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
                          return RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value)
                              ? null
                              : 'Please enter a valid email';
                        },
                        controller: _userEmailController,
                        style: textStyle(),
                        decoration: textFieldInputDecoration(
                            lableText: 'email', icon: Icon(Icons.email)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          return value.length > 5
                              ? null
                              : 'Please provide password 5+ character';
                        },
                        controller: _userPasswordController,
                        style: textStyle(),
                        decoration: textFieldInputDecoration(
                            lableText: 'password',
                            icon: Icon(Icons.lock)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: '  Soon  ',
                          backgroundColor: Colors.white,
                          textColor: Colors.black);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _myButton(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have account? ',
                    style: textStyle(),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ), ),
    );
  }

  _signIn() {
    if (_formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(_userEmailController.text.trim());
      _databaseMethodes
          .getUserByUserEmail(_userEmailController.text.trim())
          .then((value) {
        _snapshotUserInfo = value;
        HelperFunctions.saveUserNameSharedPreference(
            _snapshotUserInfo.docs[0].data()['name']);
      });

      setState(() {
        isLoading = true;
      });

      _authMethods
          .signInWithEmailAndPassword(
              _userEmailController.text.trim(), _userPasswordController.text.trim())
          .then((value) {

        if (value != null) {
          Fluttertoast.showToast(
              msg: 'Welcome Back :)',
              backgroundColor: Colors.white,
              textColor: Colors.green);
        }else{
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChateRome()));
        }
      });
    }
  }

  Widget _myButton() {
    // return InkWell(
    //   onTap: () {
    //     _signIn();
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
    //         'Login',
    //         style: TextStyle(color: Colors.grey[800]),
    //       ),
    //     ),
    //   ),
    // );

    return RoundedButton(
      text: "Login",
      textColor: Colors.white,
      color: Colors.grey[700],
      press: (){
        _signIn();
      },
    );
  }
}
