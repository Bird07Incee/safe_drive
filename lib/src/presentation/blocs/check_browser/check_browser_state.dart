part of 'check_browser_bloc.dart';

abstract class CheckBrowserState extends Equatable {
  const CheckBrowserState();
  @override
  List<Object> get props => [];
}

class CheckBrowserInitial extends CheckBrowserState {}

class CheckBrowserLoading extends CheckBrowserState {}

class BrowserIsLineLiff extends CheckBrowserState {}

class BrowserIsNotLineLiff extends CheckBrowserState {}
