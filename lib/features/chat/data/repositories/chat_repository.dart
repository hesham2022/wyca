import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/chat/data/datasources/chat_data_source.dart';
import 'package:wyca/features/chat/data/models/chat_model.dart';
import 'package:wyca/features/chat/domain/entities/chat_params.dart';
import 'package:wyca/features/chat/domain/repositories/i_chat_repository.dart';

class ChatRepository extends IChatRespository {
  ChatRepository(this.chatRemote);
  final IChatRemote chatRemote;

  @override
  @override
  Future<Either<NetworkExceptions, ChatModel>> createChat(
    CreateChatParams params,
  ) =>
      guardFuture<ChatModel>(
        () => chatRemote.createChat(params.toMap()),
      );
}
