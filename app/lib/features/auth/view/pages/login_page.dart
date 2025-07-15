import 'package:app/core/theme/app_pallete.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:app/features/auth/view/widgets/bezier_curve_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return AuthBackground(child: Text('Halo'));
  }
}
