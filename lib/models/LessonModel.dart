

import 'package:darularqam/models/BookModel.dart';
import 'package:darularqam/models/SheekhModel.dart';

class LessonModel {

  LessonModel(data){
    lessonId = data["id"];
    bookId = data["book_id"];
    sheekhId = data["sheekh_id"];
    lessonTitle = data["lesson_title"];
    lessonHidden = data["lesson_hidden"] == 1;
    lessonNumber = data["lesson_number"];
    lessonCreatedAt = data["created_at"];
    lessonUpdatedAt = data["updated_at"];
    lessonAudioUrl = data["lesson_audio_url"];
    lessonFileSize = (data["file_size"] / 1000000);
    sheekhInfo = SheekhModel(data["sheekh_info"]);
    bookInfo = BookModel(data["book_info"]);
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