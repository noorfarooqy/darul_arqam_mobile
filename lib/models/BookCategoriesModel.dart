import 'package:darularqam/models/BookModel.dart';

class BookCategoriesModel {
  BookCategoriesModel(data) {
    if (data != null) {
      print(data);
      categoryName = data['category_name'];
      categoryId = int.parse(data['id'].toString());

      var catBooks = data['books'];

      books = [];
      parentCategory = BookCategoriesModel(data["parent"]);
      for (int i = 0; i < catBooks.length; i++) {
        books.add(BookModel(catBooks[i]));
      }
      print('done');
    }
  }

  String categoryName;
  int categoryId;

  List<BookModel> books;
  BookCategoriesModel parentCategory;
}
