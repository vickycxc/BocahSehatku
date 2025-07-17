import 'package:http/http.dart' as http;

class AuthRemoteRepositories {
  Future<void> daftar() async {
    final response = await http.post(
      Uri.parse('http://192.168.4.36:3000/api/auth/daftar'),
    );
  }

  Future<void> masuk() async {}
  Future<void> masukPosyandu() async {}
}
