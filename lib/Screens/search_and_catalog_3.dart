import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_cubit.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_state.dart';

class SearchCatalog3Screen extends StatelessWidget {
  const SearchCatalog3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular rent offers')),
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            final properties = state.properties;
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: properties.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final property = properties[index];
                return PropertyGridItem(property: property);
              },
            );
          } else if (state is PropertyError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class PropertyGridItem extends StatelessWidget {
  final PropertyModel property;
  const PropertyGridItem({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(property.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(property.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text('${property.beds} Beds | ${property.bathrooms} Baths'),
          Text('\$${property.price.toStringAsFixed(0)} / mo'),
        ],
      ),
    );
  }
}
