import 'dart:async';

import 'package:bloc/bloc.dart';
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
    on<UserAdditionalSubmit>(_onUserAdditionalSubmit);
  }

  Mass weight = Mass(value: 60);
  Length height = Length(cmValue: 160);
  DateTime? birthDate;
  UserAdditionalInterestedGender? gender;
  Length bustSize = Length(cmValue: 60);
  Length waistSize = Length(cmValue: 50);
  Length hipSize = Length(cmValue: 80);
  Length legLength = Length(cmValue: 110);
  int? shoeSize;
  List<ShirtFit> shirtFits = [];
  List<TrouserFit> trouserFits = [];

  FutureOr<void> _onUserAdditionalSubmit(
    UserAdditionalSubmit event,
    Emitter<UserAdditionalState> emit,
  ) {

  }
}
