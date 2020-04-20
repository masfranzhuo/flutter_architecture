// import 'package:flutter_architecture/features/account/domain/entities/staff.dart';
// import 'package:meta/meta.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'staff_model.g.dart';

// @Deprecated('unused model in data layer, use entity in domain layer instead')
// @JsonSerializable()
// class StaffModel extends Staff {
//   const StaffModel({
//     @required String id,
//     @required String name,
//     @required String email,
//     @required String accountStatus,
//     @required String role,
//     String phoneNumber,
//     String photoUrl,
//   }) : super(
//           id: id,
//           name: name,
//           email: email,
//           accountStatus: accountStatus,
//           role: role,
//           phoneNumber: phoneNumber,
//           photoUrl: photoUrl,
//         );

//   factory StaffModel.fromJson(Map<String, dynamic> json) =>
//       _$StaffModelFromJson(json);
      
//   Map<String, dynamic> toJson() => _$StaffModelToJson(this);

//   @override
//   String toString() => toJson().toString();
// }
