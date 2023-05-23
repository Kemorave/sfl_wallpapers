import 'package:freezed_annotation/freezed_annotation.dart';

import 'department_model.dart';

part 'baladia_model.freezed.dart';
part 'baladia_model.g.dart';

@unfreezed
class BaladiaModel with _$BaladiaModel {
  factory BaladiaModel({
    required String id,
    required String? typeArabicName,
    required String? typeEnglishName,
    required List<DepartmentModel>? departments,
    required String? arabicName,
    required String? englishName,
    required String baladiaTypeId,
  }) = _BaladiaModel;

  factory BaladiaModel.fromJson(Map<String, dynamic> json) =>
      _$BaladiaModelFromJson(json);
}
