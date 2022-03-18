import 'package:bookapp/core/constants/models/book_lists_models.dart';
import 'package:bookapp/core/constants/models/book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically

class BookStateGetterAndSetter with ChangeNotifier {
//* objects

  List<BookListModel>? _bookListModel;
  List<BookListModel>? get getBookListModel => _bookListModel;
  List<BookListModel>? _searchedBooks;
  List<BookListModel>? get getSearchedBooks => _searchedBooks;

  BookModel? _bookModel;
  BookModel? get getBookModel => _bookModel;

  List x = [];
  int? _selectedBookId;
  int? get getSelectedBookId => _selectedBookId;

  bool _loading = false;
  bool get getLoading => _loading;

  double? _scrollPosition = 0;
  double? get getScrollPosition => _scrollPosition;

  int _quantity = 1;
  int get getQuantity => _quantity;
  int _cartItem = 0;
  int get getCartItem => _cartItem;

  //CART
  Map<BookModel, int?> _cartBookMap = Map();
  Map<BookModel, int?> get getCartBookMap => _cartBookMap;

  //ORDER
  List<Map<BookModel, int?>> _orderBooktList = [];
  List<Map<BookModel, int?>> get getOrderBookList => _orderBooktList;
  int _orderedItem = 0;
  int get getOrderedItem => _orderedItem;
  List<int> _subTotalList = [];
  List<int> get getSubtotalList => _subTotalList;

  //FAV
  List<BookListModel> _favBookList = [];
  List<BookListModel> get getFavBookList => _favBookList;
  int _favCount = 0;
  int get getFavCount => _favCount;
  //Bookmark
  List<BookModel> _bookMarkList = [];
  List<BookModel> get getBookMarkList => _bookMarkList;

  int _bookMarkCount = 0;
  int get getBookMarkCount => _bookMarkCount;

  BookListModel? _selectedBookListModel;
  BookListModel? get getSelectedBookListModel => _selectedBookListModel;

  BookModel? _selectedBookModel;
  BookModel? get getSelectedBookModel => _selectedBookModel;

  int _subtotal = 1;
  int get getSubtotal => _subtotal;
  bool _isBarcodExist = false;
  bool get getIsBarcodExist => _isBarcodExist;

//*setters
//

  void checkBarcodExist(String value, {bool isNotifier = true}) {
    var x = getBookListModel?.firstWhereOrNull(
      (element) => element.isbn == value,
    );
    if (x != null) {
      _selectedBookId = x.id;
      print("ID: $_selectedBookId");
      _isBarcodExist = true;
    }
    if (isNotifier) notifyListeners();
  }

  void setFavList({bool isNotifier = true}) {
    if (_selectedBookListModel != null) {
      if (_selectedBookListModel!.isFav!) {
        _selectedBookListModel!.isFav = false;

        if (_favCount > 0) {
          _favCount -= 1;
        }
        _favBookList.remove(_selectedBookListModel!);
      } else {
        _selectedBookListModel!.isFav = true;

        _favCount += 1;

        _favBookList.add(_selectedBookListModel!);
      }
    } else {
      print("No item found");
    }
    print("Fav Count: $_favCount");

    // findFavItems();
    if (isNotifier) notifyListeners();
  }

  void setBookMarkList({bool isNotifier = true}) {
    if (_selectedBookModel != null) {
      if (_selectedBookModel!.isBookMark) {
        _selectedBookModel!.isBookMark = false;

        if (_bookMarkCount > 0) {
          _bookMarkCount -= 1;
        }
        _bookMarkList.remove(_selectedBookModel!);
      } else {
        _selectedBookModel!.isBookMark = true;

        _bookMarkCount += 1;

        _bookMarkList.add(_selectedBookModel!);
      }
    } else {
      print("No item found");
    }
    print("BookMark Count: $_bookMarkCount");
    print("BookMarkList: $_bookMarkList");

    // findFavItems();
    if (isNotifier) notifyListeners();
  }

  void findFavItems({bool isNotifier = true}) {
    // _favBookList =
    //     _bookListModel!.where((element) => element.isFav == true).toList();

    _cartBookMap.forEach((key, value) {
      var x = _favBookList.firstWhereOrNull((element) => element.id == key.id);

      if (x != null) {
        key.isFav = true;
      } else {
        key.isFav = false;
      }
    });

    print("Fav BookList: $_favBookList");
    print("Fav CartBook: $_cartBookMap");

    if (isNotifier) notifyListeners();
  }

  void findBook(BookModel getSelectedBook, {bool isNotifier = true}) {
    // _favBookList[getSelectedBook] = false;
    var x = _bookListModel!.firstWhereOrNull(
      (element) => element.id == getSelectedBook.id,
    );
    if (x != null) {
      x.isFav = !x.isFav!;
    } else {
      print("No item found");
    }
  }

