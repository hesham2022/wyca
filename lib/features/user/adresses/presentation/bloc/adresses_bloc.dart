import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adresses_event.dart';
part 'adresses_state.dart';

class AdressesBloc extends Bloc<AdressesEvent, AdressesState> {
  AdressesBloc() : super(AdressesInitial()) {
    on<AdressesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
