import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOptionBloc extends Cubit<ProductOptionState> {
  ProductOptionBloc() : super(ProductOptionState());

  // Create methods to update the variables and emit the state
  void updateStepOneVariables({
    String? groupValueRadio,
    double? price,
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
    double? price,
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
    double? price,
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
    double? price,
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
    double? price,
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
  final double? stepOnePrice;
  final int? stepOneIndexSelect;
  final String stepTwoGroupValueRadio;
  final double? stepTwoPrice;
  final int? stepTwoIndexSelect;
  final String stepTreeGroupValueRadio;
  final double? stepTreePrice;
  final int? stepTreeIndexSelect;
  final String stepFourGroupValueRadio;
  final double? stepFourPrice;
  final int? stepFourIndexSelect;
  final String stepFiveGroupValueRadio;
  final double? stepFivePrice;
  final int? stepFiveIndexSelect;
  final int? lastOption;
  final int? selectCurrentOption;

  const ProductOptionState({
    this.stepOneGroupValueRadio = "",
    this.stepOnePrice = 0,
    this.stepOneIndexSelect = 0,
    this.stepTwoGroupValueRadio = "",
    this.stepTwoPrice = 0,
    this.stepTwoIndexSelect = 0,
    this.stepTreeGroupValueRadio = "",
    this.stepTreePrice = 0,
    this.stepTreeIndexSelect = 0,
    this.stepFourGroupValueRadio = "",
    this.stepFourPrice = 0,
    this.stepFourIndexSelect = 0,
    this.stepFiveGroupValueRadio = "",
    this.stepFivePrice = 0,
    this.stepFiveIndexSelect = 0,
    this.lastOption = 0,
    this.selectCurrentOption = 0,
  });

  ProductOptionState copyWith({
    String? stepOneGroupValueRadio,
    double? stepOnePrice,
    int? stepOneIndexSelect,
    String? stepTwoGroupValueRadio,
    double? stepTwoPrice,
    int? stepTwoIndexSelect,
    String? stepTreeGroupValueRadio,
    double? stepTreePrice,
    int? stepTreeIndexSelect,
    String? stepFourGroupValueRadio,
    double? stepFourPrice,
    int? stepFourIndexSelect,
    String? stepFiveGroupValueRadio,
    double? stepFivePrice,
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
