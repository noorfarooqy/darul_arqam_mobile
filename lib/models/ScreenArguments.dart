import 'package:darularqam/models/BookCategoriesModel.dart';
import 'package:darularqam/models/SheekhModel.dart';

class BookCategoryScreenArgument {
  BookCategoryScreenArgument({this.categoriesModel, this.sheekhModel});
  SheekhModel sheekhModel;
  BookCategoriesModel categoriesModel;
}
