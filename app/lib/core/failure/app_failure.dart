// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppFailure {
  final String message;
  // final int statusCode;
  AppFailure([this.message = 'Maaf, terjadi kesalahan. Silakan coba lagi!']);

  @override
  String toString() => 'AppFailure(message: $message)';
}
