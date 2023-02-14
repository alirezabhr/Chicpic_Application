import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/services/exceptions.dart';
import 'package:chicpic/repositories/auth/auth_repository.dart';
import 'package:chicpic/models/auth/login_user_data.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginWithUsernamePassword>(_onLoginWithUsernamePassword);
    on<SocialLoginWithGoogle>(_onSocialLoginWithGoogle);
  }

  Future<void> _onLoginWithUsernamePassword(
    LoginWithUsernamePassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingWithForm());

    try {
      await _authRepository.login(event.userData);
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

  Future<void> _onSocialLoginWithGoogle(
    SocialLoginWithGoogle event,
    Emitter<LoginState> emit,
  ) async {}
}
