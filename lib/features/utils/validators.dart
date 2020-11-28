import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator required({String errorText = "Required."}) {
    return (value) {
      if (value == null ||
          ((value is Iterable || value is String || value is Map) && value.length == 0)) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator confirmPasswordMatchWithPassword(String matchWith) {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value != matchWith) return "errorMessageConfirmPasswordNotMatched";
      }
      return null;
    };
  }

  static FormFieldValidator number() {
    return (value) {
      String numberOnlyRegex = r'^[0-9]*$';

      RegExp regexForNumber = new RegExp(numberOnlyRegex);

      if (value != null && value.isNotEmpty) {
        if (!regexForNumber.hasMatch(value)) return "errorMessageInvalidPhoneNumber";
      }
      return null;
    };
  }

  static FormFieldValidator length() {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value.length < 6) return "errorMessageLengthLessThanSix";
      }
      return null;
    };
  }

  static FormFieldValidator emailOrPhoneNumberValidator() {
    return (value) {
      String numberOnlyRegex = r'^[0-9]*$';
      String emailRegex =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regexForNumber = new RegExp(numberOnlyRegex);

      if (value != null && value.isNotEmpty) {
        ///indicates phone number is used
        if (value.substring(0, 1) == "+") {
          if (!regexForNumber.hasMatch(value.substring(1))) return "errorMessageInvalidPhoneNumber";
        } else if (regexForNumber.hasMatch(value)) {
          return "errorMessageCountryCodeRequired";
        }

        ///indicates email is used
        else {
          RegExp regExp = new RegExp(emailRegex);
          if (!regExp.hasMatch(value)) return "errorMessageInvalidEmailAddress";
        }
      }
      return null;
    };
  }

  static FormFieldValidator emailOrPhoneNumberValidatorUpdated() {
    return (value) {
      String numberOnlyRegex = r'^[0-9]*$';
      String emailRegex =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regexForNumber = new RegExp(numberOnlyRegex);

      if (value != null && value.isNotEmpty) {
        ///indicates phone number is used
        if (value.substring(0, 1) == "+") {
          if (!regexForNumber.hasMatch(value.substring(1))) {
            return "errorMessageInvalidPhoneNumber";
          } else {
            if (!isValidPhoneNumber(value)) {
              return "errorMessageInvalidPhoneNumber";
            }
          }
        } else if (regexForNumber.hasMatch(value)) {
          return "errorMessageCountryCodeRequired";
        }

        ///indicates email is used
        else {
          RegExp regExp = new RegExp(emailRegex);
          if (!regExp.hasMatch(value)) return "errorMessageInvalidEmailAddress";
        }
      }
      return null;
    };
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    /// Within Australia, mobile phone numbers begin with 04 or 05 – the Australian National
    /// "Trunk Access Code" 0, plus the Mobile indicator 4 or 5 – followed by eight digits.
    /// This is generally written as 04aa bbb ccc or 04aa bb cc dd within Australia,
    /// or as +61 4aa bbb ccc for an international audience.
    ///
    /// South Africa switched to a closed numbering system effective 16 January 2007. At that time,
    /// it became mandatory to dial the full
    /// 10-digit telephone number, including the zero in the three-digit area code,
    /// for local calls (e.g., 011 must be dialed from within Johannesburg).
    /// Area codes within the system are generally organized geographically.
    /// All telephone numbers are 9 digits long (but always prefixed by 0 for calls within South Africa),
    /// except for certain Telkom special services. When dialed from another country,
    /// the '0' is omitted and replaced with the appropriate international access code and the country code 27.
    ///
    ///validating for only +61 and +27.
    ///+610406126135 is not valid
    ///+61406126135  is valid
    ///+270604680094 is not valid
    ///+27604680094  is valid
    List<String> countryCode = ["+61", "+27"];
    if (phoneNumber.length > 3) {
      if (phoneNumber.length > 3 && countryCode.contains(phoneNumber.substring(0, 3))) {
        if (phoneNumber.substring(3, 4) == "0") {
          return false;
        } else if (phoneNumber.substring(3).length != 9) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
