
import 'dart:ui';

class ApartmentDashboard {
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

  ApartmentDashboard({
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
  factory ApartmentDashboard.fromJSON(Map<String, dynamic> parsedJson) {
    return ApartmentDashboard(
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


//
// import 'dart:ui';
//
// class ApartmentDashboard {
//   int id;
//   String address;
//   String city;
//   String country;
//   int guest;
//   int bedroom;
//   int bathroom;
//   int price;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int userId;
//   dynamic name;
//   String propertyTypeId;
//   List<Booking> bookings;
//
//   ApartmentDashboard({
//     required this.id,
//     required this.address,
//     required this.city,
//     required this.country,
//     required this.guest,
//     required this.bedroom,
//     required this.bathroom,
//     required this.price,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.userId,
//     required this.name,
//     required this.propertyTypeId,
//     required this.bookings,
//   });
//
//
//   factory ApartmentDashboard.fromJSON(Map<String, dynamic> parsedJson) {
//     return ApartmentDashboard(
// //id: parsedJson['id'],
// //name: parsedJson['name'],
//       address: parsedJson['address'],
//       city: parsedJson['city'],
//       country: parsedJson['country'],
// // guest: parsedJson['guest'],
// // bedroom: parsedJson['bedroom'],
// // bathroom: parsedJson['bathroom'],
// // price: parsedJson['price'],
// // propertyTypeId: parsedJson['propertyTypeId'],
// // status: parsedJson['status'],
// // userId: parsedJson['userId'],
// // createdDate: parsedJson['createdDate'],
// // updatedDate: parsedJson['updatedDate'],
// // pictures: parsedJson['pictures']
// //address: Address.fromJSON(parsedJson['address']),
// //company: Company.fromJSON(parsedJson['company']),
//     );
//   }
// }
class Booking {
  int id;
  //DateTime date;
  DateTime startDate;
  DateTime endDate;
  //String reference;
   String status;
  // DateTime createdAt;
  // DateTime updatedAt;
  // int userId;
  //Pivot pivot;

  Booking({
    required this.id,
    //required this.date,
    required this.startDate,
    required this.endDate,
    //required this.reference,
    required this.status,
    //required this.createdAt,
    //required this.updatedAt,
    //required this.userId,
    //required this.pivot,
  });

  factory Booking.fromJSON(Map<String, dynamic> parsedJson) {
    return Booking(
      id: parsedJson['id'],
      //name: parsedJson['name'],
      startDate: parsedJson['start_date'],
      endDate: parsedJson['end_date'],
      status: parsedJson['status'],
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

class Pivot {
  // int bookableId;
  // int bookingId;
  // String bookableType;
  int id;
  DateTime startDate;
  DateTime endDate;
  //int price;
  String status;
  //DateTime createdAt;
  //DateTime updatedAt;

  Pivot({
    // required this.bookableId,
    // required this.bookingId,
    // required this.bookableType,
    required this.id,
    required this.startDate,
    required this.endDate,
    //required this.price,
    required this.status,
    //required this.createdAt,
    //required this.updatedAt,
  });

  factory Pivot.fromJSON(Map<String, dynamic> parsedJson) {
    return Pivot(
      id: parsedJson['id'],
      //name: parsedJson['name'],
      startDate: parsedJson['start_date'],
      endDate: parsedJson['end_date'],
      status: parsedJson['status'],
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
