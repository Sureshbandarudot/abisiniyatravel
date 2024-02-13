import 'dart:ui';

class Apart {
  //int id;
  //String name;
   String address;
   String city;
   String country;
  // int guest;
  // int bedroom;
  // int bathroom;
  // int price;
  // String propertyTypeId;
  // String status;
  // int userId;
  // DateTime createdDate;
  // DateTime updatedDate;
  // List<Picture> pictures;

  Apart({
   // required this.id,
    //required this.name,
     required this.address,
     required this.city,
    required this.country,
    // required this.guest,
    // required this.bedroom,
    // required this.bathroom,
    // required this.price,
    // required this.propertyTypeId,
    // required this.status,
    // required this.userId,
    // required this.createdDate,
    // required this.updatedDate,
    // required this.pictures,
  });
  factory Apart.fromJSON(Map<String, dynamic> parsedJson) {
    return Apart(
      //id: parsedJson['id'],
      //name: parsedJson['name'],
       address: parsedJson['address'],
       city: parsedJson['city'],
       country: parsedJson['country'],
      // guest: parsedJson['guest'],
      // bedroom: parsedJson['bedroom'],
      // bathroom: parsedJson['bathroom'],
      // price: parsedJson['price'],
      // propertyTypeId: parsedJson['propertyTypeId'],
      // status: parsedJson['status'],
      // userId: parsedJson['userId'],
      // createdDate: parsedJson['createdDate'],
      // updatedDate: parsedJson['updatedDate'],
      // pictures: parsedJson['pictures']
      //address: Address.fromJSON(parsedJson['address']),
      //company: Company.fromJSON(parsedJson['company']),
    );
  }

}

class Picture {
  // int id;
  // String pictureType;
  // int apartmentId;
  String imageName;
  String imageUrl;

  Picture({
    //required this.id,
    //required this.pictureType,
    //required this.apartmentId,
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