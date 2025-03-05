import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_cubit.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_state.dart';

class SearchCatalog3Screen extends StatelessWidget {
  const SearchCatalog3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.035,
                screenHeight * 0.037,
                screenWidth * 0.035,
                screenHeight * 0.015,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFC6E7BE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(screenWidth * 0.08),
                  bottomRight: Radius.circular(screenWidth * 0.08),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: EdgeInsets.all(screenWidth * 0.03),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF282828),
                        border: Border.all(
                          color: Color(0xFF282828),
                          width: screenWidth * 0.004,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/menu_24.svg',
                        width: screenWidth * 0.055,
                        height: screenWidth * 0.055,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: screenHeight * 0.055,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.075),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.robotoFlex(
                            textStyle: TextStyle(
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.03),
                            child: SvgPicture.asset(
                              'assets/search_24.svg',
                              width: screenWidth * 0.055,
                              height: screenWidth * 0.055,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(top: screenHeight * 0.016),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.014),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Popular rent offers',
                  style: GoogleFonts.robotoFlex(
                    textStyle: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF282828)),
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
                    return Center(
                        child: Text(
                      'Error: ${state.message}',
                      style: GoogleFonts.robotoFlex(
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Color(0xFF282828),
                        ),
                      ),
                    ));
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenHeight * 0.005),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.0625),
              child: Image.network(
                property.imageUrl,
                height: screenHeight * 0.25,
                width: screenWidth,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: screenHeight * 0.25,
                    width: screenWidth,
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: screenHeight * 0.018,
              right: screenWidth * 0.04,
              child: SvgPicture.asset(
                'assets/heart_24.svg',
                width: screenWidth * 0.05,
                height: screenHeight * 0.025,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.014,
              left: screenWidth * 0.03,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.007,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: Text(
                  '${property.beds} Beds',
                  style: GoogleFonts.robotoFlex(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                        color: Color(0xFF282828)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.014,
              left: screenWidth * 0.22,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.007,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                child: Text(
                  '${property.bathrooms} Bathroom',
                  style: GoogleFonts.robotoFlex(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.035,
                        color: Color(0xFF282828)),
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Text(
                        property.title,
                        style: GoogleFonts.robotoFlex(
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.035),
                    Text(
                      '\$${property.price.toStringAsFixed(0)} ',
                      style: GoogleFonts.robotoFlex(
                        textStyle: TextStyle(
                            fontSize: screenWidth * 0.053,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF282828)),
                      ),
                    ),
                    Text(
                      '/ mo',
                      style: GoogleFonts.robotoFlex(
                        textStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF282828)),
                      ),
                    ),
                  ],
                ),
                Text(
                  property.location,
                  style: GoogleFonts.robotoFlex(
                    textStyle: TextStyle(
                        fontSize: screenWidth * 0.032,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7E7E7E)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
