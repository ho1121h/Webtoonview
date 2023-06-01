import 'dart:convert';

import 'package:http/http.dart' as http; // dev dart
import 'package:webtoonview/models/webtoon_detail_model.dart';
import 'package:webtoonview/models/webtoon_episode_model.dart';
import 'package:webtoonview/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    // Future : 미래에 도달함
    List<WebtoonModel> webtoonInstances = [];
    // request | 비동기로 설정
    final url = Uri.parse("$baseUrl/$today");

    final response = await http.get(url); // 데이터가 도착할때까지 기다림
    if (response.statusCode == 200) {
      final webtoons =
          jsonDecode(response.body); // 어떤 타입이든 수용가능함 리스트를 존슨으로 받아오기
      for (var webtoon in webtoons) {
        // 리스트가 생성되었기에 반복문 가능
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatesEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
