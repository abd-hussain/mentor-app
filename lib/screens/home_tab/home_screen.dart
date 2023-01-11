import 'package:flutter/material.dart';
import 'package:mentor_app/screens/home_tab/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
