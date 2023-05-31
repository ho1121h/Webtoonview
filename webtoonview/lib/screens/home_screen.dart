import 'package:flutter/material.dart';
import 'package:webtoonview/models/webtoon_model.dart';
import 'package:webtoonview/services/api_service.dart';
import 'package:webtoonview/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons =
      ApiService.getTodaysToons(); //api로 오는값이라 미리알수없는내용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        // State ful 을 안써도됨 즉 8번라인 값을 기다려준다.
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // snapshot 에 데이터가 존재
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                    child:
                        makeList(snapshot)) //Expanded 에 listview넣으면 남은공간을 채워줌
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal, //수평
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      // children: [
      //   for (var webtoon in snapshot.data!) Text(webtoon.title)
      // ],
    );
  }
}
