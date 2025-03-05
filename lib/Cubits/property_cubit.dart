import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import 'property_state.dart';
import '../Repositories/property_repository.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository propertyRepository;
  List<PropertyModel> _allProperties = [];

  PropertyCubit(this.propertyRepository) : super(PropertyInitial());

  Future<void> getProperties() async {
    emit(PropertyLoading());
    try {
      _allProperties = await propertyRepository.fetchProperties();
      emit(PropertyLoaded(_allProperties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  void filterProperties(String query) {
    if (query.isEmpty) {
      emit(PropertyLoaded(_allProperties));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final bedRegEx = RegExp(r'(\d+)\s*beds?');
    final bathRegEx = RegExp(r'(\d+)\s*bath(rooms?)?');

    int? bedNumber;
    int? bathNumber;

    if (bedRegEx.hasMatch(lowerQuery)) {
      final match = bedRegEx.firstMatch(lowerQuery);
      if (match != null) {
        bedNumber = int.tryParse(match.group(1)!);
      }
    }

    if (bathRegEx.hasMatch(lowerQuery)) {
      final match = bathRegEx.firstMatch(lowerQuery);
      if (match != null) {
        bathNumber = int.tryParse(match.group(1)!);
      }
    }
    if (bedNumber == null && bathNumber == null) {
      final numericQuery = int.tryParse(lowerQuery);
      if (numericQuery != null) {
        bedNumber = numericQuery;
        bathNumber = numericQuery;
      }
    }

    final filtered = _allProperties.where((property) {
      final titleMatch = property.title.toLowerCase().contains(lowerQuery);
      final locationMatch =
          property.location.toLowerCase().contains(lowerQuery);
      final bedMatch = bedNumber != null ? property.beds == bedNumber : false;
      final bathMatch =
          bathNumber != null ? property.bathrooms == bathNumber : false;

      return titleMatch || locationMatch || bedMatch || bathMatch;
    }).toList();

    emit(PropertyLoaded(filtered));
  }
}
