extension StringValidation on String {
  bool get isValidPassword {
    final passwordRegExp = RegExp(r'^[a-zA-Z0-9]+$');
    return passwordRegExp.hasMatch(this);
  }

  String get removeWhiteSpaceFromEnd {
    if (this[length - 1] == " ") return substring(0, length - 1);
    return this;
  }
}

class StringValidator {
  static bool numberOfCharacters(String text, int? min, int? max) {
    if (min != null && text.length < min) return false;
    if (max != null && text.length > max) return false;
    return true;
  }
}
