import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:untitled/presentation/viewmodels/shared/notification_exception.dart';

import '../../../application/authentication/auth_use_case.dart';
import '../../../utils/app_logger.dart';
import '../shared/exception_handler_on_viewmodel.dart';

part 'password_update_viewmodel.g.dart';

@riverpod
class RequestPasswordUpdateAuthCodeController
    extends _$RequestPasswordUpdateAuthCodeController {
  @override
  FutureOr<void> build() {
    logger.d('Execute RequestPasswordUpdateAuthCodeController.build');
  }

  Future<void> execute({
    required String email,
  }) async {
    logger.d('Execute RequestPasswordUpdateAuthCodeController.execute');
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        try {
          await ref.refresh(
            requestPasswordUpdateAuthCodeUseCaseProvider(
              email: email,
            ).future,
          );
        } catch (e, stackTrace) {
          exceptionHandlerOnViewmodel(
              e: e as Exception, stackTrace: stackTrace);
        }
      },
    );
  }
}

@riverpod
class VerifyPasswordUpdateAuthCodeController
    extends _$VerifyPasswordUpdateAuthCodeController {
  @override
  FutureOr<void> build() {
    logger.d('Execute VerifyPasswordUpdateAuthCodeController.build');
  }

  Future<void> execute({
    required String email,
    required String authCode,
  }) async {
    logger.d('Execute VerifyPasswordUpdateAuthCodeController.execute');
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        try {
          await ref.refresh(
            verifyPasswordUpdateAuthCodeUseCaseProvider(
              email: email,
              authCode: authCode,
            ).future,
          );
        } catch (e, stackTrace) {
          exceptionHandlerOnViewmodel(
              e: e as Exception, stackTrace: stackTrace);
        }
      },
    );
  }
}

@riverpod
class UpdatePasswordController extends _$UpdatePasswordController {
  @override
  FutureOr<void> build() {
    logger.d('Execute UpdatePasswordController.build');
  }

  Future<void> execute({
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    logger.d('Execute UpdatePasswordController.execute');
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        if (password != passwordConfirm) {
          throw NotificationException("비밀번호가 일치하지 않습니다. 다시 입력해 주세요.");
        }
        try {
          await ref.refresh(
            updatePasswordUseCaseProvider(
              email: email,
              password: password,
              passwordConfirm: passwordConfirm,
            ).future,
          );
        } catch (e, stackTrace) {
          exceptionHandlerOnViewmodel(
              e: e as Exception, stackTrace: stackTrace);
        }
      },
    );
  }
}
