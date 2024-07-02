import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/models/model.dart';
import 'package:transaction_app/network/featch_data.dart';

part 'featch_details_event.dart';
part 'featch_details_state.dart';

class FeatchDetailsBloc extends Bloc<FeatchDetailsEvent, FeatchDetailsState> {
  FeatchDetailsBloc() : super(FeatchDetailsInitial()) {
    on<FeatchDetailsEvent>((event, emit) async {
      emit(FeatchDetailsLoadingState());

      final AccountStatement? responce = await FeatchData.featchData();

      if (responce != null) {
        return emit(FeatchDetailsSuccessState(statement: responce));
      } else {
        return emit(FeatchDetailsErrorState());
      }
    });
  }
}
