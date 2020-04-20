// import 'package:flutter_architecture/features/account/domain/entities/customer.dart';
// import 'package:flutter_architecture/core/util/json_parsers/date_time.dart';
// import 'package:meta/meta.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'customer_model.g.dart';

// @Deprecated('unused model in data layer, use entity in domain layer instead')
// @JsonSerializable()
// class CustomerModel extends Customer {
//   const CustomerModel({
//     @required String id,
//     @required String name,
//     @required String email,
//     @required String accountStatus,
//     String phoneNumber,
//     String photoUrl,
//     String gender,
//     String birthPlace,
//     DateTime birthDate,
//   }) : super(
//           id: id,
//           name: name,
//           email: email,
//           accountStatus: accountStatus,
//           phoneNumber: phoneNumber,
//           photoUrl: photoUrl,
//           gender: gender,
//           birthPlace: birthPlace,
//           birthDate: birthDate,
//         );

//   factory CustomerModel.fromJson(Map<String, dynamic> json) =>
//       _$CustomerModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

//   @override
//   String toString() => toJson().toString();
// }
