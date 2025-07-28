import 'package:flutter/services.dart';

class FormValidation{

  static final FilteringTextInputFormatter allowedIntegers = FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  static final FilteringTextInputFormatter ignoreDots = FilteringTextInputFormatter.deny('.');
  static final FilteringTextInputFormatter ignoreNumber = FilteringTextInputFormatter.deny(RegExp(r'[0-9.]'));

  static bool isEmpty(String text){

    if(text.isEmpty){

      return true;

    }else{

      return false;

    }

  }

  static bool isWeakPassword(String text){

    if(text.length < 6){

      return true;

    }else{

      return false;

    }

  }

  static bool isDuplicate(String text, int minLength){

    if(text.length < minLength){

      return true;

    }else{

      return false;

    }

  }

  static bool isNotEmail(String value) {

    const String pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    final RegExp regex = RegExp(pattern);

    return !regex.hasMatch(value) ? true : false;

  }

}