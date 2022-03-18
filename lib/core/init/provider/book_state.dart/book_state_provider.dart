import 'package:bookapp/core/constants/app/api_url.dart';
import 'package:bookapp/core/constants/app/app_constants.dart';
import 'package:bookapp/core/constants/enums/http_request_enum.dart';
import 'package:bookapp/core/constants/models/book_lists_models.dart';
import 'package:bookapp/core/constants/models/book_model.dart';
import 'package:bookapp/core/init/network/service_api.dart';
import 'package:bookapp/core/init/provider/book_state.dart/book_state_getset.dart';

class BookStateProvider extends BookStateGetterAndSetter {
  Future<bool?> getBookList() async {
    bool result;

    if (getBookListModel == null) {
      dynamic response = await RequestHelper.requestAsync(
        RequestType.Get,
        ApiUrl.getBookList,
      );
      if (response == null) {
        result = false;
      } else {
        List<BookListModel> entity = Constant.book_list
            .map<BookListModel>((f) => BookListModel.fromJson(f))
            .toList();
        setBookListModel(entity);
        result = true;
      }
      return result;
    } else {
      setBookListModel(getBookListModel);

      result = true;
    }
    return result;

    /// For Test Json
    // if (Constant.book_list.isNotEmpty) {
    //   List<BookListModel> entity = Constant.book_list
    //       .map<BookListModel>((f) => BookListModel.fromJson(f))
    //       .toList();
    //   setBookListModel(entity);
    //   result = true;
    // } else {
    //   result = false;
    // }
  }

  Future<bool?> getBook() async {
    bool result;

    dynamic response = await RequestHelper.requestAsync(
      RequestType.Get,
      ApiUrl.getSingleBook(id: "$getSelectedBookId"),
    );
    if (response == null) {
      result = false;
    } else {
      BookModel entity = BookModel.fromJson(response);
      setBookModel(entity);

      result = true;
    }
    return result;

    /// For Test Json

    // var num = getSelectedBookId.toString().replaceAll('0', "");
    // BookModel entity = BookModel.fromJson(Constant.book[int.parse(num) - 1]);
    // if (Constant.book.isNotEmpty) {
    //   setBookModel(entity);
    //   result = true;
    // } else {
    //   result = false;
    // }
  }
}
