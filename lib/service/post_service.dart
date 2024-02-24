import 'dart:io';

import 'package:dio/dio.dart';
import 'package:servicerequestapp/service/post_model.dart';

abstract class IPostService {
  Future<List<PostModel>?> getItems();
  Future<List<PostModel>?> getItemWithID(int id);
}

class postService implements IPostService {
  late final Dio _networkManager;
  postService()
      : _networkManager =
            Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com/'));

  @override
  Future<List<PostModel>?> getItems() async {
    try {
      final response = await _networkManager.get(_Products.products.name);

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        if (_datas is List) {
          return _datas.map((e) => PostModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<PostModel>?> getItemWithID(int id) async {
    try {
      final response = await _networkManager.get(
        '${_Products.products.name}/${id}', //Burada bağlantı şekline göre ayarlamamız lazım. Konu anlatımında query parameters vadı fakat bunda yok
      );

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;

        return [
          PostModel.fromJson(_datas)
        ]; //Not! Gelen veri liste şeklinde değilde dizi şeklinde geldiği için bu şekilde kullandık
      }
    } catch (e) {
      print(e);
    }
  }
}

enum _Products { products }

enum _ProductWithId { id }
