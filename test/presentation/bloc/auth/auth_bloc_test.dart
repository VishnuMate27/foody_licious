import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/send_verification_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_facebook.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_out_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_login_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_registration_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/wait_for_email_verification_usecase.dart';
import 'package:foody_licious/presentation/bloc/auth/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockSignInWithEmailUseCase extends Mock
    implements SignInWithEmailUseCase {}

class MockVerifyPhoneNumberForLoginUseCase extends Mock
    implements VerifyPhoneNumberForLoginUseCase {}

class MockSignInWithPhoneUseCase extends Mock
    implements SignInWithPhoneUseCase {}

class MockSignInWithGoogleUseCase extends Mock
    implements SignInWithGoogleUseCase {}

class MockSignInWithFacebookUseCase extends Mock
    implements SignInWithFacebookUseCase {}

class MockSendPasswordResetEmailUseCase extends Mock
    implements SendPasswordResetEmailUseCase {}

class MockSignUpWithEmailUseCase extends Mock
    implements SignUpWithEmailUseCase {}

class MockSendVerificationEmailUseCase extends Mock
    implements SendVerificationEmailUseCase {}

class MockWaitForEmailVerificationUsecase extends Mock
    implements WaitForEmailVerificationUsecase {}

class MockVerifyPhoneNumberForRegistrationUseCase extends Mock
    implements VerifyPhoneNumberForRegistrationUseCase {}

class MockSignUpWithPhoneUseCase extends Mock
    implements SignUpWithPhoneUseCase {}

class MockSignUpWithGoogleUseCase extends Mock
    implements SignUpWithGoogleUseCase {}

class MockSignUpWithFacebookUseCase extends Mock
    implements SignUpWithFacebookUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late SignInWithEmailUseCase mockSignInWithEmailUseCase;
    late VerifyPhoneNumberForLoginUseCase mockVerifyPhoneNumberForLoginUseCase;
    late SignInWithPhoneUseCase mockSignInWithPhoneUseCase;
    late SignInWithGoogleUseCase mockSignInWithGoogleUseCase;
    late SignInWithFacebookUseCase mockSignInWithFacebookUseCase;
    late SendPasswordResetEmailUseCase mockSendPasswordResetEmailUseCase;
    late SignUpWithEmailUseCase mockSignUpWithEmailUseCase;
    late SendVerificationEmailUseCase mockSendVerificationEmailUseCase;
    late WaitForEmailVerificationUsecase mockWaitForEmailVerificationUseCase;
    late VerifyPhoneNumberForRegistrationUseCase
        mockVerifyPhoneNumberForRegistrationUseCase;
    late SignUpWithPhoneUseCase mockSignUpWithPhoneUseCase;
    late SignUpWithGoogleUseCase mockSignUpWithGoogleUseCase;
    late SignUpWithFacebookUseCase mockSignUpWithFacebookUseCase;
    late SignOutUseCase mockSignOutUseCase;

    setUp(() {
      mockSignInWithEmailUseCase = MockSignInWithEmailUseCase();
      mockVerifyPhoneNumberForLoginUseCase =
          MockVerifyPhoneNumberForLoginUseCase();
      mockSignInWithPhoneUseCase = MockSignInWithPhoneUseCase();
      mockSignInWithGoogleUseCase = MockSignInWithGoogleUseCase();
      mockSignInWithFacebookUseCase = MockSignInWithFacebookUseCase();
      mockSendPasswordResetEmailUseCase = MockSendPasswordResetEmailUseCase();
      mockSignUpWithEmailUseCase = MockSignUpWithEmailUseCase();
      mockSendVerificationEmailUseCase = MockSendVerificationEmailUseCase();
      mockWaitForEmailVerificationUseCase =
          MockWaitForEmailVerificationUsecase();
      mockVerifyPhoneNumberForRegistrationUseCase =
          MockVerifyPhoneNumberForRegistrationUseCase();
      mockSignUpWithPhoneUseCase = MockSignUpWithPhoneUseCase();
      mockSignUpWithGoogleUseCase = MockSignUpWithGoogleUseCase();
      mockSignUpWithFacebookUseCase = MockSignUpWithFacebookUseCase();
      mockSignOutUseCase = MockSignOutUseCase();
      authBloc = AuthBloc(
          mockSignInWithEmailUseCase,
          mockVerifyPhoneNumberForLoginUseCase,
          mockSignInWithPhoneUseCase,
          mockSignInWithGoogleUseCase,
          mockSignInWithFacebookUseCase,
          mockSendPasswordResetEmailUseCase,
          mockSignUpWithEmailUseCase,
          mockSendVerificationEmailUseCase,
          mockWaitForEmailVerificationUseCase,
          mockVerifyPhoneNumberForRegistrationUseCase,
          mockSignUpWithPhoneUseCase,
          mockSignUpWithGoogleUseCase,
          mockSignUpWithFacebookUseCase,
          mockSignOutUseCase);
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    //_onSignInWithEmail
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailSuccess] when _onSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Right(tUserModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () => [AuthLoading(), AuthSignInWithEmailSuccess(tUserModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailFailed] when _onSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Error message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthSignInWithEmailFailed(ExceptionFailure("Error message"))
      ],
    );
  });
}
