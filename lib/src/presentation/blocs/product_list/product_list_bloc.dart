import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';

import '../../../model/product_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(const ProductListState()) {
    on<ProductListEvent>((event, emit) {
      DefaultAssetBundle.of(event.context).loadString('assets/json/product_list.json').then((value) {
        final jsonObj = json.decode(value);
        final productList = ProductList.fromJson(jsonObj);
        emit(state.copyWith(productList: productList));
      });
    });
  }
}
