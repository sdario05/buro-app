abstract class ExplorerProfessionStates {}

class Initial extends ExplorerProfessionStates {}

class Loading extends ExplorerProfessionStates {}

class Success extends ExplorerProfessionStates {}

class Error extends ExplorerProfessionStates {
  final String message;
  Error(this.message);
}