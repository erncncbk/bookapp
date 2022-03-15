// import 'dart:io';

// import 'package:bookapp/core/components/appbar/custom_app_bar.dart';
// import 'package:bookapp/core/components/bottomnavbar/custom_bottom_navigation_bar.dart';
// import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
// import 'package:bookapp/core/components/search/search_container.dart';
// import 'package:bookapp/core/components/text_widget.dart';
// import 'package:bookapp/core/constants/app/app_colors.dart';
// import 'package:bookapp/core/extensions/string_extension.dart';
// import 'package:bookapp/core/init/navigation/navigation_service.dart';
// import 'package:bookapp/core/init/notifier/theme_notifier.dart';
// import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
// import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
// import 'package:bookapp/core/init/services/helper_service.dart';
// import 'package:bookapp/locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class AccountPage extends StatefulWidget {
//   const AccountPage({Key? key}) : super(key: key);

//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> with SingleTickerProviderStateMixin{
//   final AppStateProvider? _appStateProvider = locator<AppStateProvider>();
//   BookStateProvider? _bookStateProvider = locator<BookStateProvider>();
//   final HelperService? _helperService = locator<HelperService>();
//   NavigationService navigation = NavigationService.instance;
//   AnimationController? _controller;
//    @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _controller!.forward();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _bookStateProvider = Provider.of<BookStateProvider>(context);
//     final _themeProvider = Provider.of<ThemeNotifier>(context);

//     return CustomScaffold(
//         appbarWidget: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
//             ? CustomAppBar(
//                 title: "Account",
//                 actionWidget: _helperService!.actionWidget(_themeProvider),
//               )
//             : SizedBox(),
//         contentWidget: _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
//             ? _body(_bookStateProvider!, _themeProvider)
//             : SizedBox(),
//         isAsyncCall: _appStateProvider!.isProgressIndicatorVisible,
//         bottomNavigatorBar:
//             _bookStateProvider?.getBookListModel?.isNotEmpty ?? false
//                 ? CustomBottomNavigationBar()
//                 : SizedBox(),
//         context: context);
//     // return ModalProgressHUD(
//     //   inAsyncCall: _appStateProvider!.isProgressIndicatorVisible!,
//     //   opacity: .7,
//     //   progressIndicator: const LoadingWidget(),
//     //   child: Scaffold(
//     //     body:
//     //   ),
//     // );
//   }

//   Future getImage({ImageSource imageSource = ImageSource.gallery}) async {
//     imageCache!.clear();
//     final picker = ImagePicker();
//     final pickedFile =
//         await picker.pickImage(source: imageSource, imageQuality: 25);
//     Navigator.pop(context);
//     if (pickedFile != null) {
//       print("image picked");
//       print(pickedFile.path);

//       // _productProvider
//       _appStateProvider!.setImageFromFile(File(pickedFile.path));
//     } else {
//       print('No image selected.');
//     }
//   }

//   Widget _body(
//       BookStateProvider _bookStateProvider, ThemeNotifier _themeProvider) {
//     return _bookStateProvider.getBookListModel?.isEmpty ?? false
//         ? const SizedBox()
//         : Column(
//             children: [
//               Row(
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.all(20),
//                         child: CircleAvatar(
//                             // backgroundColor: AppColors.kPrimary,
//                             radius: 40,
//                             child: _appStateProvider!.getImageFromFile! == null
//                                 ? Icon(
//                                     Icons.account_circle,
//                                     size: 60,
//                                   )
//                                 : Container(
//                                     padding:
//                                         EdgeInsets.only(right: 13, bottom: 10),
//                                     width: double.infinity,
//                                     height: MediaQuery.of(context).size.height *
//                                         0.45,
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                             alignment: Alignment.topCenter,
//                                             fit: BoxFit.cover,
//                                             image: FileImage(_appStateProvider!
//                                                 .getImageFromFile!))),
//                                   )

//                             // SvgPicture.asset(
//                             //   "1".toSVG,
//                             //   color: AppColors.white,
//                             // ),
//                             ),
//                       ),
//                       Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.add,
//                               size: 24,
//                             ),
//                             onPressed: () {
//                               print("object");
//                               getImage();
//                             },
//                           ).customIcon)
//                     ],
//                   ),
//                   TextWidget(
//                     text: "Merhaba Erencan",
//                   )
//                 ],
//               ),
//             ],
//           );
//   }
// }

import 'package:bookapp/view/account/account_page_enter_animation.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    Key? key,
    AnimationController? controller,
  })  : animation = AccountPageEnterAnimation(controller!),
        super(key: key);
  final AccountPageEnterAnimation animation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation.controller,
        builder: (context, child) => _buildAnimation(context, child!, size),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child, Size size) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              topBar(animation.barHeight.value),
              circle(
                size,
                animation.avaterSize.value,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Opacity(
                opacity: animation.titleOpacity.value,
                child: placeholderBox(28, 150, Alignment.centerLeft),
              ),
              SizedBox(height: 8),
              Opacity(
                opacity: animation.textOpacity.value,
                child:
                    placeholderBox(250, double.infinity, Alignment.centerLeft),
              ),
            ],
          ),
        )
      ],
    );
  }

  Container topBar(double height) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.blue,
    );
  }

  Positioned circle(Size size, double animationValue) {
    return Positioned(
      top: 100,
      left: size.width / 2 - 50,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          animationValue,
          animationValue,
          1.0,
        ),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue.shade700,
          ),
        ),
      ),
    );
  }

  Align placeholderBox(double height, double width, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
