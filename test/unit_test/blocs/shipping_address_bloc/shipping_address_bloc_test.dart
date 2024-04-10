import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/model/form_widget_model.dart';
import 'package:marketplace_line_oa/src/model/product_summary/shipping_address_model.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:marketplace_line_oa/src/repositories/dio_utility_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDioUtilityRepository extends Mock implements DioUtilityRepository {}

void main() {
  late DioUtilityRepository utilityRepository;

  group("shipping address bloc", () {
    String path = "/ecommerce/v1/data/province";

    setUp(() {
      WidgetsFlutterBinding.ensureInitialized();
      utilityRepository = MockDioUtilityRepository();
      SharedPreferences.setMockInitialValues({});
    });

    test(
      'initial state [ShippingAddressStatus.initial]',
      () {
        expect(
          ShippingAddressBloc(utilityRepository: utilityRepository).state.status.isInitial,
          isTrue,
        );
      },
    );

    test(
      'ShippingAddressDetailState copyWith method initial state',
      () {
        expect(
          ShippingAddressBloc(utilityRepository: utilityRepository).state,
          ShippingAddressBloc(utilityRepository: utilityRepository).state.copyWith(),
        );
      },
    );

    group("ShippingAddressBloc setFormData", () {
      blocTest<ShippingAddressBloc, ShippingAddressState>("setFormData case success case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");

            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {});
                return Response(
                    requestOptions: option,
                    data: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock,
                    statusCode: 200,
                    statusMessage: "OK");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.setFormData(),
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.loading),
                ShippingAddressState(
                  status: ShippingAddressStatus.success,
                  listFormWidget: ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                      listProvince: ShippingAddressBloc(utilityRepository: utilityRepository).getDropDownAddressModel(
                          province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List)),
                  formResult: [
                    FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'province', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
                    FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
                  ],
                )
              ]);

      blocTest<ShippingAddressBloc, ShippingAddressState>("setFormData case fail case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {});
                return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.setFormData(),
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.loading),
                ShippingAddressState(
                  status: ShippingAddressStatus.error,
                )
              ]);

      blocTest<ShippingAddressBloc, ShippingAddressState>("setFormData case fail case catch exception",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            String path = "/ecommerce/v1/data/province1";
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {});
                return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) => bloc.setFormData(),
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.loading),
                ShippingAddressState(
                  status: ShippingAddressStatus.error,
                )
              ]);
    });

    group("ShippingAddressBloc updateDropdownSelected", () {
      blocTest<ShippingAddressBloc, ShippingAddressState>("updateDropdownSelected case success case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"province": "01"});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {"province": "01"});
                return Response(
                    requestOptions: option,
                    data: ShippingAddressBloc(utilityRepository: utilityRepository).districtDataMock,
                    statusCode: 200,
                    statusMessage: "OK");
              },
            );
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"district": "0101"});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {"district": "0101"});
                return Response(
                    requestOptions: option,
                    data: ShippingAddressBloc(utilityRepository: utilityRepository).subDistrictDataMock,
                    statusCode: 200,
                    statusMessage: "OK");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) async {
            await bloc.updateDropdownSelected(
                id: "01",
                fieldName: "province",
                filterRefId: "01",
                listForm: ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                    listProvince: ShippingAddressBloc(utilityRepository: utilityRepository).getDropDownAddressModel(
                        province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List)),
                listResult: [
                  FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
                  FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
                  FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
                ]);
            bloc.emit(ShippingAddressState(status: bloc.state.status, formResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
            ]));
            await bloc.updateDropdownSelected(
                id: "0101",
                fieldName: "district",
                filterRefId: "0101",
                listForm: ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                    listProvince: ShippingAddressBloc(utilityRepository: utilityRepository).getDropDownAddressModel(
                        province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List)),
                listResult: [
                  FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
                  FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
                  FormWidgetResultModel(id: '0101', fieldName: 'district', value: 'เขตพระนคร'),
                  FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
                ]);
            bloc.emit(ShippingAddressState(status: bloc.state.status, listFormWidget: bloc.state.listFormWidget, formResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '0101', fieldName: 'district', value: 'เขตพระนคร'),
              FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
            ]));
            List<FormWidgetModel> model = ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                listProvince: ShippingAddressBloc(utilityRepository: utilityRepository)
                    .getDropDownAddressModel(province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List));
            model.where((element) => element.fieldName == 'subdistrict').first.options!.addAll(bloc.listSubDistrict);
            await bloc.updateDropdownSelected(id: "010101", fieldName: "subdistrict", filterRefId: "", listForm: model, listResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '0101', fieldName: 'district', value: 'เขตพระนคร'),
              FormWidgetResultModel(id: '010101', fieldName: 'subdistrict', value: 'พระบรมมหาราชวัง'),
              FormWidgetResultModel(id: '0', fieldName: 'zipcode', value: '10200'),
            ]);
            bloc.emit(ShippingAddressState(status: bloc.state.status, listFormWidget: bloc.state.listFormWidget, formResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '0101', fieldName: 'district', value: 'เขตพระนคร'),
              FormWidgetResultModel(id: '010101', fieldName: 'subdistrict', value: 'พระบรมมหาราชวัง'),
              FormWidgetResultModel(id: '0', fieldName: 'zipcode', value: '10200')
            ]));
          },
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.fetching),
                ShippingAddressState(
                  status: ShippingAddressStatus.success,
                ),
                ShippingAddressState(status: ShippingAddressStatus.fetching),
                ShippingAddressState(
                  status: ShippingAddressStatus.success,
                ),
              ]);

      blocTest<ShippingAddressBloc, ShippingAddressState>("updateDropdownSelected case fail getDistrict case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"province": "01"});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {"province": "01"});
                return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) {
            bloc.updateDropdownSelected(
                id: "",
                fieldName: "province",
                filterRefId: "01",
                listForm: ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                    listProvince: ShippingAddressBloc(utilityRepository: utilityRepository).getDropDownAddressModel(
                        province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List)),
                listResult: [
                  FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'province', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
                ]);
            bloc.emit(ShippingAddressState(status: ShippingAddressStatus.error, formResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
            ]));
          },
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.fetching),
                ShippingAddressState(
                  status: ShippingAddressStatus.error,
                ),
              ]);

      blocTest<ShippingAddressBloc, ShippingAddressState>("updateDropdownSelected case fail getSubDistrict case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"province": "01"});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {"province": "01"});
                return Response(
                    requestOptions: option,
                    data: ShippingAddressBloc(utilityRepository: utilityRepository).districtDataMock,
                    statusCode: 200,
                    statusMessage: "OK");
              },
            );
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {"district": "0101"});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {"district": "0101"});
                return Response(requestOptions: option, data: {}, statusCode: 400, statusMessage: "Bad Request");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) async {
            await bloc.updateDropdownSelected(
                id: "01",
                fieldName: "province",
                filterRefId: "01",
                listForm: ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                    listProvince: ShippingAddressBloc(utilityRepository: utilityRepository).getDropDownAddressModel(
                        province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List)),
                listResult: [
                  FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
                  FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
                  FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
                ]);
            bloc.emit(ShippingAddressState(status: bloc.state.status, formResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '', fieldName: 'district', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
            ]));
            await bloc.updateDropdownSelected(
                id: "0101",
                fieldName: "district",
                filterRefId: "0101",
                listForm: ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                    listProvince: ShippingAddressBloc(utilityRepository: utilityRepository).getDropDownAddressModel(
                        province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List)),
                listResult: [
                  FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
                  FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
                  FormWidgetResultModel(id: '0101', fieldName: 'district', value: 'เขตพระนคร'),
                  FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
                  FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
                ]);
            bloc.emit(ShippingAddressState(status: ShippingAddressStatus.error, listFormWidget: bloc.state.listFormWidget, formResult: [
              FormWidgetResultModel(id: '', fieldName: 'name', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'phone', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'email', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'address', value: ''),
              FormWidgetResultModel(id: '01', fieldName: 'province', value: 'กรุงเทพมหานคร'),
              FormWidgetResultModel(id: '0101', fieldName: 'district', value: 'เขตพระนคร'),
              FormWidgetResultModel(id: '', fieldName: 'subdistrict', value: ''),
              FormWidgetResultModel(id: '', fieldName: 'zipcode', value: ''),
            ]));
          },
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.fetching),
                ShippingAddressState(
                  status: ShippingAddressStatus.success,
                ),
                ShippingAddressState(status: ShippingAddressStatus.fetching),
                ShippingAddressState(
                  status: ShippingAddressStatus.error,
                ),
              ]);
    });

    group("ShippingAddressBloc validateAnyFieldInForm", () {
      blocTest<ShippingAddressBloc, ShippingAddressState>("validateAnyFieldInForm case success case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {});
                return Response(
                    requestOptions: option,
                    data: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock,
                    statusCode: 200,
                    statusMessage: "OK");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) async {
            await bloc.setFormData();
            List<FormWidgetModel> formList = ShippingAddressBloc(utilityRepository: utilityRepository).getListFormWidget(
                listProvince: ShippingAddressBloc(utilityRepository: utilityRepository)
                    .getDropDownAddressModel(province: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock['items'] as List));
            formList[0].controller!.text = "kanphob kaenchaleaw";
            formList[1].controller!.text = "0970976912";
            formList[2].controller!.text = "kanphob.k@gmail.com";
            formList[3].controller!.text = "97/281 ratpattana 25 ratpattana saphangsung bangkok 10240";
            bloc.state.listFormWidget!.addAll(formList);
            for (int i = 0; i < formList.length; i++) {
              await bloc.validateAnyFieldInForm(item: formList[i], isFocus: false);
            }
          },
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.loading, isAllowSubmit: false),
                ShippingAddressState(status: ShippingAddressStatus.success, isAllowSubmit: false),
              ]);
    });

    group("ShippingAddressBloc onSubmitPressed", () {
      blocTest<ShippingAddressBloc, ShippingAddressState>("onSubmitPressed case success case",
          setUp: () {
            final baseUrl = Environment().getValue("BFF_BASE_URL");
            final inventoryApiPath = Environment().getValue("BFF_MASTER_PROVINCE_MANAGER_BASE_URL");
            when(() {
              return utilityRepository.getByURL("$baseUrl$inventoryApiPath$path", {});
            }).thenAnswer(
              (_) async {
                RequestOptions option = RequestOptions(baseUrl: "$baseUrl$inventoryApiPath$path", method: "GET", data: {});
                return Response(
                    requestOptions: option,
                    data: ShippingAddressBloc(utilityRepository: utilityRepository).provinceDataMock,
                    statusCode: 200,
                    statusMessage: "OK");
              },
            );
          },
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) async {
            await bloc.setFormData();
            bloc.state.formResult!.where((element) => element.fieldName == 'name').first.value = "kanphob kaenchaleaw";
            bloc.state.formResult!.where((element) => element.fieldName == 'phone').first.value = "0970976912";
            bloc.state.formResult!.where((element) => element.fieldName == 'email').first.value = "kanphob.k@gmail.com";
            bloc.state.formResult!.where((element) => element.fieldName == 'address').first.value = "97/281 ratpattana 25 saphangsung bangkok 10240";
            bloc.state.formResult!.where((element) => element.fieldName == 'province').first.value = "กรุงเทพมหานคร";
            bloc.state.formResult!.where((element) => element.fieldName == 'district').first.value = "เขตพระนคร";
            bloc.state.formResult!.where((element) => element.fieldName == 'subdistrict').first.value = "พระบรมมหาราชวัง";
            bloc.state.formResult!.where((element) => element.fieldName == 'zipcode').first.value = "10200";
            await bloc.onSubmitPressed(isEnableSubmit: true);
          },
          expect: () => <ShippingAddressState>[
                ShippingAddressState(status: ShippingAddressStatus.loading),
                ShippingAddressState(status: ShippingAddressStatus.success),
                ShippingAddressState(
                    addressModel: ShippingAddressModel(
                        fullName: "kanphob kaenchaleaw",
                        mobileNumber: "0970976912",
                        emailAddress: "kanphob.k@gmail.com",
                        fullAddress: "97/281 ratpattana 25 saphangsung bangkok 10240",
                        province: "กรุงเทพมหานคร",
                        district: "เขตพระนคร",
                        subDistrict: "พระบรมมหาราชวัง",
                        zipCode: "10200"),
                    status: ShippingAddressStatus.success),
              ]);
    });

    group("ShippingAddressBloc onClearShippingData", () {
      blocTest<ShippingAddressBloc, ShippingAddressState>("onClearShippingData case success case",
          setUp: () {},
          build: () => ShippingAddressBloc(utilityRepository: utilityRepository),
          act: (bloc) async {
            await bloc.onClearShippingData();
          },
          expect: () => <ShippingAddressState>[
                const ShippingAddressState(
                    status: ShippingAddressStatus.initial,
                    addressModel: ShippingAddressModel.empty,
                    formResult: [],
                    listFormWidget: [],
                    isAllowSubmit: false),
              ]);
    });
  });
}
