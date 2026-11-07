// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) => "${count} calories";

  static String m1(dishes, items) => "${dishes} Dishes - ${items} Items";

  static String m2(name) => "Hello, ${name}!";

  static String m3(price) => "INR ${price}";

  static String m4(id) => "ID : ${id}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account? "),
        "appName": MessageLookupByLibrary.simpleMessage("Nishit Test"),
        "backToMenu": MessageLookupByLibrary.simpleMessage("Back to Menu"),
        "calories": m0,
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cart": MessageLookupByLibrary.simpleMessage("Cart"),
        "cartIsEmpty":
            MessageLookupByLibrary.simpleMessage("Your cart is empty"),
        "checkout": MessageLookupByLibrary.simpleMessage("Checkout"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordRequired":
            MessageLookupByLibrary.simpleMessage("Please confirm password"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "customizationsAvailable":
            MessageLookupByLibrary.simpleMessage("Customizations available"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "defaultRestaurantName":
            MessageLookupByLibrary.simpleMessage("UNI Resto Cafe"),
        "dishesAndItemsCount": m1,
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account? "),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enterYourEmail":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "enterYourFullName":
            MessageLookupByLibrary.simpleMessage("Enter your full name"),
        "enterYourPassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "exit": MessageLookupByLibrary.simpleMessage("Exit"),
        "exitAppMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to close the app?"),
        "exitAppTitle": MessageLookupByLibrary.simpleMessage("Exit App"),
        "fillInYourDetails":
            MessageLookupByLibrary.simpleMessage("Fill in your details"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "google": MessageLookupByLibrary.simpleMessage("Google"),
        "helloUser": m2,
        "hindi": MessageLookupByLibrary.simpleMessage("Hindi"),
        "inrPrice": m3,
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "loadingRestaurantMenu":
            MessageLookupByLibrary.simpleMessage("Loading restaurant menu..."),
        "logout": MessageLookupByLibrary.simpleMessage("Log out"),
        "logoutConfirmMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to logout?"),
        "logoutConfirmTitle": MessageLookupByLibrary.simpleMessage("Logout"),
        "menu": MessageLookupByLibrary.simpleMessage("Menu"),
        "mobileHint":
            MessageLookupByLibrary.simpleMessage("10-digit mobile number"),
        "mobileNumber": MessageLookupByLibrary.simpleMessage("Mobile Number"),
        "mobileRequired":
            MessageLookupByLibrary.simpleMessage("Mobile is required"),
        "nameRequired":
            MessageLookupByLibrary.simpleMessage("Name is required"),
        "nameTooShort": MessageLookupByLibrary.simpleMessage("Name too short"),
        "noInternetMessage": MessageLookupByLibrary.simpleMessage(
            "Please check your network settings. Reconnecting automatically when available..."),
        "noInternetTitle":
            MessageLookupByLibrary.simpleMessage("No Internet Connection"),
        "noItemsInCart":
            MessageLookupByLibrary.simpleMessage("No items in your cart"),
        "noMenuCategoriesFound":
            MessageLookupByLibrary.simpleMessage("No menu categories found"),
        "noRecentActivity":
            MessageLookupByLibrary.simpleMessage("No recent activity yet"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "or": MessageLookupByLibrary.simpleMessage("OR"),
        "orderSuccessful":
            MessageLookupByLibrary.simpleMessage("Order Placed Successfully"),
        "orderSuccessfullyPlaced":
            MessageLookupByLibrary.simpleMessage("Order successfully placed"),
        "orderSummary": MessageLookupByLibrary.simpleMessage("Order Summary"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMinLength":
            MessageLookupByLibrary.simpleMessage("At least 6 characters"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Password is required"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "pending": MessageLookupByLibrary.simpleMessage("Pending"),
        "placeOrder": MessageLookupByLibrary.simpleMessage("Place Order"),
        "reEnterPassword":
            MessageLookupByLibrary.simpleMessage("Re-enter password"),
        "recentActivity":
            MessageLookupByLibrary.simpleMessage("Recent Activity"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "selectLanguage":
            MessageLookupByLibrary.simpleMessage("Select Language"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signInToContinue":
            MessageLookupByLibrary.simpleMessage("Sign in to continue"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("Sign In with Google"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "totalAmount": MessageLookupByLibrary.simpleMessage("Total Amount"),
        "userDefault": MessageLookupByLibrary.simpleMessage("User"),
        "userId": m4,
        "validEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email"),
        "validMobile": MessageLookupByLibrary.simpleMessage(
            "Enter a valid 10-digit mobile number"),
        "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back")
      };
}
