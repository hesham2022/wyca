import 'package:wyca/core/api_config/api_client.dart';
import 'package:wyca/core/api_config/api_constants.dart';
import 'package:wyca/features/companmy_setting/data/models/company_seting_model.dart';
import 'package:wyca/features/companmy_setting/data/models/complaint_model.dart';

abstract class IComapnySettingsRemote {
  IComapnySettingsRemote(this.apiConfig);
  final ApiClient apiConfig;

  Future<ComapnySettingsModel> getComapnySettings();
  Future<ComplaintModel> addCompliantment(ComplaintModel complaintModel);
}

class ComapnySettingsRemote extends IComapnySettingsRemote {
  ComapnySettingsRemote(super.apiConfig);

  @override
  Future<ComapnySettingsModel> getComapnySettings() async {
    final response = await apiConfig.get(kSetting);
    final data = response.data as Map<String, dynamic>;

    final comapnySettingsResult = ComapnySettingsModel.fromMap(data);
    return comapnySettingsResult;
  }

  @override
  Future<ComplaintModel> addCompliantment(ComplaintModel complaintModel) async {
    final response =
        await apiConfig.post(kComplainment, body: complaintModel.toMap());
    return ComplaintModel.fromMap(response.data as Map<String, dynamic>);
    // response.data as Map<String, dynamic>;
  }
}
