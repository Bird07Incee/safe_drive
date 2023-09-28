import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOptionBloc extends Cubit<ProductOptionState> {
  ProductOptionBloc() : super(ProductOptionState());

  // Create methods to update the variables and emit the state
  void updateStepOneVariables({
    String? groupValueRadio,
    int? price,
    int? indexSelect,
  }) {
    emit(state.copyWith(
      stepOneGroupValueRadio: groupValueRadio,
      stepOnePrice: price,
      stepOneIndexSelect: indexSelect,
    ));
  }

  void updateStepTwoVariables({
    String? groupValueRadio,
    int? price,
    int? indexSelect,
  }) {
    emit(state.copyWith(
      stepTwoGroupValueRadio: groupValueRadio,
      stepTwoPrice: price,
      stepTwoIndexSelect: indexSelect,
    ));
  }

  void updateStepTreeVariables({
    String? groupValueRadio,
    int? price,
    int? indexSelect,
  }) {
    emit(state.copyWith(
      stepTreeGroupValueRadio: groupValueRadio,
      stepTreePrice: price,
      stepTreeIndexSelect: indexSelect,
    ));
  }

  void updateStepFourVariables({
    String? groupValueRadio,
    int? price,
    int? indexSelect,
  }) {
    emit(state.copyWith(
      stepFourGroupValueRadio: groupValueRadio,
      stepFourPrice: price,
      stepFourIndexSelect: indexSelect,
    ));
  }

  void updateStepFiveVariables({
    String? groupValueRadio,
    int? price,
    int? indexSelect,
  }) {
    emit(state.copyWith(
      stepFiveGroupValueRadio: groupValueRadio,
      stepFivePrice: price,
      stepFiveIndexSelect: indexSelect,
    ));
  }
  // Repeat the above for other steps

  void updateLastOption(int? option) {
    emit(state.copyWith(lastOption: option));
  }

  void updateSelectCurrentOption(int? option) {
    emit(state.copyWith(selectCurrentOption: option));
  }
}

class ProductOptionState extends Equatable {
  final String stepOneGroupValueRadio;
  final int? stepOnePrice;
  final int? stepOneIndexSelect;
  final String stepTwoGroupValueRadio;
  final int? stepTwoPrice;
  final int? stepTwoIndexSelect;
  final String stepTreeGroupValueRadio;
  final int? stepTreePrice;
  final int? stepTreeIndexSelect;
  final String stepFourGroupValueRadio;
  final int? stepFourPrice;
  final int? stepFourIndexSelect;
  final String stepFiveGroupValueRadio;
  final int? stepFivePrice;
  final int? stepFiveIndexSelect;
  final int? lastOption;
  final int? selectCurrentOption;

  const ProductOptionState({
    this.stepOneGroupValueRadio = "",
    this.stepOnePrice,
    this.stepOneIndexSelect,
    this.stepTwoGroupValueRadio = "",
    this.stepTwoPrice,
    this.stepTwoIndexSelect,
    this.stepTreeGroupValueRadio = "",
    this.stepTreePrice,
    this.stepTreeIndexSelect,
    this.stepFourGroupValueRadio = "",
    this.stepFourPrice,
    this.stepFourIndexSelect,
    this.stepFiveGroupValueRadio = "",
    this.stepFivePrice,
    this.stepFiveIndexSelect,
    this.lastOption,
    this.selectCurrentOption = 0,
  });

  ProductOptionState copyWith({
    String? stepOneGroupValueRadio,
    int? stepOnePrice,
    int? stepOneIndexSelect,
    String? stepTwoGroupValueRadio,
    int? stepTwoPrice,
    int? stepTwoIndexSelect,
    String? stepTreeGroupValueRadio,
    int? stepTreePrice,
    int? stepTreeIndexSelect,
    String? stepFourGroupValueRadio,
    int? stepFourPrice,
    int? stepFourIndexSelect,
    String? stepFiveGroupValueRadio,
    int? stepFivePrice,
    int? stepFiveIndexSelect,
    int? lastOption,
    int? selectCurrentOption,
  }) {
    return ProductOptionState(
      stepOneGroupValueRadio: stepOneGroupValueRadio ?? this.stepOneGroupValueRadio,
      stepOnePrice: stepOnePrice ?? this.stepOnePrice,
      stepOneIndexSelect: stepOneIndexSelect ?? this.stepOneIndexSelect,
      stepTwoGroupValueRadio: stepTwoGroupValueRadio ?? this.stepTwoGroupValueRadio,
      stepTwoPrice: stepTwoPrice ?? this.stepTwoPrice,
      stepTwoIndexSelect: stepTwoIndexSelect ?? this.stepTwoIndexSelect,
      stepTreeGroupValueRadio: stepTreeGroupValueRadio ?? this.stepTreeGroupValueRadio,
      stepTreePrice: stepTreePrice ?? this.stepTreePrice,
      stepTreeIndexSelect: stepTreeIndexSelect ?? this.stepTreeIndexSelect,
      stepFourGroupValueRadio: stepFourGroupValueRadio ?? this.stepFourGroupValueRadio,
      stepFourPrice: stepFourPrice ?? this.stepFourPrice,
      stepFourIndexSelect: stepFourIndexSelect ?? this.stepFourIndexSelect,
      stepFiveGroupValueRadio: stepFiveGroupValueRadio ?? this.stepFiveGroupValueRadio,
      stepFivePrice: stepFivePrice ?? this.stepFivePrice,
      stepFiveIndexSelect: stepFiveIndexSelect ?? this.stepFiveIndexSelect,
      lastOption: lastOption ?? this.lastOption,
      selectCurrentOption: selectCurrentOption ?? this.selectCurrentOption,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        stepOneGroupValueRadio,
        stepOnePrice,
        stepOneIndexSelect,
        stepTwoGroupValueRadio,
        stepTwoPrice,
        stepTwoIndexSelect,
        stepTreeGroupValueRadio,
        stepTreePrice,
        stepTreeIndexSelect,
        stepFourGroupValueRadio,
        stepFourPrice,
        stepFourIndexSelect,
        stepFiveGroupValueRadio,
        stepFivePrice,
        stepFiveIndexSelect,
        lastOption,
        selectCurrentOption,
      ];
}
