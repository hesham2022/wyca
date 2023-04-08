import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/chat/data/models/chat_model.dart';
import 'package:wyca/features/chat/domain/entities/chat_params.dart';
import 'package:wyca/features/chat/domain/repositories/i_chat_repository.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/chat_screen.dart';

class Chat extends Equatable {
  Chat(this.id);

  final String id;
  final List<Message> msgs = [];

  @override
  List<Object?> get props => [msgs];
}

class ChatStat extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatStatIntitial extends ChatStat {}

class ChatStatLoading extends ChatStat {}

class ChatStatLoaded extends ChatStat {
  ChatStatLoaded(this.chats);

  final List<Chat> chats;

  @override
  List<Object?> get props => [chats];
}

class ChatCubit extends Cubit<ChatStat> {
  ChatCubit() : super(ChatStatIntitial());
  final IChatRespository chatRespository = getIt();
  final chatModels = <ChatModel>[];
  Future<void> createChat(CreateChatParams params) async {
    emit(ChatStatLoading());
    final result = await chatRespository.createChat(params);
    emit(ChatStatLoaded(const []));
    result.fold((l) => print(l.errorMessege), (r) {
      chatModels.add(r);
      addNewChat(r.id!, r.id!);
    });
  }

  Future<void> addNewChat(
    String id,
    String chatId,
  ) async {
    if (state is ChatStatLoaded) {
      final chats = (state as ChatStatLoaded).chats;

      if (!(state as ChatStatLoaded).chats.map((e) => e.id).contains(id)) {
        emit(ChatStatLoading());
        emit(ChatStatLoaded([Chat(id), ...chats]));
      }
    } else {
      emit(ChatStatLoaded([Chat(id)]));
    }
  }

  // void addNewMessage(
  //   String senderId,
  //   String msg,
  //   String chatId,
  //   String senderType,
  // ) {
  //   if (chatModels.map((e) => e.id).contains(chatId)) {
  //     final chatModel =
  //         chatModels.firstWhere((element) => element.id == chatId);
  //     Fluttertoast.showToast(msg: msg);
  //     chatModel.messages!.add(
  //       Messages(
  //         senderType: senderType,
  //         senderId: senderId,
  //         chat: chatId,
  //         text: msg,
  //         id: DateTime.now().toString(),
  //         time: 
  //       ),
  //     );
  //   }
  //   if (state is ChatStatLoaded) {
  //     final chat =
  //         (state as ChatStatLoaded).chats.firstWhere((e) => e.id == senderId);
  //     chat.msgs.add(Message(text: msg, isMe: false, time: DateTime.now()));
  //     final _chats = [...(state as ChatStatLoaded).chats];
  //     emit(ChatStatLoading());
  //     emit(ChatStatLoaded(_chats));
  //   }
  // }

  void addMessage(
    Messages msg,
  ) {
    if (state is ChatStatLoaded) {
      if (chatModels.map((e) => e.id).contains(msg.chat)) {
        final chatModel =
            chatModels.firstWhere((element) => element.id == msg.chat);
      
        chatModel.messages!.add(
          msg,
        );
      }

      final _chats = [...(state as ChatStatLoaded).chats];
      emit(ChatStatLoading());
      emit(ChatStatLoaded(_chats));
    }
  }

  void addNewMessageFromMe(
    String senderId,
    String receiverId,
    String msg,
    Socket socket,
    String senderType,
    String chatId,
  ) {
    addNewChat(receiverId, chatId);
    //   if (state is ChatStatLoaded) {
    //   if (chatModels.map((e) => e.id).contains(chatId)) {
    //     final chatModel =
    //         chatModels.firstWhere((element) => element.id == chatId);
      
    //     chatModel.messages!.add(
    //       Messages(
    //         senderId: senderId,
    //         time: DateTime.now(),
    //         text: msg, 
    //         i
    //       ),
    //     );
    //   }

    //   final _chats = [...(state as ChatStatLoaded).chats];
    //   emit(ChatStatLoading());
    //   emit(ChatStatLoaded(_chats));
    // }
    socket.emit(
      'sendMessage',
      <String, dynamic>{
        'senderId': senderId,
        'senderType': senderType,
        'receiverId': receiverId,
        'text': msg,
        'chatId': chatId
      },
    );

    final chat =
        (state as ChatStatLoaded).chats.firstWhere((e) => e.id == receiverId);
    chat.msgs.add(Message(text: msg, isMe: true, time: DateTime.now()));

    final _chats = [...(state as ChatStatLoaded).chats];
    emit(ChatStatLoading());

    emit(ChatStatLoaded(_chats));
  }
}
