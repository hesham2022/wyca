import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/domain/params/rate.dart';
import 'package:wyca/features/request/presentation/provider_notification_cubit.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/user/points/presentaion/pages/my_points_screen.dart';
import 'package:wyca/features/user/request_accepted/presentaion/pages/neares_provider_screen.dart';
import 'package:wyca/imports.dart';

class WashingDonePage extends StatefulWidget {
  const WashingDonePage({super.key, required this.request});
  final RequestClass request;

  @override
  State<WashingDonePage> createState() => _WashingDonePageState();
}

class _WashingDonePageState extends State<WashingDonePage> {
  late RequestClass _request;
  @override
  void initState() {
    setState(() {
      _request = widget.request;
    });
    _bloc.getSingelRequest(widget.request.id);
    super.initState();
  }

  final TextEditingController controller = TextEditingController();

  double rate = 0;
  final _bloc = RequestCubit(requestRespository: getIt());
  @override
  Widget build(BuildContext context) {
    return _request.rated
        ? NearesProviderScreen(
            request: _request,
          )
        : BlocProvider.value(
            value: _bloc,
            child: Container(
              child: BlocConsumer<RequestCubit, RequestCubitState>(
                listener: (context, state) {
                  if (state is SingleRequestCubitStateLoaded) {
                    context.read<PNCubit>().updateNotification(
                          state.request.copyWith(
                            providerModel: widget.request.providerModel,
                          ),
                        );

                    setState(() {
                      _request = state.request;
                    });
                  }
                  if (state is RequestCubitStateRated) {
                    context.read<PNCubit>().updateNotification(
                          state.request.copyWith(
                            providerModel: widget.request.providerModel,
                          ),
                        );
                    setState(() {
                      _request = state.request;
                    });
                    Navigator.pop(context);
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyPointsScreen(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Scaffold(
                    appBar: appBar(context, ''),
                    body: Padding(
                      padding: kPadding,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          Lottie.asset(
                            Assets.lottie.animation7,
                            height: 178.h,
                            width: 178.h,
                          ),
                          const SizedBox(width: 0, height: 20),
                          Text(
                            context.l10n.washingCompleteSuccessFully,
                            textAlign: TextAlign.center,
                            style: kHead1Style.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          const SizedBox(width: 0, height: 30),
                          AppButton(
                            h: 36.h,
                            title: context.l10n.addReview,
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: SizedBox(
                                    height: ScreenUtil().setHeight(320),
                                    width: ScreenUtil().setWidth(320),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                context.l10n
                                                    .washingCompleteSuccessFully,
                                                style: kHead1Style.copyWith(
                                                  fontSize: 16.sp,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                                child: RatingBar.builder(
                                                  itemSize: 16,
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  allowHalfRating: true,
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 10,
                                                  ),
                                                  onRatingUpdate: (value) {
                                                    rate = value;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                          TextFormField(
                                            minLines: 4,
                                            controller: controller,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                              hintText: 'Write your review',
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          AppButton(
                                            h: 40.h,
                                            w: 200.w,
                                            title: context.l10n
                                                .washingCompleteSuccessFully,
                                            onPressed: () {
                                              _bloc.rateRequest(
                                                RatingParams(
                                                  provider: _request.provider!,
                                                  rating: rate,
                                                  review: controller.text,
                                                  request: _request.id,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}

Future<void> showRatePopUp(
  BuildContext context, {
  required String id,
  required String provider,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) => RateWidget(
      id: id,
      provider: provider,
    ),
  );
}

class RateWidget extends StatefulWidget {
  const RateWidget({super.key, required this.provider, required this.id});
  final String provider;
  final String id;

  @override
  State<RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  final TextEditingController controller = TextEditingController();

  double rate = 0;
  final _bloc = RequestCubit(requestRespository: getIt());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: ScreenUtil().setHeight(320),
        width: ScreenUtil().setWidth(320),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.washingCompleteSuccessFully,
                    style: kHead1Style.copyWith(
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    height: 10.h,
                    child: RatingBar.builder(
                      itemSize: 16,
                      initialRating: 3,
                      minRating: 1,
                      allowHalfRating: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 10,
                      ),
                      onRatingUpdate: (value) {
                        rate = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              TextFormField(
                minLines: 4,
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your review',
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AppButton(
                h: 40.h,
                w: 200.w,
                title: context.l10n.washingCompleteSuccessFully,
                onPressed: () {
                  _bloc.rateRequest(
                    RatingParams(
                      provider: widget.provider,
                      rating: rate,
                      review: controller.text,
                      request: widget.id,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
