class ApiUrl {
  static String baseUrl = 'http://tpbookserver.herokuapp.com';
  static String getBookList = baseUrl + '/books';
  static String getSingleBook({required String id}) => baseUrl + '/book/$id';
}
