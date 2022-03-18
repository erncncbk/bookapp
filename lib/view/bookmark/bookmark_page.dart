import 'package:bookapp/core/components/appbar/custom_app_two.dart';
import 'package:bookapp/core/components/scaffold/custom_scaffold.dart';
import 'package:bookapp/core/init/navigation/navigation_service.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_provider.dart';
import 'package:bookapp/core/init/services/helper_service.dart';
import 'package:bookapp/view/bookmark/empty_bookmark.dart';
import 'package:bookapp/view/bookmark/not_empty_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  NavigationService navigation = NavigationService.instance;

  @override
  Widget build(BuildContext context) {
    BookStateProvider _bookStateProvider =
        Provider.of<BookStateProvider>(context);

    return CustomScaffold(
        appbarWidget: CustomAppBarTwo(
          title: "Bookmarks",
          actionWidget: HelperService.moreHoriz(),
        ),
        contentWidget: _bookStateProvider.getBookMarkCount == 0
            ? const EmptyBookmark()
            : const NotEmptyBookmark(),
        context: context);
  }
}
