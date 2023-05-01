import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/to_previous_page.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text_field.dart';
import 'package:whatsfordinner/util/widgets/text/page_title.dart';

class AccountDetailsPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  const AccountDetailsPage({
    Key? key,
    this.username = '',
    this.email = '',
    this.password = ''
  }) : super(key: key);

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {

  // final urlController = Get.put(URLController());

  void onSubmit() async {
    // if (fnameController.text.isNotEmpty && lnameController.text.isNotEmpty && birthdayErrorText == null) {
    //   Map<String, dynamic> requestBody = {
    //     "username" : RSA.encrypt(widget.username),
    //     "password" : RSA.encrypt(widget.password),
    //     "firstName" : RSA.encrypt(fnameController.text),
    //     "lastName" : RSA.encrypt(lnameController.text),
    //     "birthdate" : RSA.encrypt(birthdayController.text),
    //     "email" : RSA.encrypt(widget.email),
    //     "phone" : RSA.encrypt("555-555-5555"),
    //     "buyingPower" : 5000
    //   };
    //
    //   await BasicRequest.makePostRequest("${urlController.localBaseURL}/invested_account", requestBody)
    //       .then((value) async {
    //
    //     Map<String, dynamic> requestBody = {
    //       "username" : RSA.encrypt(widget.username),
    //       "password" : RSA.encrypt(widget.password)
    //     };
    //
    //     await BasicRequest.makePostRequest("${urlController.localBaseURL}/invested_account/authenticate", requestBody)
    //         .then((value) async {
    //       var response = json.decode(value);
    //       await AuthRequest.makePostRequest("${urlController.localBaseURL}/invested_portfolio", {}, response['results']['access-token'])
    //           .then((value) {
    //         Navigator.of(context).pushAndRemoveUntil(
    //             MaterialPageRoute(
    //                 builder: (context) => const LandingPage()),
    //                 (Route<dynamic> route) => false);
    //       });
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold (
          body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: buildHeader()
              ),
              Expanded(
                  flex: 3,
                  child: buildAdditionalDetailsForm()
              )
            ],
          ),
        )
    );
  }

  Column buildHeader() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
          child: ToPrevPage(color: Color(CustomColorPalette.textTitleColor)),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.03,
          ),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Image.asset('./assets/images/icon.png')
          ),
        ),
      ],
    );
  }

  Column buildAdditionalDetailsForm() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: const PageTitle(title: 'Final Steps'),
        ),
        buildMessage(),
        buildFirstNameTextField(),
        buildLastNameTextField(),
        buildBirthdayTextField(),
        buildCreateAccountButton()
      ],
    );
  }

  TextEditingController birthdayController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  CustomTextField buildFirstNameTextField() {
    return  CustomTextField(
        horizontalMargin: MediaQuery.of(context).size.width * 0.05,
        textCallBack: (value) {},
        labelText: 'Enter First Name',
        hintText: 'Enter First Name...',
        errorText: null,
        prefixIcon: MaterialCommunityIcons.account_edit_outline,
        textController: fnameController
    );
  }

  CustomTextField buildLastNameTextField() {
    return CustomTextField(
        horizontalMargin: MediaQuery.of(context).size.width * 0.05,
        textCallBack: (value) {},
        labelText: 'Enter Last Name',
        hintText: 'Enter Last Name...',
        errorText: null,
        prefixIcon: MaterialCommunityIcons.account_edit_outline,
        textController: lnameController
    );
  }

  String? get birthdayErrorText {
    final text = birthdayController.text;

    List<String> dateInfo = text.split("-");
    RegExp birthdayCheck = RegExp(r'^([0-9]{2})-([0-9]{2})-([0-9]{4})$');

    int MAX_MONTH = 12;
    int MAX_FULL_MONTH_DAY = 31;
    int MAX_PARTIAL_MONTH_DAY = 30;
    int MAX_FEBRUARY_DAY = 28;
    int MAX_FEBRUARY_LEAP_DAY = 29;
    int APRIL = 4;
    int JUNE = 6;
    int SEPTEMBER = 9;
    int NOVEMBER = 11;

    if(!birthdayCheck.hasMatch(text)) {
      return 'Birthday does not match MM-DD-YYYY';
    } else if (int.parse(dateInfo[0]) > MAX_MONTH) {
      return 'Invalid Month!';
    }
    // Checking to see if the date in APRIL, JUNE, SEPTEMBER, NOVEMBER is over 30
    else if ([APRIL, JUNE, SEPTEMBER, NOVEMBER].contains(int.parse(dateInfo[0])) && int.parse(dateInfo[1]) > MAX_PARTIAL_MONTH_DAY) {
      return 'Invalid Day!';
    }
    // Checking any other month hat was not listed before
    else if (int.parse(dateInfo[0]) != 2 && int.parse(dateInfo[1]) > MAX_FULL_MONTH_DAY) {
      return 'Invalid Day!';
    }
    // Checking to see if the year is dividable by 4, meaning its a leap year, and need to check FEBRUARY date
    else if (int.parse(dateInfo[2]) % 4 == 0 && int.parse(dateInfo[0]) == 2 && int.parse(dateInfo[1]) > MAX_FEBRUARY_LEAP_DAY) {
      return 'Invalid Day!';
    }
    // Checking to see if FEBRUARY date is valid when it is not a leap year
    else if (int.parse(dateInfo[2]) % 4 != 0 && int.parse(dateInfo[0]) == 2 && int.parse(dateInfo[1]) > MAX_FEBRUARY_DAY) {
      return 'Invalid Day!';
    }

    return null;
  }

  CustomTextField buildBirthdayTextField() {
    return CustomTextField(
        horizontalMargin: MediaQuery.of(context).size.width * 0.05,
        textCallBack: (value) {},
        labelText: 'Enter Birthday',
        hintText: 'MM-DD-YYYY',
        errorText: birthdayErrorText,
        prefixIcon: Icons.calendar_today_outlined,
        textController: birthdayController
    );
  }

  CustomText buildMessage() {
    return CustomText(
      leftMargin: MediaQuery.of(context).size.width * 0.05,
      rightMargin: MediaQuery.of(context).size.width * 0.05,
      bottomMargin: 10,
      text: "Almost Finished! We just need a little bit more information about you!",
      fontSize: 15, color: Color(CustomColorPalette.textBodyColor),
    );
  }

  Container buildCreateAccountButton() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: CustomButton(onTap: (fnameController.text.isNotEmpty && lnameController.text.isNotEmpty && birthdayController.text.isNotEmpty)
            ? onSubmit : () {},
            text: 'Create Account', hasFillColor: true, color: Color(CustomColorPalette.primaryColor),)
    );
  }
}