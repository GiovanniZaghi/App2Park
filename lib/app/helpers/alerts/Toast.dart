import 'package:toast/toast.dart';
import 'package:flutter/material.dart';

toast(BuildContext context, String msg) {
  Toast.show(msg, context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

}
