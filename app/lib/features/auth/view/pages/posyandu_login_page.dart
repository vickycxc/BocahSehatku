import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/core/widgets/custom_field.dart';
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
    return WaveBackground(
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
              CustomField(
                label: 'Kode Posyandu',
                hintText: 'Kode Posyandu',
                keyboardType: TextInputType.text,
                controller: _usernameController,
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return 'Kode Posyandu Harus Diisi!';
                  }
                  return null;
                },
              ),
              CustomField(
                label: 'Password',
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                isObscure: true,
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return 'Kode Posyandu Harus Diisi!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 4),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle login logic here
                    // For example, call a login function with the username and password
                  }
                },
                text: 'Masuk',
              ),
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
