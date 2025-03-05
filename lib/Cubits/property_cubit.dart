import 'package:flutter_bloc/flutter_bloc.dart';
import 'property_state.dart';
import '../Repositories/property_repository.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository propertyRepository;

  PropertyCubit(this.propertyRepository) : super(PropertyInitial());

  Future<void> getProperties() async {
    emit(PropertyLoading());
    
    try {
      final properties = await propertyRepository.fetchProperties();
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}
