import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_cubit.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_state.dart';

class SearchCatalog3Screen extends StatelessWidget {
  const SearchCatalog3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.green.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular rent offers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<PropertyCubit, PropertyState>(
                builder: (context, state) {
                  if (state is PropertyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PropertyLoaded) {
                    final properties = state.properties;
                    return ListView.builder(
                      itemCount: properties.length,
                      itemBuilder: (context, index) {
                        return PropertyListItem(property: properties[index]);
                      },
                    );
                  } else if (state is PropertyError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyListItem extends StatelessWidget {
  final PropertyModel property;
  const PropertyListItem({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Image.network(
              property.imageUrl,
              height: sh * 0.25,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: sh * 0.017,
              right: sw * 0.03,
              child: SvgPicture.asset(
                'assets/heart_24.svg',
                width: sw * 0.05,
                height: sw * 0.05,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Positioned(
              bottom: sh * 0.017,
              left: sw * 0.03,
              child: Text(
                '${property.beds} Beds',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: sw * 0.035,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
            Positioned(
              bottom: sh * 0.017,
              left: sw * 0.22,
              child: Text(
                '${property.bathrooms} Bathroom',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: sw * 0.035,
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(sw * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: TextStyle(
                    fontSize: sw * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${property.price.toStringAsFixed(0)} / mo',
                  style: TextStyle(
                    fontSize: sw * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  property.location,
                  style: TextStyle(color: Colors.grey, fontSize: sw * 0.035),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
