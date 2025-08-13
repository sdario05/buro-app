import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';
import 'package:buro_app/features/modes/explorer/home/domain/usecase/get_job_use_case.dart';
import 'package:buro_app/features/modes/explorer/home/presentation/cubit/explorer_job_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerJobCubit extends Cubit<ExplorerJobStates> {
  final GetJobUseCase _useCase;

  List<JobListing> jobs = [];

  ExplorerJobCubit(this._useCase) : super(Initial());

  Future<void> getJobs() async {
    emit(Loading());
    try {
      final response = await _useCase.call();
      jobs = response;
      emit(Success(jobs));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}