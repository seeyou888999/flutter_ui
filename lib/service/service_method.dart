import 'package:dio/dio.dart';
import 'package:flutter_ui/common/service_url.dart';
import 'dart:async';

// 获取数据
Future get(url,{formData}) async {
  try {
    String contextUrl = servicePath[url] + formData.toString();
    Response response;
    Dio dio = new Dio();
    response = await dio.get(contextUrl);
    return response;
  } catch (e) {
    print('ERROR 如下');
    return  print(e);
  }
}