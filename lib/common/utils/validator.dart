mixin Validator {
  String? validateEmail(String? email) {
    if (email!.isNotEmpty) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        return "Invalid Email Address";
      }
    } else {
      return "Email cannot be empty";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password!.isNotEmpty) {
      if (password.length < 7) {
        return 'password should be more than 6 characters';
      }
    } else {
      return 'password cannot be empty';
    }
    return null;
  }
}
