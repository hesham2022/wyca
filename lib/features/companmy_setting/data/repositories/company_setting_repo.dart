import 'package:dartz/dartz.dart';
import 'package:wyca/core/api_errors/network_exceptions.dart';
import 'package:wyca/core/utils/catch_async.dart';
import 'package:wyca/features/companmy_setting/data/datasources/companu_setting_remote.dart';
import 'package:wyca/features/companmy_setting/data/models/company_seting_model.dart';
import 'package:wyca/features/companmy_setting/data/models/complaint_model.dart';
import 'package:wyca/features/companmy_setting/domain/repositories/i_company_setting_repo.dart';

class ComapnySettingsRepository extends IComapnySettingsRepository {
  ComapnySettingsRepository(this.userRemote);
  final IComapnySettingsRemote userRemote;

  @override
  Future<Either<NetworkExceptions, ComapnySettingsModel>>
      getCompanySettings() =>
          guardFuture<ComapnySettingsModel>(userRemote.getComapnySettings);
  @override
  Future<Either<NetworkExceptions, ComplaintModel>> addCompliantment(
    ComplaintModel model,
  ) =>
      guardFuture<ComplaintModel>(() => userRemote.addCompliantment(model));
}
