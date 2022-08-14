import 'package:darularqam/models/SheekhModel.dart';

class BookModel {
  BookModel(data, {SheekhModel sheekhModel}) {
    if (data != null) {
      bookId = int.parse(data["id"].toString());
      sheekhId = int.parse(data["sheekh_id"].toString());
      bookName = data["book_name"];
      bookWrittenBy = data["book_written_by"];
      bookDescription = data["book_description"];
      bookNumPages = data["book_num_pages"];
      bookPublishDate = data["book_push_date"] ?? '';
      bookOnGoing = data["book_is_ongoing"] == 1;
      bookCreatedAt = data["created_at"];
      bookUpdatedAt = data["updated_at"];
      bookIcon = data["book_icon"];
      lessonCount = data['lesson_count'] != null
          ? int.parse(data["lesson_count"].toString())
          : 1;

      if (sheekhModel != null)
        sheekhInfo = sheekhModel;
      else
        sheekhInfo = data["sheekh_info"] != null
            ? SheekhModel(data["sheekh_info"])
            : null;
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
