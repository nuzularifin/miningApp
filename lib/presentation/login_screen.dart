import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_synapsys/core/themes/app_color.dart';
import 'package:flutter_test_synapsys/core/themes/app_text_styles.dart';
import 'package:flutter_test_synapsys/data/model/request/login_tablet_request.dart';
import 'package:flutter_test_synapsys/presentation/bloc/login_bloc.dart';
import 'package:flutter_test_synapsys/presentation/bloc/login_event.dart';
import 'package:flutter_test_synapsys/presentation/bloc/login_state.dart';
import 'package:flutter_test_synapsys/presentation/bloc/map/map_bloc.dart';
import 'package:flutter_test_synapsys/presentation/dashboard_screen.dart';
import 'package:flutter_test_synapsys/core/service_locator.dart' as di;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  double _progress = 0.0;

  void _startProgress() {
    const duration = Duration(milliseconds: 1000);
    const totalDuration = 3 * 1000;
    final steps = totalDuration ~/ duration.inMilliseconds;

    Timer.periodic(duration, (timer) {
      setState(() {
        _progress += 1 / steps;
      });

      if (_progress >= 1.0) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => MapBloc(di.sl()),
                    child: const DashboardScreen(),
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child:
                BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
              if (state is LoginTabletSuccess) {
                return welcomeContent(state);
              }

              return loginContent(state);
            }, listener: (context, state) {
              if (state is LoginTabletSuccess) {
                _startProgress();
              }
            }),
          ),
        ));
  }

  Widget loginContent(LoginState state) => Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Login by Code',
                style: AppTextStyles.labelBlackBold24,
              ),
              const SizedBox(
                height: 24.0,
              ),
              const Text(
                'Enter your NIK',
                style: AppTextStyles.labelGrayBold18,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _nikController,
                  decoration: InputDecoration(
                      hintText: 'Enter NIK',
                      hintStyle: const TextStyle(
                        color: AppColors.Gray,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NiK required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              state is LoginTabletFailure
                  ? const Text(
                      'Cant Find your NIK',
                      style: AppTextStyles.labelRed18,
                    )
                  : Container(
                      width: 300,
                    ),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                width: 300,
                child: BlocConsumer<LoginBloc, LoginState>(builder: (_, state) {
                  if (state is LoginTabletLoading) {
                    return const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          backgroundColor: Colors.blue[400]),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle login logic
                          final request = LoginTabletRequest(
                            unitId: 'cb6eeecc29',
                            nik: _nikController.text,
                            shiftId: '',
                            loginType: 1,
                          );
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginTablet(request));
                        }
                      },
                      child: const Text('Login'),
                    ),
                  );
                }, listener: (_, state) {
                  if (state is LoginTabletSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColors.onSuccess,
                        content: Text('Login successful'),
                      ),
                    );
                  }
                  if (state is LoginTabletFailure) {}
                }),
              ),
              const SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      );

  Widget welcomeContent(LoginState state) => SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              color: AppColors.Blue,
              child: const Center(
                child: Text(
                  'Welcome Back',
                  style: AppTextStyles.labelWhite24,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.Gray,
                    backgroundImage: AssetImage('assets/images/ic_profile.png'),
                  ),
                  const SizedBox(width: 18),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state is LoginTabletSuccess ? state.name : '',
                        style: AppTextStyles.labelBlackBold18,
                      ),
                      Text(state is LoginTabletSuccess ? state.roleName : ''),
                    ],
                  ),
                  const SizedBox(width: 18),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      );
}
