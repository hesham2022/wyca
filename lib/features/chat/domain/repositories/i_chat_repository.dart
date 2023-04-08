// ignore: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/chat/data/models/chat_model.dart';
import 'package:wyca/features/chat/domain/entities/chat_params.dart';

// ignore: one_member_abstracts
abstract class IChatRespository {
  Future<Either<NetworkExceptions, ChatModel>> createChat(
    CreateChatParams params,
  );
}
