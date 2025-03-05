import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Models/property_model.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Screens/search_and_catalog_3.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_cubit.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Cubits/property_state.dart';

class SearchCatalog1Screen extends StatelessWidget {
  const SearchCatalog1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            width: screenWidth * 1.4,
                            height: screenHeight * 0.24,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: const Color(0xFFF0F298),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(screenWidth * 0.08),
                                bottomRight:
                                    Radius.circular(screenWidth * 0.08),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.07,
                          left: 0,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  child: SvgPicture.asset(
                                    'assets/menu_24.svg',
                                    width: screenWidth * 0.055,
                                    height: screenWidth * 0.055,
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFF282828),
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.41),
                              Text(
                                'Hi, Stanislav',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.05),
                                child: CircleAvatar(
                                  radius: screenWidth * 0.05,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Text(
                                    'S',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: screenHeight * 0.048,
                          left: screenWidth * 0.04,
                          right: screenWidth * 0.04,
                          child: Container(
                            height: screenHeight * 0.064,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.075),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
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
                                    EdgeInsets.only(top: screenHeight * 0.014),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.03),
                      Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: screenWidth * 0.043,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF282828),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.57),
                      TextButton(
                        onPressed: () {
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
                                  end: Offset.zero,
                                );
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
                        child: Text(
                          'View all',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF7E7E7E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featured.length,
                      itemBuilder: (context, index) {
                        return _buildFeaturedCard(
                          context,
                          featured[index],
                          screenWidth,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.023),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New offers',
                          style: TextStyle(
                            fontSize: screenWidth * 0.043,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF282828),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
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
                                    end: Offset.zero,
                                  );
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
                          child: Text(
                            'View all',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF7E7E7E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Column(
                    children: List.generate(newOffers.length, (index) {
                      return _buildNewOfferCard(
                        context,
                        newOffers[index],
                        screenWidth,
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.023),
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

  Widget _buildFeaturedCard(
      BuildContext context, PropertyModel property, double screenWidth) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.0625),
                child: Image.network(
                  property.imageUrl,
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.17,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.02,
                right: screenWidth * 0.02,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.006,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  child: Text(
                    '\$${property.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: SizedBox(
            width: screenWidth * 0.35,
            child: Text(
              property.title,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewOfferCard(
      BuildContext context, PropertyModel property, double screenWidth) {
    final screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = screenWidth * 0.9;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.011,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.0625),
                child: Image.network(
                  property.imageUrl,
                  width: cardWidth,
                  height: cardWidth * 0.55,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.017,
                right: screenWidth * 0.03,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.009,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  child: Text(
                    '\$${property.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.017,
                right: screenWidth * 0.03,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.015),
                  child: SvgPicture.asset(
                    'assets/heart_24.svg',
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(255, 255, 255, 255),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.014),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: SizedBox(
                  width: screenWidth * 0.46,
                  child: Text(
                    property.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.003,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/star_24.svg',
                      width: screenWidth * 0.05,
                      height: screenWidth * 0.05,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF37AD5F),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.015),
                    Text(
                      '(29 Reviews)',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.017),
        ],
      ),
    );
  }
}
