import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedplan/core/config/exception.dart';

import '../../data/model.dart';
import '../../data/service.dart';

part 'weeding_state.dart';

class WeddingCubit extends Cubit<WeddingState> {
  final service = WeddingService();

  WeddingCubit() : super(const WeddingState());

  Future<void> fetchWeddings() async {
    emit(state.copyWith(fetchStatus: AppStatus.loading));
    try {
      final weddings = await service.getAllWeddings();
      emit(
        state.copyWith(
          weddings: weddings,
          fetchStatus: AppStatus.success,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetchStatus: AppStatus.failed, error: e.toString()));
    }
  }

  Future<void> getWeddingById(String id) async {
    emit(state.copyWith(fetchStatus: AppStatus.loading));
    try {
      final wedding = await service.getWeddingById(id: id);
      emit(
        state.copyWith(
          selectedWedding: wedding,
          fetchStatus: AppStatus.success,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetchStatus: AppStatus.failed, error: e.toString()));
    }
  }

  Future<bool> createWedding(Wedding wedding) async {
    emit(state.copyWith(createStatus: AppStatus.loading));
    try {
      final created = await service.createWedding(wedding: wedding);
      final updatedList = List<Wedding>.from(state.weddings)..add(created);
      emit(
        state.copyWith(
          weddings: updatedList,
          createStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(createStatus: AppStatus.failed, error: e.toString()));
      return false;
    }
  }

  Future<bool> updateWedding(String id, Wedding wedding) async {
    emit(state.copyWith(updateStatus: AppStatus.loading));
    try {
      final updated = await service.updateWedding(id: id, wedding: wedding);
      final updatedList = state.weddings
          .map((w) => w.id == id ? updated : w)
          .toList();
      emit(
        state.copyWith(
          weddings: updatedList,
          updateStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(updateStatus: AppStatus.failed, error: e.toString()));
      return false;
    }
  }

  Future<bool> deleteWedding(String id) async {
    emit(state.copyWith(deleteStatus: AppStatus.loading));
    try {
      await service.deleteWedding(id: id);
      final updatedList = state.weddings.where((w) => w.id != id).toList();
      emit(
        state.copyWith(
          weddings: updatedList,
          deleteStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(deleteStatus: AppStatus.failed, error: e.toString()));
      return false;
    }
  }
}
