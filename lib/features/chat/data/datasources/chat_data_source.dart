import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/chat/data/models/chat_model.dart';

abstract class IChatRemote {
  IChatRemote(this.apiConfig);
  final ApiClient apiConfig;

  // Future<ChatResponse> getChats();
  Future<ChatModel> createChat(Map<String, dynamic> body);
}

class ChatRemote extends IChatRemote {
  ChatRemote(super.apiConfig);

  // @override
  // Future<ChatResponse> getChats() async {
  //   final response = await apiConfig.get(kChat);
  //   final data = response.data as Map<String, dynamic>;
  //   final packageResult = ChatResponse.fromJson(data);
  //   return packageResult;
  // }

  @override
  Future<ChatModel> createChat(Map<String, dynamic> body) async {
    final response = await apiConfig.post(kChat, body: body);
    final data = response.data as Map<String, dynamic>;
    final packageResult = ChatModel.fromJson(data);
    return packageResult;
  }
}
