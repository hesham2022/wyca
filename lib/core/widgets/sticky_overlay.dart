// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/bootstrap.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  await bootstrap(
    () => const MaterialApp(
      home: MyHomePage(title: 'webjkqwe'),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = ScrollController();
  OverlayEntry? sticky;
  GlobalKey stickyKey = GlobalKey();

  @override
  void initState() {
    if (sticky != null) {
      sticky!.remove();
    }

    sticky = OverlayEntry(
      builder: stickyBuilder,
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(sticky!);
    });

    super.initState();
  }

  @override
  void dispose() {
    sticky!.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 6) {
            return Container(
              key: stickyKey,
              height: 100,
              color: Colors.green,
              child: const Text("I'm fat"),
            );
          }
          return ListTile(
            title: Text(
              'Hello $index',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget stickyBuilder(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final keyContext = stickyKey.currentContext;
        if (keyContext != null) {
          // widget is visible
          final box = keyContext.findRenderObject() as RenderBox;
          final pos = box.localToGlobal(Offset.zero);
          return Positioned(
            top: pos.dy + box.size.height,
            left: 50,
            right: 50,
            height: box.size.height,
            child: Material(
              child: Container(
                alignment: Alignment.center,
                color: Colors.purple,
                child: const Text("^ Nah I think you're okay"),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
