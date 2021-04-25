import 'package:flutter/material.dart';
import 'package:goo/screens/login/form_feild.dart';
import 'package:goo/screens/login/phone_confirm.dart';
import 'package:goo/screens/login/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool show = true;


  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF0A0A0A),
      body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.orange,
          ),
          inAsyncCall: _loading,
          child: Form(
            key: _formKey,
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 60),
                height: 200,
                child: Image(
                  image: AssetImage('assets/images/Artboard 1xhdpi.png'),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'Login',
                          style: GoogleFonts.k2d(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                     
                      InputField(
                        controller: _emailController,
                        // prefixText: '+237',
                        hint: 'Email',
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                      ),
                      InputField(
                        controller: _passController,
                        hint: 'Password',
                        obscureText: show,
                        prefixIcon: Icons.lock,
                        suffixIcon: Icons.remove_red_eye,
                        sufixTap: () {
                          setState(() {
                            show = show ? false : true;
                          });
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'password cannot be empty';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 50, right: 50),
                        child: GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                // login user
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.orange),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmPhone())),
                          child: Center(
                            child: Text(
                              'I forgot my password',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.5),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 90),
                        child: Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Register();
                              })),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
