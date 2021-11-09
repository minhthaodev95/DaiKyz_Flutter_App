import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        style: const TextStyle(
            fontSize: 18.0, fontFamily: "Roboto", color: Color(0xff727EE0)),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          filled: true,
          fillColor: const Color(0xffE0DEDE),
          hintText: "Search for task",
          hintStyle: const TextStyle(
              fontSize: 18.0, fontFamily: "Roboto", color: Color(0xffB0B5DD)),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset('assets/icons/search_icon.svg'),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset('assets/icons/cancel_icon.svg'),
          ),
        ),
      ),
    );
  }
}
