import 'dart:io';

import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/notifier/theme_notifier.dart';
import 'package:bookapp/core/init/provider/app_state/app_state_provider.dart';
import 'package:bookapp/locator.dart';
import 'package:bookapp/view/account/account_page_enter_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    Key? key,
    required AnimationController controller,
  })  : animation = AccountPageEnterAnimation(controller),
        super(key: key);
  final AccountPageEnterAnimation animation;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AppStateProvider? _appStateProvider = locator<AppStateProvider>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;
  // Future getImage({ImageSource imageSource = ImageSource.gallery}) async {
  //   imageCache!.clear();
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(
  //     source: imageSource,
  //   );
  //   // Navigator.pop(context);
  //   if (pickedFile != null) {
  //     print("image picked");
  //     print(pickedFile.path);

  //     // _productProvider
  //     _appStateProvider!.setImageFromFile(File(pickedFile.path));
  //   } else {
  //     print('No image selected.');
  //   }
  // }

  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;

    var ref = _firebaseStorage.ref().child('images').child("$fileName.jpg");
    print(ref);
    try {
      var uploadTask = await ref.putFile(imageFile!);
      if (status == 1) {
        String imageUrl = await uploadTask.ref.getDownloadURL();
        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({"imageUrl": imageUrl});
        print(imageUrl);
        print("image updated");
      }
    } catch (error) {
      // await _firestore
      //     .collection('chatroom')
      //     .doc(widget.chatRoomId)
      //     .collection('chats')
      //     .doc(fileName)
      //     .delete();
      status = 0;
      print("image upload failed");

      print(error);
    }
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();

    await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 25)
        .then((xFile) async {
      if (xFile != null) {
        imageFile = File(xFile.path);
        _appStateProvider!.setImageFromFile(File(xFile.path));
        print("image picked");
        await uploadImage();
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<ThemeNotifier>(context);

    _appStateProvider = Provider.of<AppStateProvider>(context);
    final size = MediaQuery.of(context).size;
    return CustomScaffold(
      appbarWidget: CustomAppBarTwo(
        title: "Account",
        actionWidget: _actionWidget(),
      ),
      contentWidget: AnimatedBuilder(
        animation: widget.animation.controller,
        builder: (context, _) =>
            _buildAnimation(context, size, _appStateProvider!, _themeProvider),
      ),
      context: context,
    );
  }

  Widget _buildAnimation(BuildContext context, Size size,
      AppStateProvider _appStateProvider, ThemeNotifier _themeProvider) {
    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              Map<String, dynamic>? data =
                  snapshot.data!.docs[0].data() as Map<String, dynamic>?;
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        topBar(
                            widget.animation.barHeight.value, _themeProvider),
                        circle(size, widget.animation.avaterSize.value, data),
                        // image()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Opacity(
                          opacity: widget.animation.titleOpacity.value,
                          // child: placeholderBox(28, 150, Alignment.centerLeft),
                          child: TextWidget(
                            text: 'Hello ${data!['name']}',
                            textStyle: TextStyle(
                              color: AppColors.kPrimary,
                              decoration: TextDecoration.none,
                            ).smallStyle2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 50),
                        Opacity(
                          opacity: widget.animation.textOpacity.value,
                          child: placeholderBox(350, double.infinity,
                              Alignment.centerLeft, _themeProvider),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Container topBar(double height, ThemeNotifier _themeProvider) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        height: height * 2,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _themeProvider.currentTheme != ThemeData.light()
              ? AppColors.white.withOpacity(0.13)
              : AppColors.grey.withOpacity(0.13),
        ),
      ),
    );
  }

  Positioned circle(
      Size size, double animationValue, Map<String, dynamic>? data) {
    return Positioned(
      top: 50,
      left: size.width / 2 - 60,
      child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(
            animationValue,
            animationValue,
            1.0,
          ),
          child: Stack(
            children: [
              image(data),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: AppColors.kPrimary,
                    size: 40,
                  ),
                  onTap: () {
                    print("aa");
                    getImage();
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget image(Map<String, dynamic>? data) {
    return SizedBox(
        child: CircleAvatar(
      backgroundColor: Colors.transparent,
      minRadius: 10,
      // borderRadius: BorderRadius.circular(20),
      child: ClipOval(
        child: Image.network(
          data!['imageUrl'],
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: 120.0,
              height: 120.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimary),
                backgroundColor: AppColors.white,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          width: 120.0,
          height: 120.0,
        ),
      ),
    ));
  }

  Align placeholderBox(double height, double width, Alignment alignment,
      ThemeNotifier _themeProvider) {
    return Align(
      alignment: alignment,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _themeProvider.currentTheme != ThemeData.light()
              ? AppColors.white.withOpacity(0.13)
              : AppColors.grey.withOpacity(0.13),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'My Orders',
                        textStyle: TextStyle(
                          color:
                              _themeProvider.currentTheme != ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                          decoration: TextDecoration.none,
                        ).extraSmallStyle,
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      height: .5,
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white.withOpacity(0.13)
                          : AppColors.grey.withOpacity(0.13),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'My Lists',
                        textStyle: TextStyle(
                          color:
                              _themeProvider.currentTheme != ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                          decoration: TextDecoration.none,
                        ).extraSmallStyle,
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      height: .5,
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white.withOpacity(0.13)
                          : AppColors.grey.withOpacity(0.13),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Personal Informations',
                        textStyle: TextStyle(
                          color:
                              _themeProvider.currentTheme != ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                          decoration: TextDecoration.none,
                        ).extraSmallStyle,
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      height: .5,
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white.withOpacity(0.13)
                          : AppColors.grey.withOpacity(0.13),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Notifications',
                        textStyle: TextStyle(
                          color:
                              _themeProvider.currentTheme != ThemeData.light()
                                  ? AppColors.white
                                  : AppColors.black,
                          decoration: TextDecoration.none,
                        ).extraSmallStyle,
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      height: .5,
                      color: _themeProvider.currentTheme != ThemeData.light()
                          ? AppColors.white.withOpacity(0.13)
                          : AppColors.grey.withOpacity(0.13),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
