import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

import '../../util/style/style.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
      contents: [
        Stack(
          children: [
            buildProfileCard(),
            buildProfilePicture(),
            buildSettingsButton()
          ],
        ),
        buildProAdd(),
        buildProfileTabs()
      ],
    );
  }

  Container buildProfilePicture() {
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.35
        ),
        child:  InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Placeholder()),
              );
            },
            child: CircleAvatar(
                radius: 60,
                backgroundColor: Color(CustomColorPalette.secondaryColor),
                child: const CircleAvatar(
                  radius: 57,
                  backgroundImage: "Test" != ""
                      ? NetworkImage("")
                      : null,
                  child: "Test" != ""
                      ? null
                      :  Icon(
                    Icons.account_circle_outlined,
                    size: 57,
                  ),
                )
            )
        )
    );
  }

  Container buildSettingsButton() {
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.22,
            left: MediaQuery.of(context).size.width * 0.55),
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Placeholder()),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(CustomColorPalette.secondaryColor),
              child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Color(CustomColorPalette.white),
                  child: Icon(Icons.settings, color: Color(CustomColorPalette.secondaryColor))
              ),
            )
        )
    );
  }

  Container buildProfileCard() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.2
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(CustomColorPalette.primaryColor),
              child: Column(
                children: [
                  buildCardUsername(),
                  buildProfileStats()
                ],
              ),
            )
        )
    );
  }

  Container buildCardUsername() {
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        child: CustomText(
          text: "rbrunney",
          fontSize: 30,
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
          color: Color(CustomColorPalette.white),
        )
    );
  }

  Container buildProfileStats() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.03
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CustomText(
                  text: "73",
                  fontSize: 20,
                  color: Color(CustomColorPalette.white)
                ),
                CustomText(
                    text: "Recipes",
                    color: Color(CustomColorPalette.white)
                )
              ],
            )
          ),
          Expanded(
              child: Column(
                children: [
                  CustomText(
                      text: "1,303",
                      fontSize: 20,
                      color: Color(CustomColorPalette.white)
                  ),
                  CustomText(
                      text: "Followers",
                      color: Color(CustomColorPalette.white)
                  )
                ],
              )
          ),
          Expanded(
              child: Column(
                children: [
                  CustomText(
                      text: "405",
                      fontSize: 20,
                      color: Color(CustomColorPalette.white)
                  ),
                  CustomText(
                      text: "Following",
                      color: Color(CustomColorPalette.white)
                  )
                ],
              )
          )
        ],
      )
    );
  }

  Container buildProAdd() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.02
        ),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(CustomColorPalette.primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Upgrade account to PRO",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(CustomColorPalette.white),
                  )
                ],
              ),
            )
        )
    );
  }

  Container buildProfileTabs() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.03,
        horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text: "Recipes",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(CustomColorPalette.textTitleColor),
            ),
          ),
          Expanded(
            child: CustomText(
              text: "Achievement",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(CustomColorPalette.textTitleColor),
            ),
          ),
          Expanded(
            child: CustomText(
              text: "Saved",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(CustomColorPalette.textTitleColor),
            ),
          ),
        ],
      )
    );
  }
}
