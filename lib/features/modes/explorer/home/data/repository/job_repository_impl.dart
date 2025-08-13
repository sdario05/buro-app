import 'package:buro_app/features/modes/explorer/home/data/service/job_service.dart';
import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';
import 'package:buro_app/features/modes/explorer/home/domain/repository/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final JobService service;

  JobRepositoryImpl(this.service);

  @override
  Future<List<JobListing>> getJobs() async {
    return await service.getJobs();
  }
}