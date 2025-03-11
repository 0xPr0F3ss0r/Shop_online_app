import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? firstName;
  final String? secondName;
  final String? email;
  final String? phone;
  final String? website;
  final String? location;
  final String? avatar;
  final int? followers;
  final String? type;
  final String? productImage;
  final String? productBrand;
  final String? productType;
  final String? productSize; 
  final String? prouctPrice;
  final String? productBrandColor;
  final Map<String, dynamic>? isFollow;
  final String? liveID;
  final String? hostID;
  final bool? isLive;
  final String? title;
  final String? timestamp;
  UserModel({
    this.productImage,
    this.type,
    this.fullName,
    this.email,
    this.phone,
    this.website,
    this.location,
    this.firstName,
    this.secondName,
    this.avatar,
    this.followers,
    this.productBrand,
    this.productSize,
    this.productType,
    this.productBrandColor,
    this.isFollow,
    this.hostID,
    this.isLive,
    this.liveID,
    this.timestamp,
    this.title,
    this.prouctPrice
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;;
    return UserModel(
      fullName: data['FullName'] ?? '', 
      firstName: data['FirstName'] ?? '',
      secondName: data['secondName']?? '',
      email: data['Email'] ?? '',       
      phone: data['Phone'] ?? '',       
      website: data['Website'] ?? '',   
      location: data['Location'] ?? '',
      avatar: data['avatar'], 
      followers: data['followers'],
      type: data['type of user'],
      productImage: data['Product Image'],
      productBrand: data['Product Brand'],
      productSize: data['Product Size'],
      productType: data['Product Type'],
      productBrandColor: data['Product Color'],
      isFollow: data['isFollow'],
      hostID: data['hostID'],
      isLive: data['isLive'],
      liveID: data['liveID'],
      timestamp: data['timestamp'],
      title: data['title'],
      prouctPrice: data['prouctPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "FirstName": firstName,
      "secondName": secondName,
      "Email": email,
      "Phone": phone,
      "Website": website,
      "Location": location,
      "avatar":avatar,
      "followers":followers,
      "type":type,
      "Product Image":productImage,
      "Product Brand":productBrand,
      "Product Size":productSize,
      "Product Type":productType,
      "Product Color":productBrandColor,
      "isFollow":isFollow,
      "hostID":hostID,
      "liveID":liveID,
      "isLive":isLive,
      "title":title,
      "timestamp":timestamp,
      "prouctPrice":prouctPrice,
    };
  }
}
