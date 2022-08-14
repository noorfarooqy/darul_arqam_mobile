import 'package:darularqam/models/SheekhModel.dart';

class SermonModel {
  SermonModel(data) {
    if (data != null) {
      sermonId = int.parse(data["id"].toString());
      sheekhId = int.parse(data["sheekh_id"].toString());
      sermonTitle = data["sermon_title"];
      sermonLocation = data["sermon_location"];
      sermonCreatedAt = data["created_at"];
      sermonUpdatedAt = data["updated_at"];
      sermonFileSize =
          (double.parse(data["sermon_file_size"].toString()) / 1000000);
      sermonFileUrl = data["sermon_file_url"];

      sheekhInfo = SheekhModel(data["sheekh_info"]);
    }
  }
  int sermonId;
  int sheekhId;
  double sermonFileSize;

  String sermonTitle;
  String sermonLocation;
  String sermonCreatedAt;
  String sermonUpdatedAt;
  String sermonFileUrl;

  SheekhModel sheekhInfo;
}
