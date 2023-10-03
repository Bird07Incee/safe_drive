import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/line_data_helper.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:marketplace_line_oa/src/services/dio_utility_services.dart';

import '../../../model/product_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState()) {
    on<GetProductListMock>(_onGetProductListMock);
    on<GetProductList>(_onGetProductList);
    on<GetProductListByCategory>(_onGetProductListByCategory);
    on<GetProductListByPage>(_onGetProductListByPage);
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
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = lineDataHelper.getLineAccessToken();

    // const accessToken =
    //     "AQICAHiHh8UolZwiInbRGrYIc4hBqU2lEtG0b/SgxcDfwKyzuQEUk3/Zj+oXruNIaluHKaLyAAABVDCCAVAGCSqGSIb3DQEHBqCCAUEwggE9AgEAMIIBNgYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAwU35iBDNidEe3In6YCARCAggEHapD+3ohNbUyQshpMkrgAsg7klkyxCW1ZYFmwUNtr6IDuetQ3c0/yChhINiYRAPMloZ7aY2abHIkS3xVUblaznTUy+fbw6KcPON19rABqciIzDj9fB8Dxog+BdYbsjc0zOA2Aw/rAA7cI9Lyn22YNZTb51wXFINYI/tTyGxgPPMXukDkHQvo0H4asAvTka6FXjldV8t/W365W53PUD5Wy1KedP3XZ8rWeBRYfs7gO42ixVhjQbLS/1o1VfN61wvdRpkQO1ba2afeV86L6qDihXg9xoNzBvHcKcobmTY+NvT3LjMPc2lHYIO5CfgC3CEDAnNiPxobENBR5SpLZNrxQ10lDkY8ZqFk=";

    emit(state.copyWith(productListStatus: GetProductListStatus.loading));

    try {
      // Response response = await dioUtilityRepository.postByURL("$baseUrl$inventoryApiPath/ecommerce/v1/products", {},
      //     headers: {"Authorization": "Bearer $accessToken"});

      final productList = ProductList.fromJson(mockProductResponse);
      emit(state.copyWith(productList: productList, productListStatus: GetProductListStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(productListStatus: GetProductListStatus.error));
    }
  }

  _onGetProductListByCategory(GetProductListByCategory event, Emitter<ProductListState> emit) async {
    DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = lineDataHelper.getLineAccessToken();
    var category = {};

    if (event.categoryId.isNotEmpty) {
      category = {"categoryId": event.categoryId};
    }

    GeneralDialog().showLoadingDialog(context: event.context);

    try {
      Response response = await dioUtilityRepository.getByURL(
          "$baseUrl$inventoryApiPath/ecommerce/v1/products", category,
          headers: {"Authorization": "Bearer $accessToken"});

      final productList = ProductList.fromJson(response.data);
      emit(state.copyWith(productList: productList, productListStatus: GetProductListStatus.success));

      if (!event.context.mounted) return;
      Navigator.of(event.context).pop();
    } catch (e) {
      print(e);
      emit(state.copyWith(productListStatus: GetProductListStatus.error));

      if (!event.context.mounted) return;
      Navigator.of(event.context).pop();
    }
  }

  _onGetProductListByPage(GetProductListByPage event, Emitter<ProductListState> emit) async {
    DioUtilityRepository dioUtilityRepository = DioUtilityRepository(service: DioUtilityService());
    LineDataHelper lineDataHelper = LineDataHelper();
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_INVENTORY_BASE_URL");
    String accessToken = lineDataHelper.getLineAccessToken();
    var params = {"page": event.page.toString(), "itemPersPage": 10};

    if (event.categoryId.isNotEmpty) {
      params["categoryId"] = event.categoryId;
    }

    GeneralDialog().showLoadingDialog(context: event.context);

    try {
      Response response = await dioUtilityRepository.getByURL("$baseUrl$inventoryApiPath/ecommerce/v1/products", params,
          headers: {"Authorization": "Bearer $accessToken"});

      var currentProductList = ProductList.fromJson(response.data);
      var oldProducts = state.productList.products;

      ProductList nextProduct = ProductList(
          productAllItems: currentProductList.productAllItems,
          productPage: currentProductList.productPage,
          productCountItems: currentProductList.productCountItems,
          banner: currentProductList.banner,
          category: currentProductList.category,
          products: oldProducts! + currentProductList.products!);

      emit(state.copyWith(productList: nextProduct, productListStatus: GetProductListStatus.success));

      if (!event.context.mounted) return;
      Navigator.of(event.context).pop();
    } catch (e) {
      print(e);
      emit(state.copyWith(productListStatus: GetProductListStatus.error));

      if (!event.context.mounted) return;
      Navigator.of(event.context).pop();
    }
  }
}
