import 'package:app/core/widgets/custom_button.dart';
import 'package:app/features/auth/view/widgets/auth_background.dart';
import 'package:app/features/auth/view/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class PosyanduLoginPage extends StatefulWidget {
  const PosyanduLoginPage({super.key});

  @override
  State<PosyanduLoginPage> createState() => _PosyanduLoginPageState();
}

class _PosyanduLoginPageState extends State<PosyanduLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      withBack: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Masuk ke Akun Posyandu',
                style: TextTheme.of(context).titleLarge,
              ),
              AuthField(
                label: 'Kode Posyandu',
                hintText: 'Kode Posyandu',
                keyboardType: TextInputType.text,
                controller: _usernameController,
              ),
              AuthField(
                label: 'Password',
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                isObscure: true,
              ),
              SizedBox(height: 4),
              CustomButton(onPressed: () {}, text: 'Masuk'),
              SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
