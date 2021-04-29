import 'dart:async';

import 'package:get/get.dart';

class Request extends GetConnect {
  Future<Response> getDick() => get(
      "https://raw.githubusercontent.com/matthewreagan/WebstersEnglishDictionary/master/dictionary.json");
}
