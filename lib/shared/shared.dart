import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double mediaQueryHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double mediaQueryWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Color backgroundColour = const Color(0xFFFFFFFF);
Color primaryColour = const Color(0xFF5038BC);
Color ghostColour = const Color(0xFF5038BC).withOpacity(0.16);
Color blackColour = const Color(0xFF000000);

Gradient gradient = const LinearGradient(
  colors: [
    Color(0xffe9cf25),
    Color(0xffdda90e),
    Color(0xffbe7521),
    Color(0xff995507)
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

TextStyle defaultText = GoogleFonts.poppins(
    fontSize: 16, color: blackColour, fontWeight: FontWeight.w500);

InputDecoration inputDecoration({hintText, labelText, prefixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: backgroundColour,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primaryColour.withOpacity(0.16), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primaryColour, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    hintText: hintText,
    hintStyle: defaultText.copyWith(
      color: Colors.grey.shade400,
      fontWeight: FontWeight.w400,
    ),
    focusColor: primaryColour,
    prefixIcon: prefixIcon != null
        ? Icon(
            prefixIcon,
            color: primaryColour,
          )
        : null,
  );
}

String convertTimeOfDay(TimeOfDay time) {
  String formattedTime =
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  return formattedTime;
}

Theme themeData(BuildContext context, child) {
  return Theme(
    data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: primaryColour,
          onPrimary: backgroundColour,
          onSurface: blackColour,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColour, // button text color
          ),
        ),
        textTheme: TextTheme(
          labelLarge: defaultText,
          titleLarge: defaultText,
          headlineLarge: defaultText.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: backgroundColour,
          ),
          bodyLarge: defaultText,
          displayLarge: defaultText,
        )),
    child: child!,
  );
}
