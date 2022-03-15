// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  BookModel(
      {this.id,
      this.title,
      this.isbn,
      this.description,
      this.price,
      this.currencyCode,
      this.author,
      this.isBookMark = false});

  int? id;
  String? title;
  String? isbn;
  String? description;
  int? price;
  String? currencyCode;
  String? author;
  bool? isBookMark;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json["title"],
        isbn: json["isbn"],
        description: json["description"],
        price: json["price"],
        currencyCode: json["currencyCode"],
        author: json["author"],
        isBookMark: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "isbn": isbn,
        "description": description,
        "price": price,
        "currencyCode": currencyCode,
        "author": author,
        "isBookMark": isBookMark
      };
}
