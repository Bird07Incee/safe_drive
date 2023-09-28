part of 'product_list_bloc.dart';

class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class GetProductListMock extends ProductListEvent {
  const GetProductListMock(this.context);

  final BuildContext context;
}

class GetProductList extends ProductListEvent {
  const GetProductList();
}

class GetProductListByCategory extends ProductListEvent {
  const GetProductListByCategory(this.categoryId);

  final String categoryId;
}

class SetSelectTabIndex extends ProductListEvent {
  const SetSelectTabIndex(this.selectedTabIndex);

  final int selectedTabIndex;
}
