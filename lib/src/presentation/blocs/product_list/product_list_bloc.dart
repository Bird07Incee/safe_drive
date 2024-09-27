import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/helpers/product_data_helper.dart';
import 'package:marketplace_line_oa/src/presentation/shared/general_dialog.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';

import '../../../model/product_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({required this.utilityRepository}) : super(const ProductListState()) {
    on<GetProductList>(_onGetProductList);
    on<GetProductListByCategory>(_onGetProductListByCategory);
    on<GetProductListByPage>(_onGetProductListByPage);
    on<SetScrollPosition>(_onSetScrollPosition);
    on<SetSelectTabIndex>(_onSetSelectTabIndex);
  }
  final DioUtilityRepository utilityRepository;

  Future<ProductList> _getProductWithNoCategory() async {
    try {
      final baseUrl = Environment().getValue("BFF_BASE_URL");
      final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
      Map<String, dynamic> params = {};
      Response response = await utilityRepository.getByURL("$baseUrl$inventoryApiPath/ecommerce/v1/products", params);
      final productList = ProductList.fromJson(response.data);
      ProductDataHelper().clear();
      ProductDataHelper().addProduct(productList.products);
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  _onGetProductList(GetProductList event, Emitter<ProductListState> emit) async {
    emit(state.copyWith(productListStatus: GetProductListStatus.loading));

    try {
      ProductList productList = await _getProductWithNoCategory();

      // MaintenanceHelper().saveMaintenanceDataToLocalStorage(productList.serviceMA!);

      emit(state.copyWith(productList: productList, productListStatus: GetProductListStatus.success));
    } on DioException catch (e) {
      if (e.response?.statusCode == 503) {
        emit(state.copyWith(productListStatus: GetProductListStatus.maintenance));
      }
    } catch (e) {
      // debugPrint('re-load product list after refresh token');
      try {
        ProductList productList = await _getProductWithNoCategory();

        emit(state.copyWith(productList: productList, productListStatus: GetProductListStatus.success));
      } on DioException catch (e) {
        if (e.response?.statusCode == 503) {
          emit(state.copyWith(productListStatus: GetProductListStatus.maintenance));
        }
      } catch (e) {
        emit(state.copyWith(productListStatus: GetProductListStatus.error));
      }
    }
  }

  _onGetProductListByCategory(GetProductListByCategory event, Emitter<ProductListState> emit) async {
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
    // final nav = Navigator.of(event.context);
    // final Function func = GeneralDialog().showLoadingDialog(context: event.context);
    Map<String, dynamic> category = {};

    if (event.categoryId.isNotEmpty) {
      category = {"categoryId": event.categoryId};
    }

    if (event.bypassContext == false) {
      // ignore: use_build_context_synchronously
      GeneralDialog().showLoadingDialog(context: event.context);
    }

    try {
      Response response = await utilityRepository.getByURL("$baseUrl$inventoryApiPath/ecommerce/v1/products", category);

      final productList = ProductList.fromJson(response.data);
      ProductDataHelper().clear();
      ProductDataHelper().addProduct(productList.products);
      emit(state.copyWith(productList: productList, productListStatus: GetProductListStatus.success));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 503) {
        emit(state.copyWith(productListStatus: GetProductListStatus.maintenance));
      }
    } catch (e) {
      // debugPrint(e.toString());
      emit(state.copyWith(productListStatus: GetProductListStatus.error));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    }
  }

  _onGetProductListByPage(GetProductListByPage event, Emitter<ProductListState> emit) async {
    final baseUrl = Environment().getValue("BFF_BASE_URL");
    final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
    // final Function func = GeneralDialog().showLoadingDialog(context: event.context);
    // final nav = Navigator.of(event.context);
    var params = {"page": event.page.toString(), "itemPersPage": 10};

    if (event.categoryId.isNotEmpty) {
      params["categoryId"] = event.categoryId;
    }

    if (event.bypassContext == false) {
      // ignore: use_build_context_synchronously
      GeneralDialog().showLoadingDialog(context: event.context);
    }

    try {
      Response response = await utilityRepository.getByURL("$baseUrl$inventoryApiPath/ecommerce/v1/products", params);

      var currentProductList = ProductList.fromJson(response.data);

      ProductList nextProduct = ProductList(
          productAllItems: currentProductList.productAllItems,
          productPage: currentProductList.productPage,
          productCountItems: currentProductList.productCountItems,
          banner: currentProductList.banner,
          category: currentProductList.category,
          products: currentProductList.products);

      ProductDataHelper().addProduct(currentProductList.products);

      emit(state.copyWith(productList: nextProduct, productListStatus: GetProductListStatus.success));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 503) {
        emit(state.copyWith(productListStatus: GetProductListStatus.maintenance));
      }
    } catch (e) {
      // debugPrint(e.toString());
      emit(state.copyWith(productListStatus: GetProductListStatus.error));

      if (event.bypassContext == false) {
        // ignore: use_build_context_synchronously
        Navigator.pop(event.context);
      }
    }
  }

  _onSetScrollPosition(SetScrollPosition event, Emitter<ProductListState> emit) {
    emit(state.copyWith(scrollPosition: event.scrollPosition));
  }

  _onSetSelectTabIndex(SetSelectTabIndex event, Emitter<ProductListState> emit) {
    emit(state.copyWith(selectedTabIndex: event.selectedTabIndex));
  }
}
