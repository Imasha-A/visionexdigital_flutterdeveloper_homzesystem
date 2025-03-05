import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Screens/search_and_catalog_3.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_cubit.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_state.dart';

class SearchCatalog1Screen extends StatelessWidget {
  const SearchCatalog1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, Imasha Arachchi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<PropertyCubit, PropertyState>(
        builder: (context, state) {
          if (state is PropertyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PropertyLoaded) {
            final properties = state.properties;

            final featured = properties.take(3).toList();
            final newOffers = properties.skip(3).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Section
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Featured',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featured.length,
                      itemBuilder: (context, index) {
                        return PropertyCard(property: featured[index]);
                      },
                    ),
                  ),

                  // New Offers Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'New offers',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigation to Search & Catalog 3 screen with an animation
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SearchCatalog3Screen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                final slideTween = Tween(
                                    begin: const Offset(0.0, 1.0),
                                    end: Offset.zero);
                                final slideAnimation =
                                    animation.drive(slideTween);

                                return SlideTransition(
                                  position: slideAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text('View all'),
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(newOffers.length, (index) {
                      return PropertyListTile(property: newOffers[index]);
                    }),
                  ),
                ],
              ),
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

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  const PropertyCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: 160,
        child: Column(
          children: [
            Expanded(
              child: Image.network(property.imageUrl, fit: BoxFit.cover),
            ),
            Text(property.title),
            Text('\$${property.price.toStringAsFixed(0)} / mo'),
          ],
        ),
      ),
    );
  }
}

class PropertyListTile extends StatelessWidget {
  final PropertyModel property;
  const PropertyListTile({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(property.imageUrl, width: 60, fit: BoxFit.cover),
      title: Text(property.title),
      subtitle: Text('${property.beds} Beds, ${property.bathrooms} Baths'),
      trailing: Text('\$${property.price.toStringAsFixed(0)}'),
    );
  }
}
