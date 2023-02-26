import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';

import 'package:chicpic/models/measurement_units.dart';
import 'package:chicpic/models/auth/shirt_fit.dart';
import 'package:chicpic/models/auth/trouser_fit.dart';
import 'package:chicpic/models/auth/user_additional.dart';

part 'user_additional_event.dart';

part 'user_additional_state.dart';

class UserAdditionalBloc
    extends Bloc<UserAdditionalEvent, UserAdditionalState> {
  final AuthRepository _authRepository;

  UserAdditionalBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(UserAdditionalInitial()) {
    on<UserAdditionalInitialize>(_onUserAdditionalInitialize);
    on<UserAdditionalChangeStep>(_onUserAdditionalChangeStep);
    on<UserAdditionalSubmit>(_onUserAdditionalSubmit);
  }

  Mass weight = Mass(value: 60);
  Length height = Length(cmValue: 160);
  DateTime? birthDate;
  UserAdditionalInterestedGender gender = UserAdditionalInterestedGender.female;
  Length bustSize = Length(cmValue: 60);
  Length waistSize = Length(cmValue: 50);
  Length hipSize = Length(cmValue: 80);
  Length legLength = Length(cmValue: 110);
  double? shoeSize;
  List<ShirtFit> shirtFits = [];
  List<TrouserFit> trouserFits = [];

  int _formStep = 0;

  FutureOr<void> _onUserAdditionalInitialize(
    UserAdditionalInitialize event,
    Emitter<UserAdditionalState> emit,
  ) {
    _formStep = 0;
    emit(UserAdditionalInitial());
  }

  FutureOr<void> _onUserAdditionalChangeStep(
    UserAdditionalChangeStep event,
    Emitter<UserAdditionalState> emit,
  ) {
    if (event.increasing) {
      _formStep += 1;
      emit(UserAdditionalStepChanged(_formStep));
    } else {
      _formStep -= 1;
      emit(UserAdditionalStepChanged(_formStep));
    }
  }

  FutureOr<void> _onUserAdditionalSubmit(
    UserAdditionalSubmit event,
    Emitter<UserAdditionalState> emit,
  ) async {
    try {
      emit(UserAdditionalLoading());

      UserAdditional userAdditional = UserAdditional(
        user: _authRepository.user!.id,
        genderInterested: gender,
        weight: (weight..convertToKg()).value,
        height: (height..convertToCm()).cmValue,
        birthDate: birthDate!,
        bustSize: (bustSize..convertToCm()).cmValue,
        waistSize: (waistSize..convertToCm()).cmValue,
        hipSize: (hipSize..convertToCm()).cmValue,
        legLength: (legLength..convertToCm()).cmValue,
        shoeSize: shoeSize!,
        shirtFits: shirtFits,
        trouserFits: trouserFits,
      );
      await _authRepository.createUserAdditional(userAdditional);
      emit(UserAdditionalSubmitSuccess());
    } catch (e) {
      emit(UserAdditionalSubmitFailure(error: e.toString()));
    }
  }
}
