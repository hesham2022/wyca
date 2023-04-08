import 'package:wyca/features/auth/data/models/register_response.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';

class RegisterUserResponse {
  RegisterUserResponse({
    required this.user,
    required this.tokens,
  });

  UserModel user;
  Tokens tokens;
}
