class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(
      Map<String, dynamic>
          json) // Map 은 key, value 로 받는데 value가 뭐가올지 모르기 때문에 dynamic 으로 설정
      : title = json["title"],
        thumb = json["thumb"],
        id = json["id"];
}
