import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

import '../../../model/product_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState()) {
    on<GetProductListMock>(_onGetProductListMock);
    on<GetProductList>(_onGetProductList);
  }

  _onGetProductListMock(GetProductListMock event, Emitter<ProductListState> emit) async {
    await DefaultAssetBundle.of(event.context).loadString('assets/mocking/json/product_list.json').then((value) {
      final jsonObj = json.decode(value);
      final productList = ProductList.fromJson(jsonObj);
      emit(state.copyWith(productList: productList));
    });
  }

  _onGetProductList(GetProductList event, Emitter<ProductListState> emit) async {
    DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    // String accessToken = lineDataHelper.getLineAccessToken();

    const accessToken =
        "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQGmaDMj/8jftIGfyzlOMMWFAAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAwIyu3eQQ+ACLbmVHMCARCAggEHWnsxA2DpFQ06lORq5gfJ36nrt9McefuMuyhzK9DCT7g/y6vVagEfQv9e7y9vZ0AOT7P0VeppfxK7naxfSOR3EieFegM44IAYkqokSBXZmoOW1nx7dQRB4oLKyJZQW/u8V682aAQ+bBnQXJozKWSst95sTTijYKRed1wAlzXrVSySEQVK0diMN/K9bNPcBF0RI0uVRyCWVGdNChK3Qnb1rN1yNvoou6DdkN9GfFAjuixxxTGupmM8+Fch9PJCO4Wykt7wYe5SW66im+tHaGL+V6MIIVKTYgnRNB7DBRqEiesvG7K87uPBj1IM8xlw7RMWrGczEWc4ZN4/NG+o1UuuWMayrb47poU=";

    emit(state.copyWith(productListStatus: GetProductListStatus.loading));

    try {
      Response response = await dioUtilityRepository.postByURL(
          "$baseUrl/mercury-inventory-manager-dev/ecommerce/v1/products", {},
          headers: {"Authorization": "Bearer $accessToken"});

      final productList = ProductList.fromJson(response.data);
      emit(state.copyWith(productList: productList, productListStatus: GetProductListStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(productListStatus: GetProductListStatus.error));
    }
  }
}
