import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_category_model.freezed.dart';
part 'sub_category_model.g.dart';

@unfreezed
class SubCategoryModel with _$SubCategoryModel {
  factory SubCategoryModel(
      {required int id,
      int? incidentsCount,
      int? categoryId,
      String? icon,
      required int amountUnitId,
      String? amountUnitArabicName,
      String? amountUnitEnglishName,
      String? categoryArabicName,
      String? categoryEnglishName,
      String? arabicName,
      String? englishName,
      required int mainCategoryId,
      required int order,
      String? color,
      String? file,
      bool? show}) = _SubCategoryModel;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
}
