import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Screens/search_and_catalog_1.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome_background.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Homzes",
                        style: GoogleFonts.robotoFlex(
                          color: Colors.white,
                          fontSize: screenWidth * 0.065,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: screenWidth * 0.004),
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
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.373),
                  Center(
                    child: Text(
                      'Find the best\nplace for you',
                      style: GoogleFonts.robotoFlex(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildOptionCard('assets/rent_home_24.svg', "Rent",
                            const Color(0xFFF5E1C2), screenWidth, screenHeight),
                        SizedBox(width: screenWidth * 0.03),
                        _buildOptionCard('assets/buy_home_24.svg', "Buy",
                            const Color(0xFFF0F298), screenWidth, screenHeight),
                        SizedBox(width: screenWidth * 0.03),
                        _buildOptionCard('assets/sell_home_24.svg', "Sell",
                            const Color(0xFFC6E7BE), screenWidth, screenHeight),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SearchCatalog1Screen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF37AD5F),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.27,
                            vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.08),
                        ),
                      ),
                      child: Text(
                        'Create an account',
                        style: GoogleFonts.robotoFlex(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String svgAsset, String title, Color color,
      double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.37,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.037),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: SvgPicture.asset(
              svgAsset,
              width: screenWidth * 0.055,
              height: screenWidth * 0.055,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.06), 
          Align(
            alignment: Alignment.bottomLeft, 
            child: Text(
              title,
              style: GoogleFonts.robotoFlex(
                fontSize: screenWidth * 0.042,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
