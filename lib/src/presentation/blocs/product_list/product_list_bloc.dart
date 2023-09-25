import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    on<SetSelectTabIndex>(_onSetSelectTabIndex);
  }

  _onGetProductListMock(GetProductListMock event, Emitter<ProductListState> emit) async {
    await DefaultAssetBundle.of(event.context).loadString('assets/mocking/json/product_list.json').then((value) {
      final jsonObj = json.decode(value);
      final productList = ProductList.fromJson(jsonObj);
      emit(state.copyWith(productList: productList));
    });
  }

  _onSetSelectTabIndex(SetSelectTabIndex event, Emitter<ProductListState> emit) {
    emit(state.copyWith(selectedTabIndex: event.selectedTabIndex));
  }

  _onGetProductList(GetProductList event, Emitter<ProductListState> emit) async {
    DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    String accessToken = lineDataHelper.getLineAccessToken();

    // const accessToken =
    //     "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQEUk3/Zj+oXruNIaluHKaLyAAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAwU35iBDNidEe3In6YCARCAggEHapD+3ohNbUyQshpMkrgAsg7klkyxCW1ZYFmwUNtr6IDuetQ3c0/yChhINiYRAPMloZ7aY2abHIkS3xVUblaznTUy+fbw6KcPON19rABqciIzDj9fB8Dxog+BdYbsjc0zOA2Aw/rAA7cI9Lyn22YNZTb51wXFINYI/tTyGxgPPMXukDkHQvo0H4asAvTka6FXjldV8t/W365W53PUD5Wy1KedP3XZ8rWeBRYfs7gO42ixVhjQbLS/1o1VfN61wvdRpkQO1ba2afeV86L6qDihXg9xoNzBvHcKcobmTY+NvT3LjMPc2lHYIO5CfgC3CEDAnNiPxobENBR5SpLZNrxQ10lDkY8ZqFk=";

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
