import 'package:app/core/widgets/custom_button.dart';
import 'package:app/core/widgets/wave_background.dart';
import 'package:app/core/widgets/custom_field.dart';
import 'package:app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PosyanduLoginPage extends ConsumerStatefulWidget {
  const PosyanduLoginPage({super.key});

  @override
  ConsumerState<PosyanduLoginPage> createState() => _PosyanduLoginPageState();
}

class _PosyanduLoginPageState extends ConsumerState<PosyanduLoginPage> {
  final TextEditingController _kodePosyanduController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
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
                controller: _kodePosyanduController,
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
                isLoading: isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .masukPosyandu(
                          kodePosyandu: _kodePosyanduController.text,
                          password: _passwordController.text,
                        );
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
    _kodePosyanduController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
