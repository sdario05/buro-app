import 'package:buro_app/features/welcome/domain/model/carousel_model.dart';

abstract class CarouselStates {}

class CarouselInitial extends CarouselStates {}

class CarouselLoading extends CarouselStates {}

class CarouselSuccess extends CarouselStates {
  final List<CarouselModel> model;
  CarouselSuccess(this.model);
}

class CarouselError extends CarouselStates {
  final String message;
  CarouselError(this.message);
}