// // cubit wiach handles the SocketioClientService status

// // create the state class
// import 'package:bloc/bloc.dart';

// class SocketStatusCubit extends Cubit<SocketStatusState> {
//   SocketStatusCubit() : super(const SocketStatusState.initial());

//   void connect() {
//     emit(const SocketStatusState.connecting());
//   }

//   void disconnect() {
//     emit(const SocketStatusState.disconnecting());
//   }

//   void connected() {
//     emit(const SocketStatusState.connected());
//   }

//   void disconnected() {
//     emit(const SocketStatusState.disconnected());
//   }
// }
