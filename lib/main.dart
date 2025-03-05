import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionexdigital_flutterdeveloper_homzesystem/Screens/welcome_screen.dart';
import 'Cubits/property_cubit.dart';
import 'Repositories/property_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final propertyRepository = PropertyRepository();

  runApp(MyApp(propertyRepository: propertyRepository));
}

class MyApp extends StatelessWidget {
  final PropertyRepository propertyRepository;

  const MyApp({Key? key, required this.propertyRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PropertyCubit(propertyRepository)..getProperties(),
        ),
      ],
      child: MaterialApp(
        title: 'Homzes App',
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
      ),
    );
  }
}


