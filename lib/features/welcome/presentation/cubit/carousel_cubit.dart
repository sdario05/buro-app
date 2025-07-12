import 'package:buro_app/features/welcome/domain/usecase/get_carousel_use_case.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselCubit extends Cubit<CarouselStates> {
  final GetCarouselUseCase _useCase;

  CarouselCubit(this._useCase) : super(CarouselInitial());

  void getCarousel() async {
    emit(CarouselLoading());
    try {
      final response = await _useCase.call();
      emit(CarouselSuccess(response));
    } catch (e) {
      emit(CarouselError(e.toString()));
    }
  }
}