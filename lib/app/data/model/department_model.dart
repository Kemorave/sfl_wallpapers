import 'package:freezed_annotation/freezed_annotation.dart';

part 'department_model.freezed.dart';
part 'department_model.g.dart';

@unfreezed
class DepartmentModel with _$DepartmentModel {
  factory DepartmentModel(
      {required String? typeArabicName,
      required String? typeEnglishName,
      required String? baladiaArabicName,
      required String? baladiaEnglishName,
      required int id,
      required String? arabicName,
      required String? englishName,
      required int? departmentTypeId,
      required String? baladiaId,
      int? refId}) = _DepartmentModel;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);
}
