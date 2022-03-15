import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key,
      this.isEnable = true,
      this.onChanged,
      this.controller,
      this.focusNode,
      this.suffixIcon,
      this.autoFocus = false})
      : super(key: key);

  final bool? isEnable;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? autoFocus;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);
    Color themeColor = _themeProvider.currentTheme != ThemeData.light()
        ? AppColors.white
        : AppColors.black;

    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
          width: double.infinity,
          height: 40,
          child: _searchTextField(themeColor)),
    );
  }

  Widget _searchTextField(Color themeColor) {
    return TextField(
        autofocus: widget.autoFocus!,
        focusNode: widget.focusNode,
        controller: widget.controller,
        style: TextStyle(color: themeColor).extraSmallStyle,
        cursorColor: AppColors.kPrimary,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 10),
          enabled: widget.isEnable!,
          iconColor: themeColor,
          prefixIcon: Icon(Icons.search, color: themeColor),
          suffixIcon: widget.suffixIcon,
          hintText: 'Search...',
          hintStyle: TextStyle(color: themeColor).extraSmallStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: AppColors.grey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: themeColor, width: .5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: themeColor, width: .5),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: themeColor, width: .5)),
          focusColor: themeColor,
        )
        // border: InputBorder.none),

        );
  }
}
