import 'package:bookapp/core/components/alert/alert_dialog.dart';
import 'package:bookapp/core/components/animations/bottomAnimation.dart';
import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/buttons/custom_elevated_button.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/textFormField/custom_text_form_field_widget.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookapp/core/extensions/context_extension.dart';

class GiftCard extends StatefulWidget {
  GiftCard({Key? key}) : super(key: key);

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _emailController2 = TextEditingController();
  TextEditingController? _priceController = TextEditingController();
  TextEditingController? _messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  FocusNode? _nameFocus;
  FocusNode? _emailFocus;
  FocusNode? _emailFocus2;
  FocusNode? _priceFocus;
  FocusNode? _messageFocus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _emailController2 = TextEditingController();
    _priceController = TextEditingController();
    _messageController = TextEditingController();
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _emailFocus2 = FocusNode();
    _priceFocus = FocusNode();
    _messageFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _emailController2!.dispose();
    _priceController!.dispose();
    _messageController!.dispose();
    _emailFocus!.dispose();
    _emailFocus2!.dispose();
    _priceFocus!.dispose();
    _messageFocus!.dispose();

    super.dispose();
  }

  fieldFocusChange(
      BuildContext? context, FocusNode? currentFocus, FocusNode? nextFocus) {
    // currentFocus!.unfocus();
    // FocusScope.of(context!).requestFocus(nextFocus);
  }
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    // return Scaffold(
    //   body: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
    //       ? _body(_bookStateProvider!, _themeProvider)
    //       : SizedBox(),
    // );

    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Gift Card",
          actionWidget: _actionWidget(),
        ),
        contentWidget: _body(_themeProvider),
        context: context);
  }

  Widget _body(ThemeNotifier _themeProvider) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _giftCardImage(),
            WidgetAnimator(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextWidget(
                      text: "Hundreds of options with one gift!",
                      textStyle: TextStyle(
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold)
                          .normalStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextWidget(
                      text:
                          "Give your loved ones a 'Book Store' gift card, and let them choose what they like from the 'Book Store' wide range of book products.",
                      textStyle: TextStyle(
                        color: _themeProvider.currentTheme != ThemeData.light()
                            ? AppColors.white
                            : AppColors.black,
                        decoration: TextDecoration.none,
                      ).smallStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextWidget(
                      text: "Don't think about what to get.",
                      textStyle: TextStyle(
                              color: _themeProvider.currentTheme !=
                                      ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold)
                          .smallStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            _form(context, _themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _form(BuildContext context, ThemeNotifier _themeProvider) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formKey,
          child: WidgetAnimator(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.mediumValue),
                TextWidget(
                  text: "Who do you want to send?",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.kPrimary
                        : AppColors.kSecondary,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
                CustomTextFormFieldWidget(
                  radius: 5,
                  initialValue: "",
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => {},
                  focusNode: _nameFocus,
                  onFieldSubmitted:
                      fieldFocusChange(context, _nameFocus, _emailFocus),
                  onSaved: (value) => {},
                  validate: (value) =>
                      CustomValidator().nickNameValidate(value!),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                TextWidget(
                  text: "Email",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.kPrimary
                        : AppColors.kSecondary,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
                CustomTextFormFieldWidget(
                  radius: 5,
                  initialValue: "",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => {},
                  focusNode: _emailFocus,
                  onFieldSubmitted:
                      fieldFocusChange(context, _emailFocus, _emailFocus2),
                  onSaved: (value) => {},
                  validate: (value) => CustomValidator().emailValidate(value!),
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                TextWidget(
                  text: "Confirm Email",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.kPrimary
                        : AppColors.kSecondary,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
                CustomTextFormFieldWidget(
                  radius: 5,
                  initialValue: "",
                  controller: _emailController2,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => {},
                  focusNode: _emailFocus2,
                  onFieldSubmitted:
                      fieldFocusChange(context, _emailFocus2, _priceFocus),
                  onSaved: (value) => {},
                  validate: (value) => CustomValidator()
                      .confirmEmailValidate(_emailController!.text, value!),
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                TextWidget(
                  text: "Price",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.kPrimary
                        : AppColors.kSecondary,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
                CustomTextFormFieldWidget(
                  radius: 5,
                  initialValue: "",
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => {},
                  focusNode: _priceFocus,
                  onFieldSubmitted:
                      fieldFocusChange(context, _priceFocus, _messageFocus),
                  onSaved: (value) => {},
                  validate: (value) => CustomValidator().priceValidate(value!),
                  readOnly: false,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                TextWidget(
                  text: "Message",
                  textStyle: TextStyle(
                    color: _themeProvider.currentTheme != ThemeData.light()
                        ? AppColors.kPrimary
                        : AppColors.kSecondary,
                    decoration: TextDecoration.none,
                  ).smallStyle,
                  textAlign: TextAlign.left,
                ),
                CustomTextFormFieldWidget(
                  radius: 5,
                  initialValue: "",
                  maxLine: 15,
                  minLine: 5,
                  controller: _messageController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => {},
                  focusNode: _messageFocus,
                  onSaved: (value) => {},
                  validate: (value) =>
                      CustomValidator().messageValidate(value!),
                  readOnly: false,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: context.lowValue,
                ),
                CustomElevatedButton(
                  height: 50,
                  btnColor: _themeProvider.currentTheme != ThemeData.light()
                      ? AppColors.kPrimary.withOpacity(0.9)
                      : AppColors.kSecondary.withOpacity(0.9),
                  btnFunction: () {
                    _addtoCart();
                  },
                  text: "Add to Cart",
                ),
                SizedBox(
                  height: context.mediumValue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addtoCart() {
    final form = formKey.currentState;
    if (form!.validate()) {
      showAlertDialog(context, "Gift Cart Added to Cart", () {
        Navigator.pop(context);
      });
    }
  }

  Widget _giftCardImage() {
    return WidgetAnimator(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                scale: 1,
                image: AssetImage(
                  Constant.giftCard.first,
                ),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }

  Widget _actionWidget() {
    return IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () => {print("xd")}).customIcon;
  }
}
