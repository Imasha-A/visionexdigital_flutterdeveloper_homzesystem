import 'package:flutter/material.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Screens/search_and_catalog_1.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const Spacer(),
              const Text(
                'Find the best\nplace for you',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text('Rent'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text('Buy'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigation to Search & Catalog 1 screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchCatalog1Screen(),
                    ),
                  );
                },
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
