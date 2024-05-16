import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:autoStation_promptBuy/configs/enivironment_config.dart';
import 'package:autoStation_promptBuy/src/model/product_list.dart';
import 'package:autoStation_promptBuy/src/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:autoStation_promptBuy/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late DioUtilityRepository utilityRepository;

  group('ProductListBloc', () {
    late MockBuildContext mockBuildContext;
    // Test initial state
    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
    });
    test(
      'initial state',
      () {
        expect(
          ProductListBloc(utilityRepository: utilityRepository).state.productListStatus,
          GetProductListStatus.initial,
        );
      },
    );

    test(
      'copyWith method initial state',
      () {
        expect(
          ProductListBloc(utilityRepository: utilityRepository).state,
          ProductListBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    blocTest<ProductListBloc, ProductListState>("SelectTabIndex",
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(const SetSelectTabIndex(1)),
        expect: () => <ProductListState>[ProductListState(selectedTabIndex: 1)]);

    blocTest<ProductListBloc, ProductListState>("getProductList success",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
          String path = "/ecommerce/v1/products";
          when(() {
            return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: mockProductListResponse, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(const GetProductList()),
        expect: () => <ProductListState>[
              ProductListState(productListStatus: GetProductListStatus.loading),
              ProductListState(productListStatus: GetProductListStatus.success, productList: ProductList.fromJson(mockProductListResponse))
            ]);

    blocTest<ProductListBloc, ProductListState>("getProductList error",
        setUp: () {
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
          String path = "/ecommerce/v1/products";
          when(() {
            return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
            },
          );
        },
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(const GetProductList()),
        expect: () => <ProductListState>[
              ProductListState(productListStatus: GetProductListStatus.loading),
              ProductListState(productListStatus: GetProductListStatus.error)
            ]);

    blocTest<ProductListBloc, ProductListState>("getProductList by category",
        setUp: () {
          mockBuildContext = MockBuildContext();
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
          String path = "/ecommerce/v1/products";
          when(() {
            return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"categoryId": "1234"});
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: mockProductListResponse, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetProductListByCategory("1234", mockBuildContext, bypassContext: true)),
        expect: () => <ProductListState>[
              ProductListState(productListStatus: GetProductListStatus.success, productList: ProductList.fromJson(mockProductListResponse))
            ]);

    blocTest<ProductListBloc, ProductListState>("getProductList by category fail",
        setUp: () {
          mockBuildContext = MockBuildContext();
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
          String path = "/ecommerce/v1/products";
          when(() {
            return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"categoryId": "1234"});
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
            },
          );
        },
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) => bloc.add(GetProductListByCategory("1234", mockBuildContext, bypassContext: true)),
        expect: () => <ProductListState>[ProductListState(productListStatus: GetProductListStatus.error)]);

    blocTest<ProductListBloc, ProductListState>("getProductList by page",
        setUp: () {
          mockBuildContext = MockBuildContext();
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
          String path = "/ecommerce/v1/products";
          var params = {"page": "2", "itemPersPage": 10, "categoryId": "1234"};
          when(() {
            return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", params);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: mockProductListResponse, statusCode: 200, statusMessage: "OK");
            },
          );
        },
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) =>
            bloc.add(GetProductListByPage(ProductList.fromJson(mockProductListResponse), 2, "1234", mockBuildContext, bypassContext: true)),
        expect: () => <ProductListState>[
              ProductListState(productListStatus: GetProductListStatus.success, productList: ProductList.fromJson(mockProductListResponse))
            ]);

    blocTest<ProductListBloc, ProductListState>("getProductList by page error",
        setUp: () {
          mockBuildContext = MockBuildContext();
          SharedPreferences.setMockInitialValues({});
          final baseUrl = Environment().getValue("BFF_BASE_URL");
          final inventoryApiPath = Environment().getValue("BFF_PRODUCT_MANAGER_BASE_URL");
          String path = "/ecommerce/v1/products";
          var params = {"page": "2", "itemPersPage": 10, "categoryId": "1234"};
          when(() {
            return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", params);
          }).thenAnswer(
            (_) async {
              RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath", method: "GET", data: {});
              return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
            },
          );
        },
        build: () => ProductListBloc(utilityRepository: utilityRepository),
        act: (bloc) =>
            bloc.add(GetProductListByPage(ProductList.fromJson(mockProductListResponse), 2, "1234", mockBuildContext, bypassContext: true)),
        expect: () => <ProductListState>[ProductListState(productListStatus: GetProductListStatus.error)]);
  });
}
