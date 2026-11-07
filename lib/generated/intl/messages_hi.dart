// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi';

  static String m0(count) => "${count} कैलोरी";

  static String m1(dishes, items) => "${dishes} व्यंजन - ${items} आइटम";

  static String m2(name) => "नमस्ते, ${name}!";

  static String m3(price) => "INR ${price}";

  static String m4(id) => "ID : ${id}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
            "क्या आपके पास पहले से एक खाता मौजूद है? "),
        "appName": MessageLookupByLibrary.simpleMessage("निशित टेस्ट"),
        "backToMenu":
            MessageLookupByLibrary.simpleMessage("मेन्यू पर वापस जाएं"),
        "calories": m0,
        "cancel": MessageLookupByLibrary.simpleMessage("रद्द करें"),
        "cart": MessageLookupByLibrary.simpleMessage("कार्ट"),
        "cartIsEmpty":
            MessageLookupByLibrary.simpleMessage("आपका कार्ट खाली है"),
        "checkout": MessageLookupByLibrary.simpleMessage("चेकआउट"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("पासवर्ड की पुष्टि करें"),
        "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "कृपया पासवर्ड की पुष्टि करें"),
        "createAccount": MessageLookupByLibrary.simpleMessage("खाता बनाएं"),
        "customizationsAvailable":
            MessageLookupByLibrary.simpleMessage("अनुकूलन उपलब्ध"),
        "dashboard": MessageLookupByLibrary.simpleMessage("डैशबोर्ड"),
        "defaultRestaurantName":
            MessageLookupByLibrary.simpleMessage("UNI Resto Cafe"),
        "dishesAndItemsCount": m1,
        "done": MessageLookupByLibrary.simpleMessage("पूर्ण"),
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("खाता नहीं है? "),
        "email": MessageLookupByLibrary.simpleMessage("ईमेल"),
        "emailRequired": MessageLookupByLibrary.simpleMessage("ईमेल आवश्यक है"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enterYourEmail":
            MessageLookupByLibrary.simpleMessage("अपना ईमेल दर्ज करें"),
        "enterYourFullName":
            MessageLookupByLibrary.simpleMessage("अपना पूरा नाम दर्ज करें"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("अपना पासवर्ड दर्ज करें"),
        "exit": MessageLookupByLibrary.simpleMessage("बाहर निकलें"),
        "exitAppMessage": MessageLookupByLibrary.simpleMessage(
            "क्या आप ऐप बंद करना चाहते हैं?"),
        "exitAppTitle":
            MessageLookupByLibrary.simpleMessage("ऐप से बाहर निकलें"),
        "fillInYourDetails":
            MessageLookupByLibrary.simpleMessage("अपना विवरण भरें"),
        "fullName": MessageLookupByLibrary.simpleMessage("पूरा नाम"),
        "google": MessageLookupByLibrary.simpleMessage("Google"),
        "helloUser": m2,
        "hindi": MessageLookupByLibrary.simpleMessage("हिन्दी"),
        "inrPrice": m3,
        "loading": MessageLookupByLibrary.simpleMessage("लोड हो रहा है..."),
        "loadingRestaurantMenu":
            MessageLookupByLibrary.simpleMessage("मेन्यू लोड हो रहा है..."),
        "logout": MessageLookupByLibrary.simpleMessage("लॉग आउट"),
        "logoutConfirmMessage": MessageLookupByLibrary.simpleMessage(
            "क्या आप निश्चित रूप से लॉगआउट करना चाहते हैं?"),
        "logoutConfirmTitle": MessageLookupByLibrary.simpleMessage("लॉगआउट"),
        "menu": MessageLookupByLibrary.simpleMessage("मेन्यू"),
        "mobileHint":
            MessageLookupByLibrary.simpleMessage("10 अंकों का मोबाइल नंबर"),
        "mobileNumber": MessageLookupByLibrary.simpleMessage("मोबाइल नंबर"),
        "mobileRequired":
            MessageLookupByLibrary.simpleMessage("मोबाइल नंबर आवश्यक है"),
        "nameRequired": MessageLookupByLibrary.simpleMessage("नाम आवश्यक है"),
        "nameTooShort":
            MessageLookupByLibrary.simpleMessage("नाम बहुत छोटा है"),
        "noInternetMessage": MessageLookupByLibrary.simpleMessage(
            "कृपया अपनी नेटवर्क सेटिंग्स जांचें। नेटवर्क उपलब्ध होने पर पुनः कनेक्ट होगा..."),
        "noInternetTitle":
            MessageLookupByLibrary.simpleMessage("कोई इंटरनेट कनेक्शन नहीं"),
        "noItemsInCart": MessageLookupByLibrary.simpleMessage(
            "आपके कार्ट में कोई आइटम नहीं है"),
        "noMenuCategoriesFound":
            MessageLookupByLibrary.simpleMessage("कोई श्रेणी नहीं मिली"),
        "noRecentActivity": MessageLookupByLibrary.simpleMessage(
            "अभी कोई हाल की गतिविधि नहीं है"),
        "ok": MessageLookupByLibrary.simpleMessage("ठीक है"),
        "or": MessageLookupByLibrary.simpleMessage("या"),
        "orderSuccessful":
            MessageLookupByLibrary.simpleMessage("ऑर्डर सफलतापूर्वक दिया गया"),
        "orderSuccessfullyPlaced":
            MessageLookupByLibrary.simpleMessage("ऑर्डर सफलतापूर्वक दिया गया"),
        "orderSummary": MessageLookupByLibrary.simpleMessage("ऑर्डर सारांश"),
        "password": MessageLookupByLibrary.simpleMessage("पासवर्ड"),
        "passwordMinLength":
            MessageLookupByLibrary.simpleMessage("कम से कम 6 वर्ण होने चाहिए"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("पासवर्ड आवश्यक है"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("पासवर्ड मेल नहीं खाते"),
        "pending": MessageLookupByLibrary.simpleMessage("लंबित"),
        "placeOrder": MessageLookupByLibrary.simpleMessage("ऑर्डर दें"),
        "reEnterPassword":
            MessageLookupByLibrary.simpleMessage("पासवर्ड दोबारा दर्ज करें"),
        "recentActivity":
            MessageLookupByLibrary.simpleMessage("हाल की गतिविधि"),
        "register": MessageLookupByLibrary.simpleMessage("रजिस्टर करें"),
        "retry": MessageLookupByLibrary.simpleMessage("पुनः प्रयास करें"),
        "selectLanguage": MessageLookupByLibrary.simpleMessage("भाषा चुनें"),
        "signIn": MessageLookupByLibrary.simpleMessage("साइन इन करें"),
        "signInToContinue": MessageLookupByLibrary.simpleMessage(
            "जारी रखने के लिए साइन इन करें"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("गूगल से साइन इन करें"),
        "tasks": MessageLookupByLibrary.simpleMessage("कार्य"),
        "totalAmount": MessageLookupByLibrary.simpleMessage("कुल राशि"),
        "userDefault": MessageLookupByLibrary.simpleMessage("User"),
        "userId": m4,
        "validEmail":
            MessageLookupByLibrary.simpleMessage("एक मान्य ईमेल दर्ज करें"),
        "validMobile": MessageLookupByLibrary.simpleMessage(
            "मान्य 10 अंकों का मोबाइल नंबर दर्ज करें"),
        "welcomeBack":
            MessageLookupByLibrary.simpleMessage("वापसी पर स्वागत है")
      };
}
