import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/features/auth/data/models/provider_registeration_response.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/features/user/notifications/presentation/pages/try_again.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/neares_provider_screen.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/washing_done_page.dart';
import 'package:wyca/l10n/l10n.dart';

// class RequestsStatus  {
//  static const  opened= 'opened';
//   WAITING: 'waiting',
//   ONPROCESSING: 'onprocessing',
//   DONE: 'done',
// };
class RequestInfoWidget extends StatefulWidget {
  const RequestInfoWidget({
    super.key,
    required this.request,
    required this.provider,
    this.package,
  });
  final RequestClass request;
  final ProviderModel? provider;

  final Package? package;

  @override
  State<RequestInfoWidget> createState() => _RequestInfoWidgetState();
}

class _RequestInfoWidgetState extends State<RequestInfoWidget> {
  String getStatus(BuildContext context) {
    if (widget.request.isOpened) {
      return 'Opened';
    }
    if (widget.request.isAccepetd) {
      return 'Accepted';
    }
    if (widget.request.isDone) {
      return 'Done';
    }
    if (widget.request.isStarted) {
      return 'Started';
    }
    if (widget.request.canceled) {
      return 'Canceled';
    }
    return 'Missed';
  }

  String? local;
  String getAgo(DateTime date) {
    final duration = DateTime.now().difference(date);
    if (duration.inDays > 0) {
      return '${duration.inDays} Dayes';
    }
    if (duration.inHours > 0) {
      return '${duration.inHours} Hours';
    }
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes} Minutes';
    }
    return '0 Minutes';
  }

  Color getColor() {
    if (widget.request.isOpened) return primaryColor;
    if (widget.request.isStarted) return primaryColor;
    if (widget.request.isMissed) return primaryColor;

    return primaryColor;
  }

  double iconSize = 40;
  Widget getIcon() {
    if (widget.request.isMissed) {
      return Icon(
        Icons.loop_outlined,
        size: 30,
        color: getColor(),
      );
    }
    if (widget.request.isAccepetd) {
      return Icon(
        Icons.check_circle,
        size: 40,
        color: getColor(),
      );
    }
    if (widget.request.isStarted) {
      return Icon(
        FontAwesomeIcons.gears,
        size: 40,
        color: getColor(),
      );
    }
    if (widget.request.isDone) {
      return Icon(
        FontAwesomeIcons.thumbsUp,
        size: 40,
        color: getColor(),
      );
    }
    return Icon(
      Icons.location_pin,
      size: 40,
      color: getColor(),
    );
  }

  String getTitleString(BuildContext context) {
    if (widget.request.status == 1) {
      return '${context.l10n.requestAcceptedFrom} ${widget.provider!.name}';
    }
    if (widget.request.status == 2) {
      return '${widget.provider!.name} ${context.l10n.begunWashing}';
    }
    if (widget.request.status == 3) {
      return '${widget.provider!.name} ${context.l10n.hasFinished}';
    }
    if (widget.request.status == 4) {
      return 'Plaese Try Again';
    }
    return 'notifications';
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        local = context.l10n.localeName;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.request.status == 4) {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => TryAgain(
                requestClass: widget.request,
              ),
            ),
          );
          return;
        }
        if (widget.request.status == 3 && widget.request.isConfired) {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => WashingDonePage(
                request: widget.request,
              ),
            ),
          );
        } else {
          Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => NearesProviderScreen(
                request: widget.request,
              ),
            ),
          );
        }
      },
      child: LayoutBuilder(
        builder: (c, s) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(child: getIcon()),
                Expanded(
                  flex: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    title: Text(
                      getTitleString(context), //  'Call Request',
                      style: textStyleWithPrimarySemiBold.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        color: kPrimaryColor,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        if (widget.request.washNumber != null)
                          Text(
                            'The ${widget.request.washNumber! + 1}th wash of package ${widget.package!.name}', //   ' ',
                            style: textStyleWithPrimarySemiBold.copyWith(
                              fontSize: 14.sp,
                            ),
                          )
                        else
                          Text(
                            'Reuest from package ${widget.package!.name}', //   'Friday',
                            style: textStyleWithPrimarySemiBold.copyWith(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        if (widget.request.notificationDate != null)
                          Wrap(
                            children: [
                              Text(
                                DateFormat(
                                  'EEEE, d MMM, yyyy',
                                  (context.l10n.localeName == 'ar')
                                      ? 'ar'
                                      : 'en',
                                ).format(
                                  widget.request.notificationDate!,
                                ),
                                style: textStyleWithPrimarySemiBold.copyWith(
                                  fontSize: 14.sp,
                                  color: const Color(0xff5D6C7A),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                context.l10n.localeName == 'ar'
                                    ? '${context.l10n.ago} ${getAgo(
                                        widget.request.notificationDate!,
                                      )}'
                                    : '${getAgo(
                                        widget.request.notificationDate!,
                                      )} ${context.l10n.ago}', //  'Call Request',
                                style: textStyleWithPrimarySemiBold.copyWith(
                                  fontSize: 14.sp,
                                  color: const Color(0xff5D6C7A),
                                ),
                              ),
                            ],
                          ),

                        // Text(
                        //   '05:52 PM',
                        //   style: textStyleWithPrimarySemiBold.copyWith(
                        //     fontSize: 12.sp,
                        //     color: const Color(0xff5D6C7A),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Row(
          //     children: [
          //       getIcon(),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Text(
          //               getTitleString(context), //  'Call Request',
          //               style: textStyleWithPrimarySemiBold.copyWith(
          //                 fontSize: 16.sp,
          //                 height: 1,
          //                 color: kPrimaryColor,
          //               ),
          //             ),
          //             if (widget.request.notificationDate != null)
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     context.l10n.localeName == 'ar'
          //                         ? '${context.l10n.ago} ${getAgo(
          //                             widget.request.notificationDate!,
          //                           )}'
          //                         : '${getAgo(
          //                             widget.request.notificationDate!,
          //                           )} ${context.l10n.ago}', //  'Call Request',
          //                     style: textStyleWithPrimarySemiBold.copyWith(
          //                       fontSize: 14.sp,
          //                       color: const Color(0xff5D6C7A),
          //                     ),
          //                   ),
          //                   const SizedBox(
          //                     width: 20,
          //                   ),
          //                   Text(
          //                     DateFormat(
          //                       'EEEE, d MMM, yyyy',
          //                       (context.l10n.localeName == 'ar') ? 'ar' : 'en',
          //                     ).format(
          //                       widget.request.notificationDate!,
          //                     ),
          //                     style: textStyleWithPrimarySemiBold.copyWith(
          //                       fontSize: 14.sp,
          //                       color: const Color(0xff5D6C7A),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             if (widget.request.washNumber != null)
          //               Text(
          //                 'The ${widget.request.washNumber! + 1}th wash of package ${widget.package!.name}', //   'Friday',
          //                 style: textStyleWithPrimarySemiBold.copyWith(
          //                   fontSize: 14.sp,
          //                 ),
          //               )
          //             else
          //               Text(
          //                 'Reuest from package ${widget.package!.name}', //   'Friday',
          //                 style: textStyleWithPrimarySemiBold.copyWith(
          //                   fontSize: 14.sp,
          //                 ),
          //               ),

          //             // Text(
          //             //   '05:52 PM',
          //             //   style: textStyleWithPrimarySemiBold.copyWith(
          //             //     fontSize: 12.sp,
          //             //     color: const Color(0xff5D6C7A),
          //             //   ),
          //             // ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
