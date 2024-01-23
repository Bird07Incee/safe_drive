import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailDescriptionCubit extends Cubit<ProductDetailDescriptionCubitState> {
  ProductDetailDescriptionCubit() : super(ProductDetailDescriptionCubitState());

  // Create methods to update the variables and emit the state
  void updateToggleTapDescription({
    bool? toggleDescription,
    bool? textNotMoreThan,
  }) {
    emit(state.copyWith(tapOpenDescription: toggleDescription, perfeceText: textNotMoreThan));
  }
}

class ProductDetailDescriptionCubitState extends Equatable {
  final bool toggleDescription;
  final bool textNotMoreThan;

  const ProductDetailDescriptionCubitState({
    this.toggleDescription = false,
    this.textNotMoreThan = false,
  });

  ProductDetailDescriptionCubitState copyWith({
    bool? tapOpenDescription,
    bool? perfeceText,
  }) {
    return ProductDetailDescriptionCubitState(
      toggleDescription: tapOpenDescription ?? toggleDescription,
      textNotMoreThan: perfeceText ?? textNotMoreThan,
    );
  }

  @override
  List<Object?> get props => [toggleDescription, textNotMoreThan];
}
