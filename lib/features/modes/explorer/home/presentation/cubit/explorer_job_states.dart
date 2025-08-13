import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';

abstract class ExplorerJobStates {}

class Initial extends ExplorerJobStates {}

class Loading extends ExplorerJobStates {}

class Success extends ExplorerJobStates {
  final List<JobListing> model;
  Success(this.model);
}

class Error extends ExplorerJobStates {
  final String message;
  Error(this.message);
}