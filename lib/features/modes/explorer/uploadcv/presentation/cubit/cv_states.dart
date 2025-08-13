abstract class CvStates {}

class Initial extends CvStates {}

class Loading extends CvStates {}

class Success extends CvStates {}

class Error extends CvStates {
  final String message;
  Error(this.message);
}