abstract class ImageStates {}

class Initial extends ImageStates {}

class Loading extends ImageStates {}

class Success extends ImageStates {
  final String model;
  Success(this.model);
}

class Error extends ImageStates {
  final String message;
  Error(this.message);
}