part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final Map<String, dynamic> data;

  HomeSuccess({required this.data}); 
}
class HomeError extends HomeState{
  final String message;

  HomeError({required this.message});

}
class HomeLoading extends HomeState{}