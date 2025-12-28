import 'package:flutter/material.dart';

Future kAppShowModalBottomSheet(
    BuildContext context,
    Widget content, {
      EdgeInsets? padding,
      bool isDismissible = true,
      VoidCallback? whenComplete,
    }) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    ),
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: true,
    barrierColor: Color(0XFF0F131C).withOpacity(0.1),
    backgroundColor:  Color(0XFF0F131C).withOpacity(0.1),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: content,
      );
    },
  ).whenComplete(() => whenComplete?.call());
}