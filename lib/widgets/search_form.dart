/*
 ///  Author: Minh Thao Nguyen
 ///  Create Time: 2021-11-14 11:29:57
 ///  Modified by: Minh Thao Nguyen
 ///  Modified time: 2021-11-20 03:26:50
 ///  Description:
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchForm extends StatelessWidget {
  SearchForm({
    Key? key,
  }) : super(key: key);
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextFormField(
        controller: _controller,
        style: const TextStyle(
            fontSize: 18.0, fontFamily: "Roboto", color: Color(0xff727EE0)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
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
          hintText: "Search...",
          hintStyle: const TextStyle(
              fontSize: 18.0, fontFamily: "Roboto", color: Color(0xffB0B5DD)),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset('assets/icons/search_icon.svg'),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
                onTap: _controller.clear,
                child: SvgPicture.asset('assets/icons/cancel_icon.svg')),
          ),
        ),
      ),
    );
  }
}
