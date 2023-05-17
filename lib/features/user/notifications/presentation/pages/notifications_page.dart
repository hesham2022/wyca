import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/notifications/presentation/pages/notification_info.dart';
import 'package:wyca/l10n/l10n.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    context.read<PNCubit>().getLocalNotifcation();

    super.initState();
  }

  String getMessege(int n, String name, BuildContext context) {
    if (n == 1) {
      return '${context.l10n.requestAcceptedFrom} $name';
    }
    if (n == 2) {
      return '$name ${context.l10n.begunWashing}';
    }
    if (n == 3) {
      return '$name ${context.l10n.hasFinished}';
    }
    if (n == 4) {
      return 'Plaese Try Again';
    }
    return 'notifications';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.notifications)),
      body: Container(
        // color: primaryColor.withOpacity(.07),
        child: BlocBuilder<PackagesCubit, PackagesCubitState>(
          builder: (context, packageState) {
            if (packageState is PackagesCubitStateLoaded) {
              return Center(
                child: BlocBuilder<PNCubit, PNCubitState>(
                  builder: (context, state) {
                    if (state is PNCubitStateLoaded) {
                      Fluttertoast.showToast(
                        msg: state.requests.length.toString(),
                      );

                      final request = state.requests.toList();
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RequestInfoWidget(
                            request: request[index],
                            provider: request[index].providerModel,
                            package: packageState.packages.firstWhere(
                              (element) => request[index].package == element.id,
                            ),
                          );
                        },
                        itemCount: request.length,
                      );
                    }

                    if (state is PNCubitStateLoading) {
                      return const Center(
                        child: Loader(),
                      );
                    }

                    if (state is PNCubitStateError) {
                      return Center(
                        child: Text(state.error.errorMessege),
                      );
                    }
                    return const Center(child: Text('Notifications'));
                  },
                ),
              );
            }
            if (packageState is PackagesCubitStateError) {
              return Center(child: Text(packageState.error.errorMessege));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
