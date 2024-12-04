import 'dart:developer';

import 'package:flutter/foundation.dart';

// because this function was used a lot of time in this project
// so we set it as a global function
void printOut(String? msg, {String? name, int? colorCode}) async {
  if (msg != null && msg.isNotEmpty && kDebugMode) {
    try {
      if (colorCode != null) {
        final coloredMsg = '\u001b[$colorCode' 'm' '$msg' '\u001b[0m';
        log(coloredMsg, name: name ?? '');
      } else {
        log(msg, name: name ?? '');
      }
    } catch (error) {
      log(msg, name: name ?? '');
    }
  } else {
    log('S.O.S => printing a null value', name: name ?? '');
  }
}


/*
some examples of color code:
30: black
31: red
32: green
33: yellow
34: system blue
35: purple
36: cyan
37: white
38: system yellow


the color of js console is defined here:
https://github.com/mochajs/mocha/blob/9e95d36e4b715380cef573014dec852bded3f8e1/lib/reporters/base.js#L48
*/