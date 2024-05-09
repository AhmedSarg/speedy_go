import 'package:flutter/material.dart';
import 'package:speedy_go/presentation/common/validators/validators.dart';
import 'package:speedy_go/presentation/common/widget/main_button.dart';
import 'dart:math';

import 'package:speedy_go/presentation/common/widget/search_text_field.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';
import 'package:speedy_go/presentation/resources/text_styles.dart';
import 'package:speedy_go/presentation/resources/values_manager.dart';

import '../../viewmodel/add_trip_viewmodel.dart';

class SearchFuncationalityStateFrom extends StatefulWidget {
  const SearchFuncationalityStateFrom({
    super.key,
    required this.viewModel,
  });

  final AddTripViewModel viewModel;

  @override
  State<SearchFuncationalityStateFrom> createState() =>
      _SearchFuncationalityStateState();
}

class _SearchFuncationalityStateState extends State<SearchFuncationalityStateFrom> {
  final List<String> egyptGovernorates = [
    "الإسكندرية",
    "الاسكندرية",
    "البحيرة",
    "الدقهلية",
    "دمياط",
    "الشرقية",
    "الغربية",
    "القليوبية",
    "المنوفية",
    "كفر الشيخ",
    "الأقصر",
    "أسوان",
    "الأسيوط",
    "البحر الأحمر",
    "المنيا",
    "سوهاج",
    "قنا",
    "جامعه سيناء",
    "شمال سيناء",
    "جنوب سيناء",
    "الوادي الجديد",
    "بورسعيد",
    "السويس",
    "القاهرة",
    "الجيزة",
  ];

  bool isSearching = false;
  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = [];
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = [];
        isSearching = false;
      });
      return;
    }

    final normalizedQuery = query.toLowerCase();
    final List<String> searchResults = egyptGovernorates
        .where((governorate) =>
    governorate.toLowerCase().contains(normalizedQuery) ||
        normalizedQuery.contains(governorate.toLowerCase()) ||
        _fuzzyMatch(normalizedQuery, governorate.toLowerCase()))
        .toList();

    setState(() {
      filteredList = searchResults;
      isSearching = searchResults.contains(query);
    });
  }

  bool _fuzzyMatch(String query, String text) {
    final distance = levenshtein(query, text);
    return distance <= 3;
  }

  int levenshtein(String a, String b) {
    final m = a.length, n = b.length;
    var dp = List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));

    for (var i = 0; i <= m; i++) {
      for (var j = 0; j <= n; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else if (a[i - 1] == b[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] =
              1 + _minOfThree(dp[i][j - 1], dp[i - 1][j], dp[i - 1][j - 1]);
        }
      }
    }
    return dp[m][n];
  }

  int _minOfThree(int a, int b, int c) {
    return min(min(a, b), c);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: SearchTextField(
                inputTextStyle: AppTextStyles.busesItemTextSearchStyle(context),
                controller: widget.viewModel.getToSearchController,
                onChanged: (value) {
                  filterSearchResults(value);
                },
                prefixIcon: Icons.search,
                hint: 'Search',
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s50,
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isSearching = true;
                    widget.viewModel.getToSearchController.text =
                    filteredList[index];
                  });
                },
                child: ListTile(
                  title: Text(
                    filteredList[index],
                    style: AppTextStyles.busesItemTextSearchStyle(context),
                  ),
                ),
              );
            },
          ),
        ),
        if (isSearching)
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .35,
              child: AppButton(
                textStyle: AppTextStyles.busesItemTextBottonStyle(context),
                bgColor: ColorManager.lightBlue,
                text: 'Confirm',
                onPressed: () {
                  widget.viewModel.getFromController.text = widget.viewModel.getToSearchController.text;
                  widget.viewModel.getToSearchController.clear();
                  Navigator.pop(context);
                },
              ),
            ),
          ),
      ],
    );
  }
}
