import 'package:darularqam/models/SheekhModel.dart';

class BookModel {

  BookModel(data){
    if(data != null){
      bookId = data["id"];
      sheekhId = data["sheekh_id"];
      bookName = data["book_name"];
      bookWrittenBy = data["book_written_by"];
      bookDescription = data["book_description"];
      bookNumPages = data["book_num_pages"];
      bookPublishDate = data["book_push_date"] ?? '';
      bookOnGoing = data["book_is_ongoing"] == 1;
      bookCreatedAt = data["created_at"];
      bookUpdatedAt = data["updated_at"];
      bookIcon = data["book_icon"];
      lessonCount = data["lesson_count"];

      sheekhInfo = data["sheekh_info"] != null ? SheekhModel(data["sheekh_info"]) : null;
    }

  }

  int bookId;
  int sheekhId;
  int lessonCount;
  String bookName;
  String bookWrittenBy;
  String bookDescription;
  String bookNumPages;
  String bookPublishDate;
  String bookCreatedAt;
  String bookUpdatedAt;
  String bookIcon;

  SheekhModel sheekhInfo;

  bool bookOnGoing;
}