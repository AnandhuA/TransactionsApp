import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottam_navigation_event.dart';
part 'bottam_navigation_state.dart';

class BottamNavigationBloc
    extends Bloc<BottamNavigationEvent, BottamNavigationState> {
  BottamNavigationBloc() : super(BottamNavigationState(0)) {
    on<TabChanged>((event, emit) => emit(BottamNavigationState(event.index)));
  }
}
