import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/enums/app_theme_enum.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/core/init/services/fb_auth_service.dart';
import 'package:bookapp/core/init/services/process_service.dart';
import 'package:bookapp/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FBAuthService? _fbAuthService = FBAuthService();
  NavigationService navigation = NavigationService.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ProcessService? _processService = locator<ProcessService>();

  bool isSwitched = false;

  bool isConnectionOk = false;

  @override
  void initState() {
    main();
    super.initState();
  }

  Future main() async {
    isConnectionOk = await _processService!.checkConnectionAsync(context);
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    List<void Function()?> functionList = [
      //Account Function
      (() {
        print(Constant.titleList[0]);
        navigation.navigateToPage(path: NavigationConstants.accountPage);
      }),
      //Orders Function
      (() {
        print(Constant.titleList[1]);
        navigation.navigateToPage(path: NavigationConstants.orderPage);
      }),
      //What Should I Read Function
      (() {
        print(Constant.titleList[2]);
        navigation.navigateToPage(path: NavigationConstants.discoverDetail);
      }),
      //Bookmarks Function
      (() {
        print(Constant.titleList[3]);
        navigation.navigateToPage(path: NavigationConstants.bookmarks);
      }), //Authors Function
      // (() => {print(Constant.titleList[4])}),
      // //Campaigns Function

      (() {
        print(Constant.titleList[4]);
        navigation.navigateToPage(path: NavigationConstants.campaignsPage);
      }),
      (() {
        print(Constant.titleList[5]);
        navigation.navigateToPage(path: NavigationConstants.giftCardPage);
      }),
      (() {
        print(Constant.titleList[6]);
        navigation.navigateToPage(path: NavigationConstants.settings);
      }),
    ];

    return Drawer(
      backgroundColor: _themeProvider.currentTheme == ThemeData.light()
          ? AppColors.white
          : AppColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _appStateProvider!.getToken != null
                    ? _accountInfo(_themeProvider)
                    : Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              Icons.account_circle,
                              size: 100,
                            ),
                          ),
                          InkWell(
                              onTap: (() => navigation.navigateToPage(
                                  path: NavigationConstants.loginPage)),
                              child: TextWidget(
                                text: "Login",
                                textStyle: TextStyle(
                                        color: _themeProvider.currentTheme !=
                                                ThemeData.light()
                                            ? AppColors.white
                                            : AppColors.black,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w600)
                                    .normalStyle,
                                textAlign: TextAlign.left,
                              ))
                        ],
                      ),
                ListView.builder(
                  itemCount: Constant.titleList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        child: ListTile(
                      leading: Icon(Constant.iconList[index]),
                      title: GestureDetector(
                        onTap: functionList[index],
                        child: TextWidget(
                          text: Constant.titleList[index],
                          textStyle: TextStyle(
                            color:
                                _themeProvider.currentTheme != ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                            decoration: TextDecoration.none,
                          ).smallStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        // if (index == 0) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.SUPPORTS_PAGE);
                        // } else if (index == 2) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.NEW_FEEDBACK_PAGE);
                        // } else if (index == 3) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.SCAN_PAGE);
                        // } else if (index == 4) {
                        //   Navigator.pushNamed(
                        //       context, AppRoute.CAMPAINS_PAGE);
                        // } else if (index == 5) {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertWidget(
                        //           alertType: AlertType.Logout,
                        //         );
                        //       });
                        // }
                      },
                    ));
                  },
                ),
              ],
            ),
            Positioned(
                top: 10,
                bottom: 10,
                right: 0,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new),
                ).customIcon),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: _themeProvider.currentTheme == ThemeData.light()
                      ? Icon(
                          Icons.nights_stay,
                          color: AppColors.black,
                          size: 30,
                        )
                      : Icon(
                          Icons.light_mode,
                          color: AppColors.white,
                          size: 30,
                        ),
                  onPressed: () {
                    if (_themeProvider.currentTheme == ThemeData.light()) {
                      _themeProvider.changeValue(AppThemes.DARK);
                    } else {
                      _themeProvider.changeValue(AppThemes.LIGHT);
                    }
                  },
                ).customIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountInfo(ThemeNotifier _themeProvider) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            Map<String, dynamic>? data =
                snapshot.data?.data() as Map<String, dynamic>?;
            if (data != null && data['imageUrl'] != "" && isConnectionOk) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      minRadius: 10,
                      // borderRadius: BorderRadius.circular(20),
                      child: ClipOval(
                        child: Image.network(
                          data['imageUrl'],
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              transformAlignment: Alignment.center,
                              width: 90.0,
                              height: 90.0,
                              alignment: Alignment.centerLeft,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.kPrimary),
                                backgroundColor: AppColors.white,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          width: 90.0,
                          height: 90.0,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: TextWidget(
                          text: 'Hello ${data['name']}',
                          textStyle: TextStyle(
                            color: AppColors.kPrimary,
                            decoration: TextDecoration.none,
                          ).extraSmallStyle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _fbAuthService!.signOut(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 20,
                            ),
                            TextWidget(
                              text: "Sign Out",
                              textStyle: TextStyle(
                                color: _themeProvider.currentTheme !=
                                        ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                                decoration: TextDecoration.none,
                              ).extraSmallStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
              //
            } else {
              return Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: TextWidget(
                          text: 'Hello ${data?['name'] ?? ""}',
                          textStyle: TextStyle(
                            color: AppColors.kPrimary,
                            decoration: TextDecoration.none,
                          ).extraSmallStyle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _fbAuthService!.signOut(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 20,
                            ),
                            TextWidget(
                              text: "Sign Out",
                              textStyle: TextStyle(
                                color: _themeProvider.currentTheme !=
                                        ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                                decoration: TextDecoration.none,
                              ).extraSmallStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
          }),
    );
  }
}
