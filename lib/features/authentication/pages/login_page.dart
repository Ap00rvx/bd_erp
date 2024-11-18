import 'package:bd_erp/components/snack_bar.dart';
import 'package:bd_erp/features/authentication/bloc/auth_bloc.dart';
import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/features/home/page/home_page.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _username = TextEditingController();
  final _password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool obsure = true;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          }
          if (state is AuthFailure) {
            Navigator.pop(context);
            print(state.message);
          }
          if (state is AuthLoading) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: AlertDialog(
                      backgroundColor: Colors.transparent,
                      title: SizedBox(
                        height: 100,
                        width: 100,
                        child: SpinKitWaveSpinner(
                          color: Colors.white,
                          size: 50.0,
                          controller: AnimationController(
                              vsync: this,
                              duration: const Duration(milliseconds: 1200)),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Gap(50),
                    Image.asset(
                      "assets/image/login.png",
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 350),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppThemes.backgroundLightGrey.withOpacity(0.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Login',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            const Gap(10),
                            TextField(
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              controller: _username,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppThemes.white),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppThemes.white),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const Gap(20),
                            TextField(
                              onChanged: (s) {
                                setState(() {});
                              },
                              obscureText: obsure,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              controller: _password,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                suffixIcon: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity:
                                      _password.text.isNotEmpty == true ? 1 : 0,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obsure = !obsure;
                                      });
                                    },
                                    icon: obsure == false
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                ),
                                suffixIconColor: AppThemes.white,
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppThemes.white),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppThemes.white),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: check,
                                  onChanged: (val) {
                                    setState(() {
                                      check = val!;
                                    });
                                  },
                                  checkColor: AppThemes.black,
                                  activeColor: AppThemes.highlightYellow,
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                      color: AppThemes.highlightYellow),
                                )
                              ],
                            ),
                            const Gap(20),
                            ElevatedButton(
                              onPressed: () async {
                                if (_username.text.isEmpty ||
                                    _password.text.isEmpty) {
                                  Snack()
                                      .show('Please fill all fields', context);
                                } else {
                                  if (check) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('username', _username.text);
                                    prefs.setString('password', _password.text);
                                  }
                                  BlocProvider.of<AuthBloc>(context).add(
                                      LoginEvent(
                                          _username.text, _password.text));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppThemes.highlightYellow,
                                fixedSize: const Size(400, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
