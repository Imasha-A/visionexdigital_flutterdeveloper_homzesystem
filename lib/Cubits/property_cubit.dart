import 'package:flutter_bloc/flutter_bloc.dart';
import 'property_state.dart';
import '../Repositories/property_repository.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository propertyRepository;

  PropertyCubit(this.propertyRepository) : super(PropertyInitial());

  Future<void> getProperties() async {
    emit(PropertyLoading());
    print('Cubit: Starting getProperties()');
    try {
      final properties = await propertyRepository.fetchProperties();
      print('Cubit: Fetched ${properties.length} properties');
      emit(PropertyLoaded(properties));
    } catch (e) {
      print('Cubit: Error fetching properties: $e');
      emit(PropertyError(e.toString()));
    }
  }
}
