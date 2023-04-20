import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final ip = TextEditingController();
  @override
  void dispose() {
    ip.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: ip.text.trim());
      
      // showDialog(
      //     context: context,
      //     builder: ((context) {
      //       return AlertDialog(
      //         content: Text('Password reset link sent! Check your email'),
      //       );
      //     }));
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: e.message!,
          gravity: ToastGravity.CENTER,
          backgroundColor: const Color(0xFFFAD6A5),
          textColor: const Color(0xFF344D67));
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please input your email to reset password',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: MultiValidator([
                    EmailValidator(errorText: 'Email invalid syntax'),
                    RequiredValidator(errorText: 'Plase enter email address')
                  ]),
                  controller: ip,
                  decoration: const InputDecoration(labelText: 'Email').applyDefaults(
                      Theme.of(context).inputDecorationTheme.copyWith(
                          labelStyle:
                              Theme.of(context).textTheme.headlineSmall)),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        passwordReset();
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFAD6A5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Reset Password',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontSize: 15,
                                  color: const Color(0xFF344D67),
                                  fontWeight: FontWeight.bold),
                        ))),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const Login()));
                    },
                    child: Text('Change your mind?',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
