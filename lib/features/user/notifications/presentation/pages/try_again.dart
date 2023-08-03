import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/features/request/data/models/request_model.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/imports.dart';

class TryAgain extends StatefulWidget {
  const TryAgain({super.key, required this.requestClass});
  final RequestClass requestClass;
  @override
  _TryAgainState createState() => _TryAgainState();
}

class _TryAgainState extends State<TryAgain> {
  late RequestClass _req;
  @override
  void initState() {
    setState(() {
      _req = widget.requestClass;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestCubitState>(
      listener: (context, state) {
        // showDialog<void>(
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     content: Text(state.toString()),
        //   ),
        // );
        if (state is RequestCubitStateTried) {
          // Fluttertoast.showToast(
          //   msg: 'Your Request is Already under Processing',
          // );
          setState(() {
            _req = state.request;
          });
          // Fluttertoast.showToast(
          //   msg: _req.tryOpened.toString(),
          // );
        }
        if (state is RequestCubitStateError) {
          Fluttertoast.showToast(
            msg: state.error.errorMessege,
          );
        }
      },
      builder: (context, state) {
        if (state is RequestCubitStateLoading) {
          return const Scaffold(
            body: Center(
              child: Loader(),
            ),
          );
        }
        // 01021539249
        return _req.status < 4
            ? Text(_req.status.toString())
            // NearesProviderScreen(
            //     request: _req,
            //   )
            : Scaffold(
                appBar: appBar(context, 'Keep Trying'),
                body: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.loop_outlined,
                                size: 100,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<RequestCubit>()
                                      .tryAgainRequest(_req.id);
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kPrimaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Try Now',
                                        style: kHead1Style.copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No workers found now, keep trying again until your request is successfully executed',
                                style: kHead1Style,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
