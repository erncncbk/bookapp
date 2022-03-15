import 'package:bookapp/core/components/text_widget.dart';
import 'package:bookapp/core/constants/app/app_colors.dart';
import 'package:bookapp/core/constants/navigation/navigation_constants.dart';
import 'package:bookapp/core/extensions/string_extension.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/services/storage_service.dart';
import 'package:bookapp/locator.dart';
import 'package:bookapp/view/onboard_page/onboard_widget.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with TickerProviderStateMixin {
  NavigationService navigation = NavigationService.instance;
  final StorageService? _storageService = locator<StorageService>();

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  int? index = 0;
  @override
  void didChangeDependencies() {
    _tabController?.addListener(() {
      // _tabController.indexIsChanging;
      print(_tabController?.index.toString());
      // print(_tabController?.indexIsChanging.toString());
      setState(() {
        index = _tabController?.index;
      });
      if (_tabController?.index != null)
        _tabController?.animateTo(_tabController!.index);
      // print(_tabController.toString());
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OnboardWidget(
                        key: widget.key,
                        imagePath: "4",
                        title: "Mindfulness",
                        description:
                            "Reading is a conversation. All books talk. But a good book listens as well. Read the best books first,or you may not have a change them at all.",
                      ),
                      OnboardWidget(
                        key: widget.key,
                        imagePath: "5",
                        title: "Imagination",
                        description:
                            "Reading is one of the best ways to foster imagination. The more we read, the better we can build up and expand our knowledge.",
                      ),
                      OnboardWidget(
                        key: widget.key,
                        imagePath: "6",
                        title: "Improvement",
                        description:
                            "Exercising your imagination through reading will help you improve your ability to visualize new worlds, characters and perspectives.",
                      ),
                    ],
                  ),
                ),
                TabPageSelector(
                  controller: _tabController,
                  selectedColor: AppColors.kPrimary,
                  color: AppColors.kSecondary,
                  indicatorSize: 16,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 30,
              // left: 0,
              child: index == 2
                  ? TextButton(
                      onPressed: () async {
                        await _storageService!
                            .setFirstOpenAsync(false)
                            .then((value) {
                          navigation.navigateToPageClear(
                            path: NavigationConstants.homeView,
                          );
                        });
                      },
                      child: TextWidget(
                        text: "next",
                        textStyle: TextStyle(
                          color: AppColors.kSecondary,
                          decoration: TextDecoration.none,
                        ).smallStyle,
                        textAlign: TextAlign.right,
                      ),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
