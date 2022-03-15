// To parse this JSON data, do
//
//     final bookListModel = bookListModelFromJson(jsonString);

import 'dart:convert';

List<BookListModel> bookListModelFromJson(String str) =>
    List<BookListModel>.from(
        json.decode(str).map((x) => BookListModel.fromJson(x)));

String bookListModelToJson(List<BookListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookListModel {
  BookListModel({
    this.id,
    this.title,
    this.isbn,
    this.price,
    this.currencyCode,
    this.author,
  });

  int? id;
  String? title;
  String? isbn;
  int? price;
  String? currencyCode;
  String? author;

  factory BookListModel.fromJson(Map<String, dynamic> json) => BookListModel(
        id: json["id"],
        title: json["title"],
        isbn: json["isbn"],
        price: json["price"],
        currencyCode: json["currencyCode"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "isbn": isbn,
        "price": price,
        "currencyCode": currencyCode,
        "author": author,
      };
}
