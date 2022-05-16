import 'dart:convert';
class dataget{
  int id;
  String name;
  double Latitude;
  double Longitude;
  String thumbnailUrl;

  dataget({this.id, this.name, this.Latitude, this.Longitude, this.thumbnailUrl});

static dataget fromJson(json)=> dataget(
  id: json['id'],
    name: json['name'],
    Latitude: json['Latitude'],
      Longitude: json['Longitude'],
      thumbnailUrl: json['thumbnailUrl']

);



}