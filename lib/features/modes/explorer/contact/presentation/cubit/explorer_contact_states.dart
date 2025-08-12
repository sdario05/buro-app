abstract class ExplorerContactStates {}

class Initial extends ExplorerContactStates {}

class Loading extends ExplorerContactStates {}

class Success extends ExplorerContactStates {}

class Error extends ExplorerContactStates {
  final String message;
  Error(this.message);
}