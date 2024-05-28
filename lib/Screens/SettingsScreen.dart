import 'package:ecommerce_app/Services/changeLanguage.dart';
import 'package:ecommerce_app/Utils/MainColors.dart';
import 'package:ecommerce_app/Utils/Text_Style.dart';
import 'package:ecommerce_app/generated/l10n.dart';
import 'package:ecommerce_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isEnglish = true;
  String _LanguageCode = "en";
  bool _isLoading = false;

  @override
  void initState() {
    ChangeLanguage.getLanguage().then((value) {
      setState(() {
        _LanguageCode == value;
      });
    });
    super.initState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          progressIndicator: Center(
            child: SpinKitSpinningLines(
              color: Colors.white,
              size: 60,
            ),
          ),
          inAsyncCall: _isLoading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    S.of(context).SettingsAppBar,
                    style:
                        Text_Style.textStyleNormal(MainColors.PrimaryColor, 23),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 5,
                              color: Colors.black26)
                        ],
                        color: MainColors.PrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                                Future.delayed(Duration(seconds: 3), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                if (_LanguageCode == "ar") {
                                  _LanguageCode = "en";
                                  ChangeLanguage.setLanguage("en");

                                  MyApp.setLocale(context, _LanguageCode);
                                } else {
                                  _LanguageCode = "ar";
                                  ChangeLanguage.setLanguage("ar");

                                  MyApp.setLocale(context, _LanguageCode);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.white38))),
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).ChangeLanguage,
                                    style: Text_Style.textStyleNormal(
                                        Colors.white, 18),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Iconsax.repeat_circle,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
