import 'package:bookapp/core/components/alert/alert_dialog.dart';
import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/clipper/custom_clipper.dart';
import 'package:bookapp/core/components/textFormField/custom_text_form_field_widget.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/extensions/context_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/services/fb_auth_service.dart';
import 'package:bookapp/core/init/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  NavigationService navigation = NavigationService.instance;
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();
  FocusNode? _emailFocus;
  FocusNode? _passwordFocus;
  final formKey = GlobalKey<FormState>();

  final FBAuthService? _fbAuthService = FBAuthService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailFocus!.dispose();
    _passwordFocus!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();

    super.dispose();
  }

  fieldFocusChange(
      BuildContext? context, FocusNode? currentFocus, FocusNode? nextFocus) {
    // currentFocus!.unfocus();
    // FocusScope.of(context!).requestFocus(nextFocus);
  }

  void _forgotPassword() {
    final form = formKey.currentState;
    if (form!.validate()) {
      _fbAuthService!
          .resetPassword(context, _emailController!.text)
          .then((value) {
        if (value) {
          showAlertDialog(context, "A password reset link was sent", () {
            navigation.navigateToPageClear(path: NavigationConstants.loginPage);
          });
        }
        form.save();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: _body(_themeProvider),
      backgroundColor: _themeProvider.currentTheme == ThemeData.light()
          ? AppColors.white
          : AppColors.grey.withOpacity(0.3),
      bottomNavigationBar: _footer(_themeProvider),
    );
  }

  Widget _footer(ThemeNotifier _themeProvider) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 8,
                    color: AppColors.kPrimary.withOpacity(0.5),
                  )),
              GestureDetector(
                onTap: () {
                  navigation.navigateToPageClear(
                    path: NavigationConstants.loginPage,
                  );
                },
                child: TextWidget(
                  text: 'Sign In',
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.white
                        : AppColors.black,
                    fontWeight: FontWeight.w800,
                  ).smallStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: MyClipper3(),
                  child: Container(
                    height: 380,
                    decoration: BoxDecoration(color: AppColors.kSecondary),
                  ),
                ),
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.grey),
                  ),
                ),
                ClipPath(
                  clipper: MyClipper2(),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(color: AppColors.kSecondary),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: context.highValue,
                      ),
                      CustomTextFormFieldWidget(
                        hintText: "E-mail",
                        initialValue: "",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => {},
                        focusNode: _emailFocus,
                        onFieldSubmitted: fieldFocusChange(
                            context, _emailFocus, _passwordFocus),
                        onSaved: (value) => {},
                        validate: (value) =>
                            CustomValidator().emailValidate(value!),
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: context.highValue,
                      ),
                      WidgetAnimator(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: 'Send Request',
                              textStyle: TextStyle(
                                color: _themeProvider.currentTheme !=
                                        ThemeData.light()
                                    ? AppColors.white
                                    : AppColors.black,
                                fontWeight: FontWeight.w800,
                              ).largeStyle,
                              textAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              onTap: () {
                                _forgotPassword();
                              },
                              child: ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.kSecondary),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: -30,
          left: 0,
          right: 0,
          child: WidgetAnimator(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: SvgPicture.asset(
                "2".toSVG,
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: GestureDetector(
            onTap: () {
              navigation.navigateToPageClear(
                  path: NavigationConstants.homeView);
            },
            child: ClipOval(
              clipBehavior: Clip.hardEdge,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(color: AppColors.kPrimary),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
