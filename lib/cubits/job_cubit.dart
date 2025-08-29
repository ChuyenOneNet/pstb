import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/repositories/dropdown_repository.dart';
import '../di/locator.dart';
import '../models/job_model.dart';

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<Job> list;

  JobLoaded(this.list);
}

class JobError extends JobState {
  final String message;

  JobError(this.message);
}

class JobCubit extends Cubit<JobState> {
  final repo = serviceLocator<DropdownRepository>();

  JobCubit() : super(JobInitial());

  Future<void> fetchJobs(String filter) async {
    try {
      emit(JobLoading());
      final list = await repo.fetchJobs(filter);
      print(list);
      final allJobs = [
        Job(id: '1', name: 'Bác sĩ'),
        Job(id: '2', name: 'Kỹ sư phần mềm'),
        Job(id: '3', name: 'Giáo viên'),
        Job(id: '4', name: 'Nhân viên văn phòng'),
      ];
      emit(JobLoaded(list));
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
