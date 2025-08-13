import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';
import 'package:buro_app/features/modes/explorer/home/domain/usecase/get_job_use_case.dart';
import 'package:buro_app/features/modes/explorer/home/presentation/cubit/explorer_job_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diacritic/diacritic.dart';

class ExplorerJobCubit extends Cubit<ExplorerJobStates> {
  final GetJobUseCase _useCase;

  List<JobListing> _jobs = [];

  ExplorerJobCubit(this._useCase) : super(Initial());

  Future<void> getJobs() async {
    emit(Loading());
    try {
      final response = await _useCase.call();
      _jobs = response;
      emit(Success(_jobs));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  void searchJobs(String input) {
    if (input.length >= 3) {
      final query = removeDiacritics(input.toLowerCase());
      emit(Success(
        _jobs.where((item) {
          final name = removeDiacritics(item.name?.toLowerCase() ?? '');
          final title = removeDiacritics(item.title?.toLowerCase() ?? '');
          return name.contains(query) || title.contains(query);
        }).toList(),
      ));
    } else {
      emit(Success(_jobs));
    }
  }
}