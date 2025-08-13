import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_notifier.g.dart';

@riverpod
class SharedPreferencesNotifier extends _$SharedPreferencesNotifier {
  @override
  SharedPreferences? build() {
    return null;
  }

  Future<void> initSharedPreferences() async {
    state = await SharedPreferences.getInstance();
  }
}
