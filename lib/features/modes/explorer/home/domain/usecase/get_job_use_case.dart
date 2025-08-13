import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';
import 'package:buro_app/features/modes/explorer/home/domain/repository/job_repository.dart';

class GetJobUseCase {
  final JobRepository repository;

  GetJobUseCase(this.repository);

  Future<List<JobListing>> call() async {
    return await repository.getJobs();
  }
}