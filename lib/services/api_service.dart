import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../config.dart';
import '../model/product_model.dart';

class APIService {
  static var client = http.Client();

  static Future<List<ProductModel>?> getall() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.annoncesAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return productsFromJson(data["data"]);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> create(
      ProductModel   model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var productURL = Config.createAPI;

    if (isEditMode) {
      productURL = productURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["title"] = model.title!;
    request.fields["prix"] = model.prix!.toString();

    if (model.image != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'image',
        model.image!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> del(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.deleteAPI + "/" + productId,
    );

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
