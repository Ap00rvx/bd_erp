import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/features/home/repository/home_repository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHome>((event, emit) async {
      emit(HomeLoading());
      try {
        final res = await locator
            .get<HomeRepository>()
            .getAttendanceData(locator.get<AuthRepository>().dataModel!);
        res.fold(
            (v) => emit(
                HomeSuccess(data: locator.get<HomeRepository>().responseData!)),
            (err) {
              emit(HomeError(message: err.toString()));
            });
       } catch (err) {
        emit(HomeError(message: err.toString()));
      }
    });
  }
}
