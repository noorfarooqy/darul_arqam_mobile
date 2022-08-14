class SheekhModel {
  SheekhModel(data) {
    sheekhId = int.parse(data["id"].toString());
    sheekhName = data["sheekh_name"];
    sheekhLocation = data["sheekh_current_country"];
    sheekhEmail = data["sheekh_email"];
    sheekhCreatedAt = data["created_at"];
    sheekhUpdatedAt = data["updated_at"];
    sheekhIcon = data["sheekh_icon"];
    bookCount = data['book_count'] != null
        ? int.parse(data["book_count"].toString())
        : 0;
    lessonCount = data['lesson_count'] != null
        ? int.parse(data["lesson_count"].toString())
        : 0;
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
