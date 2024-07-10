import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_featchdetails_event.dart';
part 'new_featchdetails_state.dart';

class NewFeatchdetailsBloc extends Bloc<NewFeatchdetailsEvent, NewFeatchdetailsState> {
  NewFeatchdetailsBloc() : super(NewFeatchdetailsInitial()) {
    on<NewFeatchdetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
