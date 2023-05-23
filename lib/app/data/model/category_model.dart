// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sub_category_model.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@unfreezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel(
      {required int id,
      required int? incidentsCount,
      required int? subCategoryCount,
      required String? arabicName,
      required String? englishName,
      required String? icon,
      required int? order,
      required String? color,
      @JsonKey(name: 'subCategoryList')
          required List<SubCategoryModel>? subCategories}) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
