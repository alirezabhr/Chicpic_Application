import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:chicpic/models/measurement_units.dart';
import 'package:chicpic/models/auth/shirt_fit.dart';
import 'package:chicpic/models/auth/trouser_fit.dart';
import 'package:chicpic/models/auth/user_additional.dart';

part 'user_additional_event.dart';

part 'user_additional_state.dart';

class UserAdditionalBloc
    extends Bloc<UserAdditionalEvent, UserAdditionalState> {
  UserAdditionalBloc() : super(UserAdditionalInitial()) {
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
  ) {

  }
}
