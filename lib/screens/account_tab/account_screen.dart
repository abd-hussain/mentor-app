import 'package:flutter/material.dart';
import 'package:mentor_app/screens/account_tab/account_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final bloc = AccountBloc();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
