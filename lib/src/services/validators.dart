class Validators {
  static String required(String value) {
    if (value == null || value == '') {
      return 'This is a required field';
    }
    return null;
  }
}