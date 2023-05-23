import 'package:sfl/app/core/extentions/responce_extension.dart';
import 'package:sfl/app/data/model/category_model.dart';
import 'package:sfl/app/data/repositories/api_http_client.dart';
import 'package:sfl/app/data/repositories/base/i_disposible_repository.dart';
import 'package:sfl/app/data/repositories/base/i_http_client.dart';
import 'package:flutter/foundation.dart';

import '../../core/action_result.dart';
import '../cache/cache_helper.dart';
import '../model/sub_category_model.dart';
import '../network/server_responce.dart';
import 'package:cached_annotation/cached_annotation.dart';
part 'category_repository.cached.dart';

@WithCache()
abstract class CategoryRepository implements IDisposibleRepository {
  factory CategoryRepository() = _CategoryRepository;
  @override
  late IHttpClient client = ApiHttpClient();

  @override
  void dispose() {
    client.dispose();
  }

  @Cached(
    persistentStorage: true,
    syncWrite: true,
    ttl: 600,
    where: asyncShouldCache,
  )
  Future<Map<String, dynamic>?> getCategories(
      {@ignoreCache bool ignoreCache = false}) async {
    var res = await client.get("IncidentCategories");
    res.ensureSuccess();
    return res.body;
  }

  Future<ActionResult<List<SubCategoryModel>>> getSubCategories(
      int? categoryId) async {
    var res = await client.get("IncidentSubCategories/?categoryId=$categoryId");

    res.ensureSuccess();
    return ActionResult(
        responce: res,
        result: await compute(deserializeSubCategoryModels,
            (ServerResponce.fromJson(res.body).data as List<dynamic>)));
  }

  static List<SubCategoryModel> deserializeSubCategoryModels(
      List<dynamic> list) {
    return list
        .map<SubCategoryModel>((e) => SubCategoryModel.fromJson(e))
        .toList();
  }

  static List<CategoryModel> deserializeModels(List<dynamic> list) {
    return list.map<CategoryModel>((e) => CategoryModel.fromJson(e)).toList();
  }
}
