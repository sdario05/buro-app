abstract class GifAnimationStates {}

class Initial extends GifAnimationStates {}

class Loading extends GifAnimationStates {}

class Success extends GifAnimationStates {
  final String gif;
  Success(this.gif);
}

class Error extends GifAnimationStates {
  final String message;
  Error(this.message);
}