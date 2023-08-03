import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:wyca/app/view/chat_data.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/chat/data/models/chat_model.dart';
import 'package:wyca/features/chat/domain/entities/chat_params.dart';
import 'package:wyca/imports.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.recieverId,
    required this.recieverImage,
    required this.senderId,
    required this.name,
    required this.recieverType,
  });
  final String recieverId;
  final String recieverImage;
  final String senderId;
  final String recieverType;
  final String name;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  @override
  void initState() {
    final user =
        widget.recieverType == 'user' ? widget.recieverId : widget.senderId;
    final provider =
        widget.recieverType == 'provider' ? widget.recieverId : widget.senderId;
    context.read<ChatCubit>().createChat(
          CreateChatParams(
            user: user,
            provider: provider,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final myType = state.userType;
        bool isMe(String senderType) =>
            senderType == (myType == UserType.user ? 'user' : 'provider');
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            leadingWidth: 70.sp,
            leading: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                final currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                Navigator.pop(context);

                // Focus.of(context).requestFocus(FocusNode());
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.recieverImage.isNotEmpty
                        ? widget.recieverImage
                        : 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
                    //  Assets.images.pexelsKindelMedia84869073x.path,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: kHead1Style.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'online',
                      style: kBody1Style.copyWith(
                        fontSize: 14,
                        color: const Color(0xff8F8F8F),
                      ),
                    )
                  ],
                ),
              ],
            ),
            titleSpacing: 0,
            actions: [
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                  color: ColorName.primaryColor,
                ),
              )
            ],
          ),
          body: Padding(
            padding: kPadding.copyWith(bottom: 30.sp),
            child: BlocBuilder<ChatCubit, ChatStat>(
              builder: (context, state) {
                if (state is ChatStatLoaded) {
                  final chatModel =
                      context.read<ChatCubit>().chatModels.firstWhere(
                            (element) =>
                                element.user ==
                                (widget.recieverType == 'user'
                                    ? widget.recieverId
                                    : widget.senderId),
                          );
                  final chat = state.chats.firstWhere(
                    (element) => element.id == chatModel.id,
                  );

                  Future.delayed(Duration.zero, () {
                    scrollController.animateTo(
                      scrollController.position.minScrollExtent - 100,
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeOut,
                    );
                  });

                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(
                      parent: NeverScrollableScrollPhysics(),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height -
                          (36.h + kToolbarHeight + 60.h),
                      child: Column(
                        children: [
                          // chat ui
                          Expanded(
                            child: GroupedListView<Messages, DateTime>(
                              controller: scrollController,
                              elements: chatModel.messages!.toList(),
                              // reverse: true,
                              groupBy: (element) {
                                return DateTime(
                                  element.time.year,
                                  element.time.month,
                                  element.time.day,
                                  element.time.hour,
                                  element.time.minute,
                                  element.time.second,
                                  element.time.millisecond,
                                  element.time.microsecond,
                                );
                              },
                              groupSeparatorBuilder: (date) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                              groupHeaderBuilder: (message) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff8F8F8F),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: Text(
                                        DateFormat('dd MMMM')
                                            .format(message.time),
                                        style: kBody1Style.copyWith(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemBuilder: (context, message) => Align(
                                alignment: isMe(message.senderType!)
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isMe(message.senderType!)
                                        ? ColorName.primaryColor
                                        : ColorName.textColor2,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                        isMe(message.senderType!) ? 0 : 15,
                                      ),
                                      bottomLeft: Radius.circular(
                                        !isMe(message.senderType!) ? 0 : 15,
                                      ),
                                      topLeft: const Radius.circular(
                                        15,
                                      ),
                                      topRight: const Radius.circular(
                                        15,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    message.text!,
                                    style: kBody1Style.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          MessegeField(
                            controller: controller,
                            onSubmit: () {
                              final authBloc =
                                  context.read<AuthenticationBloc>();
                              context.read<ChatCubit>().addNewMessageFromMe(
                                    widget.senderId,
                                    widget.recieverId,
                                    controller.text,
                                    context.read<Socket>(),
                                    authBloc.state.userType == UserType.user
                                        ? 'user'
                                        : 'provider',
                                    context
                                        .read<ChatCubit>()
                                        .chatModels
                                        .firstWhere(
                                          (element) =>
                                              element.user ==
                                              (widget.recieverType == 'user'
                                                  ? widget.recieverId
                                                  : widget.senderId),
                                        )
                                        .id!,
                                  );

                              setState(() {
                                messages.add(
                                  Message(
                                    text: controller.text,
                                    isMe: true,
                                    time: DateTime.now(),
                                  ),
                                );
                                controller.clear();
                                scrollController.animateTo(
                                  scrollController.position.minScrollExtent -
                                      200,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Loader(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class MessegeField extends StatefulWidget {
  const MessegeField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });
  final TextEditingController controller;
  final VoidCallback onSubmit;
  @override
  State<MessegeField> createState() => _MessegeFieldState();
}

class _MessegeFieldState extends State<MessegeField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: const Color(0xffF0F6FF),
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(20),
          child: Assets.svg.smileFaceSvgrepoCom.svg(
            color: ColorName.primaryColor,
            height: 20.h,
            width: 20.w,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            widget.onSubmit();
          },
          icon: const Icon(Icons.send_outlined),
        ),
        hintText: 'Type a message',
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.primaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.primaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.primaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.primaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorName.primaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

final messages = [
  Message(
    text: 'Hello',
    isMe: false,
    time: DateTime.now().subtract(const Duration(seconds: 4)),
  ),
  Message(
    text: 'Hi',
    isMe: true,
    time: DateTime.now().subtract(const Duration(seconds: 3)),
  ),
  Message(
    text: 'How are you?',
    isMe: false,
    time: DateTime.now().subtract(const Duration(seconds: 2)),
  ),
  Message(
    text: 'I am fine',
    isMe: true,
    time: DateTime.now().subtract(const Duration(seconds: 1)),
  ),
  Message(
    text: 'What about you?',
    isMe: false,
    time: DateTime.now(),
  ),
];

class Message {
  Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
  final String text;
  final bool isMe;
  final DateTime time;
}
