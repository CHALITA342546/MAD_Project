import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mutu/Pages/navigatorbar.dart';
import 'package:mutu/registerandlogin/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mutu/registerandlogin/profile.dart';
import 'package:mutu/registerandlogin/forgetpassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController inputUsername = TextEditingController();
  final TextEditingController inputPassword = TextEditingController();
  Profile user = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formkey = GlobalKey<FormState>();
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }

          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_rounded,
                          color: Color(0xFFFAD6A5),
                          size: 80,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('MUTU',
                            style: Theme.of(context).textTheme.headlineLarge),
                        Text('Welcome Back to MUTU, Easy 2 Sell && Easy 2 Buy ',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email) => user.set_email(email!),
                            validator: MultiValidator([
                              EmailValidator(errorText: 'Email invalid syntax'),
                              RequiredValidator(
                                  errorText: 'Please enter email address')
                            ]),
                            decoration: const InputDecoration(labelText: 'Email')
                                .applyDefaults(Theme.of(context)
                                    .inputDecorationTheme
                                    .copyWith(
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .headlineSmall))),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            obscureText: obscurePassword,
                            onSaved: (String? password) =>
                                user.set_password(password!),
                            validator: RequiredValidator(
                                errorText: 'Please enter password '),
                            decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          obscurePassword = !obscurePassword;
                                        });
                                      },
                                    ))
                                .applyDefaults(Theme.of(context)
                                    .inputDecorationTheme
                                    .copyWith(
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .headlineSmall))),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const Forgetpassword())));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forget password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: user.get_email,
                                          password: user.get_password)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: 'Success',
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: const Color(0xFFFAD6A5),
                                        textColor: const Color(0xFF344D67));
            
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Navigatorbar()));
                                  });
                                } on FirebaseAuthException catch (e) {
                                  Fluttertoast.showToast(
                                      msg: e.message!,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: const Color(0xFFFAD6A5),
                                      textColor: const Color(0xFF344D67));
                                }
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFFAD6A5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text('Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontSize: 15,
                                                color: const Color(0xFF344D67),
                                                fontWeight: FontWeight.bold))))),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Not a member? ',
                                style: Theme.of(context).textTheme.headlineSmall),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Register()));
                                },
                                child: Text('Register now',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
