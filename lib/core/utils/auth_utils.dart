import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class AuthUtils {
  static ValueNotifier<String> signUpcountryCode = ValueNotifier('000');
}

void changeCountryCode(BuildContext context) {
  showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: const CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500, // Optional. Country list modal height

        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: Icon(Icons.search),
            border: UnderlineInputBorder()),
      ),
      onSelect: (Country country) {
        AuthUtils.signUpcountryCode.value = country.phoneCode;
      });
}
