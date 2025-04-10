import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form/Api+Bloc/charachterSplash.dart';
import 'package:form/Api+Bloc/characterRepo.dart';
import 'package:form/Api+Bloc/homescreen.dart';
import 'package:form/Api+Bloc/stateManagement/event.dart';
import 'package:form/Api+Bloc/stateManagement/bloc.dart';
import 'package:form/AudioPlayer/splashScreen.dart';
import 'package:form/AudioPlayer/statemangement/Audio.dart';
import './form/FormValidation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (_) => AudioBloc(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) =>  CharacterBloc(CharacterRepository())..add(LoadCharacters()),
        ),
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Application',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const SplashScreen(), 
      ),
    );
  }
}
