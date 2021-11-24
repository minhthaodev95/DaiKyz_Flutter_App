/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-19 12:18:19
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:26:44
 ///  Description:
 */

class Validator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
