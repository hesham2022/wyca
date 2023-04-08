import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/features/companmy_setting/data/models/company_seting_model.dart';
import 'package:wyca/features/companmy_setting/data/models/complaint_model.dart';

abstract class IComapnySettingsRepository {
  Future<Either<NetworkExceptions, ComapnySettingsModel>> getCompanySettings();
  Future<Either<NetworkExceptions, ComplaintModel>> addCompliantment(
    ComplaintModel model,
  );
}
