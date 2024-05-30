import 'dart:ui';

class Apart {
  //int id;
  //String name;
   String address;
   String city;
   String country;
  Apart({
     required this.address,
     required this.city,
    required this.country,
  });
  factory Apart.fromJSON(Map<String, dynamic> parsedJson) {
    return Apart(
      //id: parsedJson['id'],
      //name: parsedJson['name'],
       address: parsedJson['address'],
       city: parsedJson['city'],
       country: parsedJson['country'],
    );
  }
}
class Picture {
  String imageName;
  String imageUrl;
  Picture({
    required this.imageName,
    required this.imageUrl,
  });

  factory Picture.fromJSON(Map<String, dynamic> parsedJson) {
    return Picture(
        //id: parsedJson['id'],
        imageName: parsedJson['imageName'],
      imageUrl: parsedJson['imageUrl'],
    );
  }
}