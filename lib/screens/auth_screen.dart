//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/bloc_auth_and_registration/auth_bloc.dart';
import 'package:flutter_rick_and_morty/screens/bottom_bar_screen.dart';
//import 'package:flutter_rick_and_morty/screens/character_search_screen.dart';
import 'package:flutter_rick_and_morty/screens/registration_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final AuthBloc bloc;

  @override
  void initState() {
    bloc = AuthBloc();
    bloc.add(checkUserAccsec());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 376.h,
                    width: 267.w,
                    child: Image.asset(
                      'assets/Group 2.png',
                      fit: BoxFit.contain,
                      //height: 376.h,
                      //width: 267.w,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Логин",
                      style:
                          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: loginController,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/User, Profile.32.png',
                        width: 10.w,
                        height: 10.h,
                      ), //Icon(Icons.person, size: 22.sp),
                      hintText: "Логин",
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Пароль",
                      style:
                          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/Lock, Password, Login.png',
                        width: 24.w,
                        height: 24.h,
                      ), //Icon(Icons.lock, size: 22.sp),
                      hintText: "Пароль",
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  BlocConsumer<AuthBloc, AuthState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is AuthSucces) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const BottomBarScreen(), //const CharacterSearchScreen(),
                          ),
                        );
                      } else if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: 340.w,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  AuthLogin(
                                    loginController.text,
                                    passwordController.text,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: state is AuthLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Войти",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "У вас еще нет аккаунта?",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegistrationScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Создать',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
