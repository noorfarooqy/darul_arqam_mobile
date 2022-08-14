import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/SheekhModel.dart';

class LessonModel {
  LessonModel(data) {
    lessonId = int.parse(data["id"].toString());
    bookId = int.parse(data["book_id"].toString());
    sheekhId = int.parse(data["sheekh_id"].toString());
    lessonTitle = data["lesson_title"];
    lessonHidden = data["lesson_hidden"] == 1;
    lessonNumber = int.parse(data["lesson_number"].toString());

    lessonCreatedAt = data["created_at"];
    lessonUpdatedAt = data["updated_at"];
    lessonAudioUrl = data["lesson_audio_url"];
    lessonFileSize = (double.parse(data["file_size"].toString()) / 1000000);
    sheekhInfo = SheekhModel(data["sheekh_info"]);
    if (data["book_info"].runtimeType == BookModel)
      bookInfo = data["book_info"];
    else
      bookInfo = BookModel(data["book_info"]) ?? null;
  }
  int lessonId;
  int bookId;
  int sheekhId;
  int lessonNumber;

  String lessonTitle;
  String lessonCreatedAt;
  String lessonUpdatedAt;
  String lessonAudioUrl;
  double lessonFileSize;

  bool lessonHidden;

  SheekhModel sheekhInfo;
  BookModel bookInfo;
}
