import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatefulWidget {
  final String title, hintText;
  bool isSearch;
  final TextEditingController searchController;
  final VoidCallback? backButtonOnPressed, closeButtonOnPressed;
  final String? Function(String?)? searchTextOnChanged, searchTextOnSubmitted;

  CustomSearchBar(
      {super.key,
      required this.title,
      required this.hintText,
      required this.isSearch,
      required this.searchController,
      this.backButtonOnPressed,
      this.closeButtonOnPressed,
      this.searchTextOnChanged,
      this.searchTextOnSubmitted});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 3,
      title: widget.isSearch
          ? Center(
              child: TextField(
                controller: widget.searchController,
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.xmark,
                      size: 24.sp,
                      color: Colors.black,
                    ),
                    onPressed: widget.closeButtonOnPressed ??
                        () {
                          if (widget.searchController.text.isNotEmpty) {
                            setState(() {
                              widget.searchController.text = "";
                            });
                          }
                        },
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(fontSize: 14.sp),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onChanged: widget.searchTextOnChanged,
                onSubmitted: widget.searchTextOnSubmitted,
              ),
            )
          : Text(widget.title),
      leading: widget.isSearch
          ? IconButton(
              icon: FaIcon(
                FontAwesomeIcons.angleLeft,
                size: 24.sp,
                color: Colors.black,
              ),
              onPressed: widget.backButtonOnPressed ??
                  () {
                    widget.searchController.text = "";
                    setState(() {
                      widget.isSearch = false;
                    });
                  },
            )
          : null,
      actions: [
        Visibility(
          visible: !widget.isSearch,
          child: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 22.sp,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                if (!widget.isSearch) {
                  widget.isSearch = true;
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
