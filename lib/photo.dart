

import 'dart:convert';

import 'package:http/http.dart' as http;


class Photo {

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  // ignore: non_constant_identifier_names
  factory Photo.fromJson(Map<String, dynamic> json) {
  return Photo (

  albumId: json['albumId'],
  id: json['id'],
  title: json['title'],
  url: json['url'],
  thumbnailUrl: json['thumbnailUrl']



  );
  }

  Future<Photo> fetchPhoto() async  {
    final response = await http.get('https://jsonplaceholder.typicode.com/photos');
    print(response);

    if (response.statusCode == 200) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}