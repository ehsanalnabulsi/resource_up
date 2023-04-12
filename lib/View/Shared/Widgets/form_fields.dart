import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:flutter_custom_selector/widget/flutter_multi_select.dart';

import '../../../core/constant/app_color.dart';

Widget textFormField({
  required TextInputType keyboardType,
  required String? Function(String?) validator,
  IconData? prefixIcon,
  void Function(String)? onChanged,
  String hintText = 'Hint Text',
  double hintTextSize = 14.0,
  String? labelText = '',
  double labelTextSize = 16.0,
  bool isPassowrd = false,
  // bool enabled = true,
  bool readOnly = false,
  IconData? suffixIcon,
  void Function()? suffixPressed,
  void Function()? onTap,
  required TextEditingController controller,
  double padding = 8,
  double verticalPadding = 18.0,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: Text(
            '$labelText',
            style: TextStyle(
              fontSize: labelTextSize,
              color: AppColor.primaryColor,
            ),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          cursorColor: AppColor.primaryColor,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          obscureText: isPassowrd,
          onChanged: (value) => onChanged,
          decoration: InputDecoration(
            // enabledBorder: InputBorder.none,
            alignLabelWithHint: false,
            filled: true,
            fillColor: AppColor.whiteColor,
            focusColor: AppColor.whiteColor,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: hintTextSize,
            ),

            suffixIcon: IconButton(
              color: AppColor.primaryColor,
              onPressed: suffixPressed,
              icon: Icon(suffixIcon),
              iconSize: 24.0,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColor.primaryColor,
              size: 24.0,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: verticalPadding),
            focusedBorder: OutlineInputBorder(
              gapPadding: 5.0,
              borderRadius: BorderRadius.circular(15),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );

Widget dropDownButton(
    {required List<String> dropDownList,
    String selectedItem = 'Select',
    Function? onChange}) {
  return AwesomeDropDown(
    selectedItemTextStyle: TextStyle(fontSize: 13),
    dropDownList: dropDownList,
    isPanDown: true,
    dropDownBottomBorderRadius: 15.0,
    dropDownTopBorderRadius: 15.0,
    dropDownBorderRadius: 15.0,
    elevation: 2.0,
    padding: 12,
    selectedItem: selectedItem,
    onDropDownItemClick: onChange,
    dropDownListTextStyle: const TextStyle(
        color: AppColor.greyColor3,
        fontSize: 16,
        backgroundColor: Colors.transparent),
    numOfListItemToShow: 6,
  );
}

Widget multiSelect({
  required String title,
  required List<String> items,
  required onSelectionDone,
}) =>
    CustomMultiSelectField(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.arrow_forward_ios_outlined),
        filled: true,
        fillColor: AppColor.whiteColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        //alignLabelWithHint: true,
      ),
      title: title,
      items: items,
      enableAllOptionSelect: true,
      onSelectionDone: onSelectionDone,
      //itemAsString: (item) => item.toString(),
    );

Widget tagsField({
  void Function(String)? onChanged,
  required List<String> list,
  String hintText = 'Hint Text',
  double hintTextSize = 14.0,
}) =>
    ChipTags(
      list: list,
      chipColor: AppColor.primaryColor,
      iconColor: Colors.white,
      textColor: Colors.white,
      chipPosition: ChipPosition.below,
      separator: "a",
      createTagOnSubmit: true,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.whiteColor,
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15))),
      keyboardType: TextInputType.text,
    );
