import 'package:doclink_control/search/searchdelegate.dart';
import 'package:flutter/material.dart';

import '../shared/const/const.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: 'Search Patients',
          hintStyle: kTextStyleMediumBlack,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 249, 249),
          focusColor: const Color.fromARGB(255, 231, 229, 229),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              borderRadius: BorderRadius.circular(30))),
      onTap: () =>
          showSearch(context: context, delegate: CustomSearchDelegate()),
    );
  }
}
