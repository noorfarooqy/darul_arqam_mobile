

class SheekhModel {

  SheekhModel(data){
    sheekhId = data["id"];
    sheekhName = data["sheekh_name"];
    sheekhLocation = data["sheekh_current_country"];
    sheekhEmail = data["sheekh_email"];
    sheekhCreatedAt = data["created_at"];
    sheekhUpdatedAt  = data["updated_at"];
    sheekhIcon = data["sheekh_icon"];
    bookCount = data["book_count"] ?? 0;
    lessonCount = data["lesson_count"];

  }
  int sheekhId;
  int bookCount;
  int lessonCount;
  String sheekhName;
  String sheekhEmail;
  String sheekhLocation;
  String sheekhCreatedAt;
  String sheekhUpdatedAt;
  String sheekhIcon;

}