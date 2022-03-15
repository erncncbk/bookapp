import 'package:bookapp/core/constants/models/book_lists_models.dart';
import 'package:bookapp/core/constants/models/book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookStateGetterAndSetter with ChangeNotifier {
//* objects

  List<BookListModel>? _bookListModel;
  List<BookListModel>? get getBookListModel => _bookListModel;
  List<BookListModel>? _searchedBooks;
  List<BookListModel>? get getSearchedBooks => _searchedBooks;

  BookModel? _bookModel;
  BookModel? get getBookModel => _bookModel;

  int? _selectedBookId;
  int? get getSelectedBookId => _selectedBookId;

  bool _loading = false;
  bool get getLoading => _loading;

  double? _scrollPosition = 0;
  double? get getScrollPosition => _scrollPosition;
//*setters
//

  void setBookListModel(List<BookListModel>? value, {bool isNotifier = true}) {
    _bookListModel != [];
    _bookListModel = value;
    if (isNotifier) notifyListeners();
  }

  void setBookModel(BookModel? value, {bool isNotifier = true}) {
    _bookModel = value;
    if (isNotifier) notifyListeners();
  }

  void setSelectedBookId(int? value, {bool isNotifier = true}) {
    _selectedBookId = value;
    if (isNotifier) notifyListeners();
  }

  void setBookMark(BookModel? value, {bool isNotifier = true}) {
    value!.isBookMark = !value.isBookMark!;
    if (isNotifier) notifyListeners();
  }

  void setLoading(bool value, {bool isNotifier = true}) {
    _loading = value;
    if (isNotifier) notifyListeners();
  }

  void findSearchBooks(String value, {bool isNotifier = true}) {
    if (value.isNotEmpty) {
      _searchedBooks = _bookListModel
          ?.where((element) =>
              element.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      _searchedBooks?.clear();
    }
    if (isNotifier) notifyListeners();
  }

  void clearSearchedBooks({bool isNotifier = true}) {
    _searchedBooks?.clear();
    if (isNotifier) notifyListeners();
  }

  void setScrollPosition(double value, {bool isNotifier = true}) {
    _scrollPosition = value;
    if (isNotifier) notifyListeners();
  }
}
