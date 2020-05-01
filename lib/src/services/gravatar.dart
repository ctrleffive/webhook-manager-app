import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:webhook_manager/src/constants/keys.dart';

class GravatarService {
  static String getImageUrl(String email) {
    if (email == null) return null;
  
    final String hash = md5.convert(utf8.encode(email.toLowerCase())).toString();
    return '${KeysConstant.gravatarApi}/$hash?s=200&d=mp';
  }
}