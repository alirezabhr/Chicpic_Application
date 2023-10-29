import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/repositories/auth/auth_repository.dart';

import 'package:chicpic/models/measurements/mass.dart';
import 'package:chicpic/models/measurements/length.dart';
import 'package:chicpic/models/measurements/shoe_size.dart';
import 'package:chicpic/models/auth/gender_choices.dart';
import 'package:chicpic/models/auth/shirt_fit.dart';
import 'package:chicpic/models/auth/trouser_fit.dart';
import 'package:chicpic/models/auth/user_additional.dart';

part 'user_additional_event.dart';

part 'user_additional_state.dart';

class DefaultUserAdditionalConfig {
  static final Mass weight = Mass(value: 60);
  static final Length height = Length(cmValue: 160);
  static const DateTime? birthDate = null;
  static const gender = GenderChoices.women;
  static final Length shoulderSize = Length(cmValue: 80);
  static final Length chestSize = Length(cmValue: 60);
  static final Length bustSize = Length(cmValue: 60);
  static final Length waistSize = Length(cmValue: 50);
  static final Length hipsSize = Length(cmValue: 80);
  static final Length inseam = Length(cmValue: 110);
  static final ShoeSize shoeSize = ShoeSize(gender: gender);
  static final List<ShirtFit> shirtFits = [];
  static final List<TrouserFit> trouserFits = [];
}

class UserAdditionalBloc
    extends Bloc<UserAdditionalEvent, UserAdditionalState> {
  final AuthRepository _authRepository;

  UserAdditionalBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(UserAdditionalInitial()) {
    _loadUserAdditionalValues();
    on<UserAdditionalInitialize>(_onUserAdditionalInitialize);
    on<UserAdditionalChangeStep>(_onUserAdditionalChangeStep);
    on<UserAdditionalSubmit>(_onUserAdditionalSubmit);
  }

  late Mass weight;
  late Length height;
  DateTime? birthDate;
  late GenderChoices gender;
  late Length shoulderSize;
  late Length? chestSize;
  late Length? bustSize;
  late Length waistSize;
  late Length hipsSize;
  late Length inseam;
  late ShoeSize shoeSize;
  late List<ShirtFit> shirtFits;
  late List<TrouserFit> trouserFits;

  void _loadUserAdditionalValues() {
    if (_authRepository.user?.userAdditional != null) {
      // load user additional values
      UserAdditional userAdditional = _authRepository.user!.userAdditional!;

      weight = Mass(value: userAdditional.weight);
      height = Length(cmValue: userAdditional.height);
      birthDate = userAdditional.birthDate;
      gender = userAdditional.genderInterested;
      shoulderSize = Length(cmValue: userAdditional.shoulderSize);
      chestSize = userAdditional.chestSize != null
          ? Length(cmValue: userAdditional.chestSize!)
          : null;
      bustSize = userAdditional.bustSize != null
          ? Length(cmValue: userAdditional.bustSize!)
          : null;
      waistSize = Length(cmValue: userAdditional.waistSize);
      hipsSize = Length(cmValue: userAdditional.hipsSize);
      inseam = Length(cmValue: userAdditional.inseam);
      shoeSize = ShoeSize(gender: gender, value: userAdditional.shoeSize);
      shirtFits = userAdditional.shirtFits;
      trouserFits = userAdditional.trouserFits;
    } else {
      // load default values
      weight = DefaultUserAdditionalConfig.weight;
      height = DefaultUserAdditionalConfig.height;
      birthDate = DefaultUserAdditionalConfig.birthDate;
      gender = DefaultUserAdditionalConfig.gender;
      shoulderSize = DefaultUserAdditionalConfig.shoulderSize;
      chestSize = DefaultUserAdditionalConfig.chestSize;
      bustSize = DefaultUserAdditionalConfig.bustSize;
      waistSize = DefaultUserAdditionalConfig.waistSize;
      hipsSize = DefaultUserAdditionalConfig.hipsSize;
      inseam = DefaultUserAdditionalConfig.inseam;
      shoeSize = DefaultUserAdditionalConfig.shoeSize;
      shirtFits = DefaultUserAdditionalConfig.shirtFits;
      trouserFits = DefaultUserAdditionalConfig.trouserFits;
    }
  }

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
        shoulderSize: (shoulderSize..convertToCm()).cmValue,
        chestSize: (chestSize?..convertToCm())?.cmValue,
        bustSize: (bustSize?..convertToCm())?.cmValue,
        waistSize: (waistSize..convertToCm()).cmValue,
        hipsSize: (hipsSize..convertToCm()).cmValue,
        inseam: (inseam..convertToCm()).cmValue,
        shoeSize: (shoeSize..convertToUs()).value,
        shirtFits: shirtFits,
        trouserFits: trouserFits,
      );

      await _authRepository.submitUserAdditional(userAdditional);
      emit(UserAdditionalSubmitSuccess());
    } catch (e) {
      emit(UserAdditionalSubmitFailure(error: e.toString()));
    }
  }
}
