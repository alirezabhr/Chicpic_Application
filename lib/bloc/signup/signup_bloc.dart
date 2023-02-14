import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/services/exceptions.dart';
import 'package:chicpic/models/auth/signup_user_data.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _authRepository;

  SignupBloc(this._authRepository) : super(SignupInitial()) {
    on<SignupFormButtonPressed>(_onSignupFormButtonPressed);
    on<SocialSignupWithGoogle>(_onSocialSignupWithGoogle);
  }

  Future<void> _onSignupFormButtonPressed(
    SignupFormButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoadingWithForm());

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

  Future<void> _onSocialSignupWithGoogle(
    SocialSignupWithGoogle event,
    Emitter<SignupState> emit,
  ) async {}
}
