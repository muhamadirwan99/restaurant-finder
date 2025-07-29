import 'dart:convert';

import 'package:base/models/detail_restaurant_model.dart';
import 'package:base/models/list_restaurant_model.dart';
import 'package:base/models/review_restaurant_model.dart';
import 'package:base/models/search_restaurant_model.dart';
import 'package:core/core.dart';

class ApiServiceBase {
  DioClient client = DioClient();
  CancelToken cancelToken = CancelToken();

  void resetCancelToken() {
    cancelToken = CancelToken();
  }

  Future<ListRestaurantModel> listRestaurant() async {
    try {
      final response = await client.apiCall(
        url: Endpoints.list,
        requestType: RequestType.get,
      );

      if (response.statusCode == 200) {
        if (!response.data["error"]) {
          return ListRestaurantModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get listRestaurant");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<DetailRestaurantModel> detailRestaurant({
    required String id,
  }) async {
    try {
      final response = await client.apiCall(
        url: "${Endpoints.detail}/$id",
        requestType: RequestType.get,
      );

      if (response.statusCode == 200) {
        if (!response.data["error"]) {
          return DetailRestaurantModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get detailRestaurant");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<SearchRestaurantModel> searchRestaurant({
    required String query,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.search,
        requestType: RequestType.get,
        queryParameters: {
          "q": query,
        },
      );

      if (response.statusCode == 200) {
        if (!response.data["error"]) {
          return SearchRestaurantModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get searchRestaurant");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }

  Future<ReviewRestaurantModel> reviewRestaurant({
    required String id,
    required String name,
    required String review,
  }) async {
    try {
      final response = await client.apiCall(
        url: Endpoints.review,
        requestType: RequestType.post,
        body: {
          "id": id,
          "name": name,
          "review": review,
        },
      );

      if (response.statusCode == 200) {
        if (!response.data["error"]) {
          return ReviewRestaurantModel.fromJson(json.decode(response.toString()));
        } else {
          throw CustomExceptionDio(response.data["message"]);
        }
      } else {
        throw CustomExceptionDio("Failed to get reviewRestaurant");
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomExceptionDio(
            "Tidak mendapatkan respon dari server setelah ${Endpoints.connectionTimeout.inSeconds} detik");
      }
      throw CustomExceptionDio("Server Exception ${e.message}");
    }
  }
}
