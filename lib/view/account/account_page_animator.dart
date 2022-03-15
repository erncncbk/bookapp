import 'package:bookapp/view/account/account_page.dart';
import 'package:flutter/material.dart';

class AccountPageAnimator extends StatefulWidget {
  const AccountPageAnimator({Key? key}) : super(key: key);

  @override
  _AccountPageAnimatorState createState() => _AccountPageAnimatorState();
}

class _AccountPageAnimatorState extends State<AccountPageAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AccountPage(
      controller: _controller!,
    );
  }
}
