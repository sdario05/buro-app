import 'package:buro_app/features/modes/explorer/home/domain/model/job_listing.dart';

abstract class JobRepository {
  Future<List<JobListing>> getJobs();
}