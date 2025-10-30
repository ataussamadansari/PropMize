import 'package:flutter/material.dart';

class HeaderWithSearch extends StatelessWidget {
  const HeaderWithSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          'Seller Leads',
          style: Theme.of(context).textTheme.headlineMedium,
        ),

      ],
    );
  }
}
