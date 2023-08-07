// vps ip

import 'package:wyca/features/auth/data/models/provider_registeration_response.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/domain/entities/provider_entity.dart';
import 'package:wyca/features/auth/domain/entities/user.dart';

// const domain = 'http://192.168.2.173:3000';
// emulator localhost
// const domain = 'http://10.0.2.2:3000';
const domain = 'http://68.183.214.135:3000';

// const domain = 'https://wyca.herokuapp.com';
// const kBaseUrl = 'https://wyca.herokuapp.com/v1';
const kBaseUrl = '$domain/v1';
const kSetting = '$kBaseUrl/setting';
const kComplainment = '$kBaseUrl/compainments';

const kImagePackage = '$domain/img/packages/';
const kRegister = '$kBaseUrl/auth/register';
const kRegisterProvider = '$kBaseUrl/auth/provider/register';
const kForgotPassword = '$kBaseUrl/auth/forgot-password';
const kverifyForgotPassword = '$kBaseUrl/auth/verify-forget-password-otp';
const kResetPassword = '$kBaseUrl/auth/reset-password';

const kLogin = '$kBaseUrl/auth/login';
const kLoginProvider = '$kBaseUrl/auth/provider/login';

const kGetMe = '$kBaseUrl/auth/get-me';
const kGetMeProvider = '$kBaseUrl/auth/provider/get-me';

const kUpdateMe = '$kBaseUrl/auth/update-me';
const kUpdateMeProvider = '$kBaseUrl/auth/provider/update-me';

const kUpdateCars = '$kBaseUrl/auth/update-me/cars';
const kUpdateAddresses = '$kBaseUrl/auth/update-me/addresses';
const kDeleteAddresses = '$kBaseUrl/users/address/deleteAddress/';

const kPackage = '$kBaseUrl/packages';

const kOrder = '$kBaseUrl/orders?byUser=true';
const kChat = '$kBaseUrl/chat';

const kRequest = '$kBaseUrl/request';
const kRate = '$kBaseUrl/review';

const kNear = '$kBaseUrl/providers/near';
String launcTrackingLink(
  double originLat,
  double originLon,
  double targetLat,
  double targetLon,
) =>
    'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLon&destination=$targetLat,$targetLon&travelmode=driving&dir_action=navigate';
//  show notification screen on notification

class DebugConstants {
  static bool showDebugInfo = true;
  static UserModel? currentUser;

  static String get debugInfo {
    return 'Debug Info: \n'
        'Current User: ${currentUser?.toJson()}\n';
  }

  static ProviderModel? currentProvider;

  static String get debugInfoProvider {
    return 'Debug Info: \n'
        'Current Provider: ${currentProvider?.toJson()}\n';
  }

  static void setUser(dynamic data) {
    if (data is UserModel) {
      currentUser = data;
    }
    if (data is ProviderModel) {
      currentProvider = data;
    }
    if (data is User) {
      currentUser = UserModel.fromEntity(data);
    }
    if (data is Provider) {
      currentProvider = ProviderModel.fromEntity(data);
    }
  }

  static bool isTheSameUser(String id) {
    if (currentUser != null) {
      if (currentUser!.id == id) {
        return true;
      }
    }
    return false;
  }

  static bool isTheSameProvider(String id) {
    if (currentProvider != null) {
      if (currentProvider!.id == id) {
        return true;
      }
    }
    return false;
  }
}
