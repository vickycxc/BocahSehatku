import 'package:app/features/auth/model/verification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verification_notifier.g.dart';

@riverpod
class VerificationNotifier extends _$VerificationNotifier {
  @override
  VerificationModel? build() {
    return null;
  }

  void setVerification(VerificationModel verification) {
    state = verification;
  }

  void removeVerification() {
    state = null;
  }
}
