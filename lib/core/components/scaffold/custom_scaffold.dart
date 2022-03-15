import 'package:bookapp/core/components/drawer/custom_drawer.dart';
import 'package:bookapp/core/components/loading/loading_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    Key? key,
    required this.contentWidget,
    this.isAsyncCall = false,
    required this.context,
    this.bottomNavigatorBar = const SizedBox(
      height: 0,
    ),
    this.function,
    this.appbarWidget,
    this.height = 40,
  }) : super(key: key);

  ///contentWidget of AppBar
  final Widget? contentWidget;
  final bool? isAsyncCall;
  final Widget? bottomNavigatorBar;
  final VoidCallback? function;
  final Widget? appbarWidget;
  final double? height;

  /// BuildContext
  final BuildContext context;

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: widget.isAsyncCall!,
        opacity: 0.7,
        progressIndicator: const LoadingWidget(),
        child: Scaffold(
          backgroundColor: _themeProvider.currentTheme == ThemeData.light()
              ? AppColors.white
              : AppColors.black,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(widget.height!), // Set this height
              child: widget.appbarWidget!),
          bottomNavigationBar: widget.bottomNavigatorBar!,
          body: Container(
            color: _themeProvider.currentTheme == ThemeData.light()
                ? AppColors.white
                : AppColors.black,
            child: widget.contentWidget!,
          ),
          drawer: const CustomDrawer(),
        ),
      ),
    );
  }
}
