import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/exceptions.dart';
import 'package:chicpic/services/api_service.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';

import 'package:chicpic/models/auth/user.dart';
import 'package:chicpic/models/auth/login_user_data.dart';
import 'package:chicpic/models/auth/signup_user_data.dart';
import 'package:chicpic/models/auth/reset_password_data.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AppLoaded>(_onAppLoaded);
    on<SignupWithCredentials>(_onSignupWithCredentials);
    on<LoginWithCredentials>(_onLoginWithCredentials);
    on<AuthRequestVerificationCode>(_onAuthRequestVerificationCode);
    on<AuthCheckVerificationCode>(_onAuthCheckVerificationCode);
    on<AuthLogout>(_onAuthLogout);
    on<AuthResetPassword>(_onAuthResetPassword);
  }

  User? get user => _authRepository.user;

  String? get userEmail => user?.email;

  bool hasUserData() => _authRepository.user != null;

  Future<void> verifyUser() async {
    await _authRepository.verifyUser();
  }

  Future<void> _onAppLoaded(
    AppLoaded event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _authRepository.userCheckAuthentication();
      if (_authRepository.user != null) {
        if (_authRepository.user!.isVerified) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthNotVerified());
        }
      } else {
        emit(AuthNotAuthenticated());
      }
    } on UnAuthorizedException catch (_) {
      emit(AuthNotAuthenticated());
    } on TimeoutException catch (_) {
      emit(AuthConnectionProblem());
    } on ConnectionException catch (_) {
      emit(AuthConnectionProblem());
    } catch (error) {
      emit(AuthNotAuthenticated());
    }
  }

  Future<void> _onSignupWithCredentials(
      SignupWithCredentials event,
      Emitter<AuthState> emit,
      ) async {
    emit(SignupLoading());

    try {
      await _authRepository.signup(event.signupData);
      emit(SignupSuccess());
    } on BadRequestException catch (error) {
      if (error.errorMessage != null) {
        emit(SignupFailure(error: error.errorMessage!));
      } else {
        emit(SignupFailure(error: 'An error occurred'));
      }
    } catch (error) {
      emit(SignupFailure(error: error.toString()));
    }
  }

  Future<void> _onLoginWithCredentials(
    LoginWithCredentials event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());

    try {
      await _authRepository.login(event.loginData);
      emit(LoginSuccess());
    } on UnAuthorizedException catch (_) {  // Invalid Credentials
      emit(LoginInvalidCredentials());
    } on BadRequestException catch (error) {
      if (error.errorMessage == 'Your email is not verified.') {
        emit(LoginAccountNotVerified());
      } else {
        emit(LoginFailure(error: error.errorMessage ?? 'Login Failed.'));
      }
    } catch (_) {
      emit(LoginFailure(error: 'An error occurred.'));
    }
  }

  Future<void> _onAuthRequestVerificationCode(
    AuthRequestVerificationCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(VerificationLoading());

    try {
      await APIService.requestVerificationCode(event.email);
      emit(VerificationSent());
    } on BadRequestException catch (error) {
      emit(VerificationFailure(
          error: error.errorMessage ?? 'An error occurred'));
    } catch (_) {
      emit(VerificationFailure(error: 'Can not send verification code.'));
    }
  }

  Future<void> _onAuthCheckVerificationCode(
    AuthCheckVerificationCode event,
    Emitter<AuthState> emit,
  ) async {
    emit(VerificationLoading());

    try {
      await APIService.checkVerificationCode(event.email, event.code);
      emit(VerificationSuccess());
    } on BadRequestException catch (error) {
      emit(VerificationFailure(
          error: error.errorMessage ?? 'An error occurred'));
    } catch (_) {
      emit(VerificationFailure(error: 'An error occurred'));
    }
  }

  Future<void> _onAuthResetPassword(
    AuthResetPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await APIService.resetPassword(event.resetPasswordData);
      emit(AuthResetPasswordSuccess());
    } on BadRequestException catch (error) {
      emit(AuthResetPasswordFailure(
          error: error.errorMessage ?? 'An error occurred'));
    } catch (_) {
      emit(AuthResetPasswordFailure(error: 'An error occurred'));
    }
  }

  Future<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
  }

}
