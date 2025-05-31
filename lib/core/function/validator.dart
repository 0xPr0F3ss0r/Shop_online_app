import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

bool isValidLocation(String location) {
  // هنا يمكنك إضافة قواعد التحقق الخاصة بك
  // على سبيل المثال، التحقق من أن الموقع يحتوي على حروف وأرقام
  if (location.length < 5) {
    return false;
  }
  return true;
}

validate(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "Can't be empty";
  }
  if (val.length < min) {
    return 'Too short, should be at least $min characters';
  }
  if (val.length > max) {
    return 'Too long, should be less than $max characters';
  }
  // Specific type validations
  if (type == "email" && !GetUtils.isEmail(val)) {
    return "Not a valid email";
  }
  if (type == "website" && !GetUtils.isURL(val)) {
    return "Not a valid email";
  }
  if (type == "username" && !GetUtils.isUsername(val)) {
    return "Not a valid username";
  }
  if (type == "location" && val.isEmpty) {
    return "Location cannot be empty";
  } else if (type == "location" && !isValidLocation(val)) {
    return "Not a valid location";
  }
  if (type == "productName" && GetUtils.isNumericOnly(val)) {
    return "Not a valid product";
  }

  if (type == "password") {
    final passwordRegExp =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegExp.hasMatch(val)) {
      return "Password must include uppercase, lowercase, and number";
    }
  }
  if (type == "cvv") {
    if (val.length != 3 && !val.isNumericOnly) {
      return "write your cvv";
    }
  }
  // Add phone or other validations as needed
  return null; // Validation passed
}
