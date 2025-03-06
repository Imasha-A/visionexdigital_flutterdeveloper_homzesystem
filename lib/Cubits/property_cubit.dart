import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import '../States/property_state.dart';
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
    final priceRegEx = RegExp(r'(\d+)\s*\$?|price');
    final numRegEx = RegExp(r'\b\d+\b');

    int? bedNumber;
    int? bathNumber;
    int? priceNumber;

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
    if (priceRegEx.hasMatch(lowerQuery)) {
      final match = priceRegEx.firstMatch(lowerQuery);
      if (match != null) {
        priceNumber = int.tryParse(match.group(1)!);
      }
    }

    if (!lowerQuery.contains("bed") &&
        !lowerQuery.contains("bath") &&
        !lowerQuery.contains("price") &&
        !lowerQuery.contains("\$")) {
      final allNumbers = numRegEx
          .allMatches(lowerQuery)
          .map((m) => int.tryParse(m.group(0)!))
          .whereType<int>()
          .toList();
      if (allNumbers.isNotEmpty) {
        bedNumber = allNumbers[0];
        if (allNumbers.length > 1) bathNumber = allNumbers[1];
        if (allNumbers.length > 2) priceNumber = allNumbers[2];
      }
    }

    final filtered = _allProperties.where((property) {
      final titleMatch = property.title.toLowerCase().contains(lowerQuery);
      final locationMatch =
          property.location.toLowerCase().contains(lowerQuery);
      final bedMatch = bedNumber != null ? property.beds == bedNumber : false;
      final bathMatch =
          bathNumber != null ? property.bathrooms == bathNumber : false;
      final priceMatch =
          priceNumber != null ? property.price == priceNumber : false;
      return titleMatch || locationMatch || bedMatch || bathMatch || priceMatch;
    }).toList();

    emit(PropertyLoaded(filtered));
  }
}
