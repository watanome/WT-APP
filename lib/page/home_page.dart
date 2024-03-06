import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _subscriberCount = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadSubscriberCount();
  }

  Future<void> _loadSubscriberCount() async {
    String channelId = 'UCWAlDdbQee8AEyY7n65ulUA'; // チャンネルのIDを入力
    String apiKey = 'AIzaSyAVWFBsPZym8Z1MO5Pgk3V4DoRnXFqSp9E'; // YouTube Data APIのAPIキーを入力

    try {
      int subscriberCount = await fetchSubscriberCount(channelId, apiKey);
      setState(() {
        _subscriberCount = subscriberCount.toString();
      });
    } catch (e) {
      setState(() {
        _subscriberCount = 'Failed to load';
      });
    }
  }

  Future<int> fetchSubscriberCount(String channelId, String apiKey) async {
    final response = await http.get(
        Uri.parse(
            'https://www.googleapis.com/youtube/v3/channels?part=statistics&id=$channelId&key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
     final subscriberCount = int.parse(data['items'][0]['statistics']['subscriberCount']);
      return subscriberCount;
    } else {
      throw Exception('Failed to load subscriber count');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 241, 247),
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset('lib/images/members.jpg'),
            ),
             Row(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.baseline,
               textBaseline: TextBaseline.alphabetic, 
               children: [
                 Text(_subscriberCount,style: TextStyle(fontSize: 64),),
                 Text('人',style: TextStyle(fontSize: 24))
               ],
             ),
             Column(
              mainAxisSize: MainAxisSize.min,
               children: [
                 const Text('登録者数',style: TextStyle(fontSize: 24),),
               ],
             ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                    Image.asset(
                      'lib/images/sharken.png',
                      width: 100,
                      height: 100,
                    ),
                    Column(
                      children: [
                        Text('Sharken'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

