String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Please enter an email address.';
  }
  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!emailRegex.hasMatch(email)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

// password validator
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Please enter a password.';
  }
  if (password.length < 8) {
    return 'Password must be at least 8 characters long.';
  }
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return 'Password must contain at least one uppercase letter.';
  }
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return 'Password must contain at least one lowercase letter.';
  }
  if (!RegExp(r'\d').hasMatch(password)) {
    return 'Password must contain at least one number.';
  }
  if (!RegExp(r'[@$!%#?&]').hasMatch(password)) {
    return 'At least one special character (@, \$, !, %, #, ?, &).';
  }
  return null;
}

//name validator

String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return 'Please enter a name.';
  }
  return null;
}
