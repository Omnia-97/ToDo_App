import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:text_divider/text_divider.dart';
import 'package:todo_app_new/features/layout_home/layout_view.dart';
import 'package:todo_app_new/features/login/pages/forgot_pw_page.dart';
import 'package:todo_app_new/features/login/widgets/custom_textformfield.dart';
import 'package:todo_app_new/features/register/pages/register_screen.dart';
import 'package:todo_app_new/features/settings_provider.dart';
import 'package:todo_app_new/firebase/firebase_functions.dart';

import '../../../core/config/app_theme_manager.dart';
import '../widgets/customicon_text.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login screen';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<MyProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        color: Color(0xFFDFECDB),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 115,
          centerTitle: true,
          title: Text(
            'LogIn',
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 24),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQuery.height * 0.17,
                  ),
                  Text(
                    'Welcome back!',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'E-mail',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: 'Enter your e-mail address',
                    suffixIcon: Icon(Icons.email_rounded),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter your email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Password',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  CustomTextFormFieldRegister(
                    hintText: 'Enter your password',
                    isPassword: true,
                    controller: passwordController,
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "please enter your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ForgotPasswordPage();
                            }),
                          );
                        },
                        child: Text(
                          'Forgot password ?',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 295,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FirebaseFunctions.signInUser(
                              emailController.text, passwordController.text,
                              () {
                            provider.initUser();
                            Navigator.pushNamedAndRemoveUntil(context,
                                LayoutView.routeName, (route) => false);
                          }, (error) {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(error),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('try again'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text('cancel'),
                                      ),
                                    ],
                                  );
                                });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemeManager.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 23),
                    child: TextDivider.horizontal(
                        text: Text(
                          '  OR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        thickness: 1,
                        color: Color(0xff565656),
                        indent: 8,
                        endIndent: 8),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FirebaseFunctions.signInWithGoogle();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LayoutView.routeName, (route) => false);
                    },
                    child: CustomIconText(
                        icon: Brand(Brands.google),
                        iconText: 'Login with Google'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: CustomIconText(
                        icon: Icon(
                          Icons.facebook,
                          color: Color(0xff1778F2),
                          size: 30,
                        ),
                        iconText: 'Login with Facebook'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 85,
                      right: 60,
                      top: 31,
                      bottom: 25,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Don’t have an account? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xff474747)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xff474747),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
