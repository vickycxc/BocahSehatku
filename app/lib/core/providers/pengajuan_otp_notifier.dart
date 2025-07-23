import 'package:app/features/auth/model/pengajuan_otp_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengajuan_otp_notifier.g.dart';

@riverpod
class PengajuanOtpNotifier extends _$PengajuanOtpNotifier {
  @override
  PengajuanOtpModel? build() {
    return null;
  }

  void aturPengajuanOtp(PengajuanOtpModel otp) {
    state = otp;
  }

  void hapusPengajuanOtp() {
    state = null;
  }
}