  void addToCartList(BookModel getSelectedBook, int quantity,
      {bool isNotifier = true}) {
    quantity != 0 ? _cartItem += quantity : _cartItem = _cartItem;
    var x = _cartBookMap.keys.firstWhereOrNull(
      (element) => element.id == getSelectedBook.id,
    );
    if (x != null) {
      if (quantity < 0) {
        _cartBookMap.remove(x);
        if (isNotifier) notifyListeners();
      } else {
        int? n = _cartBookMap[getSelectedBook];
        _cartBookMap[x] = quantity + n!;
        if (isNotifier) notifyListeners();
      }
    } else {
      _cartBookMap[getSelectedBook] = quantity;
    }
    increaseSubtotal(getSelectedBook, quantity);
    print(_cartBookMap);

    if (isNotifier) notifyListeners();
  }

  void addToOrderList(Map<BookModel, int?> value, {bool isNotifier = true}) {
    _orderBooktList.add(value);
    _orderedItem += 1;
    _subTotalList.add(_subtotal);
    _cartBookMap = {};
    _cartItem = 0;

    if (isNotifier) notifyListeners();
  }

  void updateCartBookQuantitiyFromMap(BookModel getSelectedBook, int quantity,
      {bool isNotifier = true}) {
    if (!quantity.isNegative && quantity > 0) {
      _cartBookMap.update(getSelectedBook, ((value) => quantity));
    }

    if (isNotifier) notifyListeners();
  }

  void removeList(BookModel getSelectedBook,
      {bool isNotifier = true, int quantity = 0}) {
    int? n;
    if (_cartBookMap.isEmpty) {
      _cartItem = 0;
      // _quantity = 1;
    } else {
      n = _cartBookMap[getSelectedBook];
      _cartItem -= n!;
    }
    var itemPrice = getSelectedBook.price! * (n! * -1);
    _subtotal += itemPrice;
    _cartBookMap.remove(getSelectedBook);

    if (isNotifier) notifyListeners();
  }

  void setBookListModel(List<BookListModel>? value, {bool isNotifier = true}) {
    // _bookListModel != [];
    _bookListModel = value;
    if (isNotifier) notifyListeners();
  }

  void setBookModel(BookModel? value, {bool isNotifier = true}) {
    _bookModel = value;
    _selectedBookModel = _bookModel;

    // _favBookList[value!] = false;
    if (isNotifier) notifyListeners();
  }

  void setSelectedBookId(int? value, {bool isNotifier = true}) {
    _selectedBookId = value;

    _selectedBookListModel = _bookListModel!.firstWhere(
      (element) => element.id == value,
    );

    if (isNotifier) notifyListeners();
  }

  void setBookMark({bool isNotifier = true}) {
    // value!.isBookMark = !value.isBookMark!;
    _bookMarkList.forEach((element) {
      if (element.isBookMark && element.id == _selectedBookModel!.id) {
        if (_selectedBookModel != null) {
          _selectedBookModel!.isBookMark = true;
        }
      }
    });
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

  void changeQuantity(int value, {bool isNotifier = true}) {
    if (!_quantity.isNegative && _quantity > 0) {
      _quantity += value;
      if (_quantity == 0) {
        _quantity = 1;
      }
    }
    if (isNotifier) notifyListeners();
  }

  void changeCartItem(int value, {bool isNotifier = true}) {
    if (!_cartItem.isNegative && _cartItem > 0) {
      _cartItem += value;
      if (_cartItem == 0) {
        _cartItem = 1;
      }
    }
    if (isNotifier) notifyListeners();
  }

  void setQuantity(int value, {bool isNotifier = true}) {
    if (value > 0) {
      _quantity = value;
      if (isNotifier) notifyListeners();
    }
  }

  void setCartItem(int value, {bool isNotifier = true}) {
    _cartItem = value;
    if (isNotifier) notifyListeners();
  }

  void increaseSubtotal(BookModel getSelectedBook, int quantity,
      {bool isNotifier = true}) {
    var itemPrice = getSelectedBook.price! * quantity;
    _subtotal += itemPrice;

    // _subtotal += addedPrice;
    //       setSubtotal(quantity, getSelectedBook.price!.toInt());
    print("Subtotal increase");

    if (isNotifier) notifyListeners();
  }

  void decreaseSubtotal(BookModel getSelectedBook, int quantity,
      {bool isNotifier = true}) {
    int? n = _cartBookMap[getSelectedBook];
    if (n! > 1) {
      var itemPrice = getSelectedBook.price! * quantity;
      _subtotal += itemPrice;
    }
    print("Subtotal decrease");
    // _subtotal += addedPrice;
    //       setSubtotal(quantity, getSelectedBook.price!.toInt());

    if (isNotifier) notifyListeners();
  }
}
