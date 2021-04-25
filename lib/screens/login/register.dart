
import 'package:flutter/material.dart';
import 'package:goo/screens/login/form_feild.dart';
import 'package:goo/screens/login/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  bool show = true;
  String phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF0A0A0A),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.orange,
        ),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 60),
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/Artboard 1xhdpi.png'),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: EdgeInsets.only(top: 30),

                    child: ListView(
                      children: [
                        Center(
                          child: Text(
                            'Create account',
                            style: GoogleFonts.k2d(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          controller: _emailController,
                          hint: 'Username or email',
                          prefixIcon: Icons.supervised_user_circle,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter text';
                            }
                            return null;
                          },
                        ),
                        InputField(
                          // inputFormatters: [
                          //   // [LengthLimitingTextInputFormatter(9)]
                          // ],
                          controller: _phoneController,
                          hint: 'Phone number',
                          prefixIcon: Icons.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter text';
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
                              return 'Enter text';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 15, left: 30, right: 30),
                          child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                // functionality here
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orange),
                                child: Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 70, top: 15),
                          child: Row(
                            children: [
                              Text(
                                'Already have an account?',
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Login();
                                })),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.k2d(
                                      color: Colors.orange,
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
              ],
            )),
      ),
    );
  }
}
