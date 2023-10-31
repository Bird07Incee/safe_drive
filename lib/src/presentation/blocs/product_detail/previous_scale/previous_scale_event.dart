part of 'previous_scale_bloc.dart';

class PreviousScaleEvent extends Equatable {
  final double previousScale;

  const PreviousScaleEvent({required this.previousScale});

  @override
  List<Object?> get props => [previousScale];
}
