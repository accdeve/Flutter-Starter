import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:t_quiz/api/api.dart';
import 'package:t_quiz/data/models/achievment/achievment.dart';
import 'package:t_quiz/data/repositories/achievment/achievment_repository.dart';

part 'achievment_state.dart';

class AchievmentCubit extends Cubit<AchievmentState> {
  final AchievmentRepository _repository = AchievmentRepository();

  AchievmentCubit() : super(AchievmentInitial());

  void getAchievment(int id) async {
    if (state is AchievmentSuccess) return;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final int? fieldId = prefs.getInt('fieldId');
    emit(AchievmentLoading());
    try {
      final response = await _repository.response("$id");
      emit(AchievmentSuccess(response: response));
    } catch (e) {
      rethrow;
    }
  }
}
