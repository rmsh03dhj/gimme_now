/// This class is used to convert email address depending upon the user's input.
/// If the user input starts with + that means its mobile number. So we update
/// email address.
/// Eg: str = +612341223
/// output will be
/// mobile+612341223@cleared.world

abstract class EmailAddressConverter {
  String updateEmailAddress(String str);
  bool isPhoneNumber(String str);
}

class EmailAddressConverterImpl implements EmailAddressConverter {
  String updateEmailAddress(String str) {
    String updatedEmail = str;
    if (isPhoneNumber(str)) {
      updatedEmail = "mobile" + str + "@cleared.world";
    }
    return updatedEmail;
  }

  bool isPhoneNumber(String str) {
    String numberOnlyRegex = r'^[0-9]*$';
    RegExp regexForNumber = new RegExp(numberOnlyRegex);
    if (str != null && str.length > 1 && regexForNumber.hasMatch(str.substring(1))) {
      return true;
    }
    return false;
  }
}
