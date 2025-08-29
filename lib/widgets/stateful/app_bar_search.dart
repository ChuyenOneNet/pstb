import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class AppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? iconBack;
  final Color? backgroundColor;
  final Function(String)? onSubmitSearch;
  final Function(FilterObject? valueSortBy, FilterObject? valueCategory,
      FilterObject? valueTime, FilterObject? valuePrice)? onSubmitFilter;

  final List<FilterObject> listSortBy;
  final List<FilterObject> listCategory;
  final List<FilterObject> listTime;
  final List<FilterObject>? listPrice;
  final bool? isShowFilter;
  @override
  final Size preferredSize;
  AppBarSearch({
    Key? key,
    this.title = "",
    this.iconBack = true,
    this.backgroundColor,
    this.onSubmitSearch,
    this.onSubmitFilter,
    this.isShowFilter = false,
    required this.listSortBy,
    required this.listCategory,
    required this.listTime,
    this.listPrice,
  })  : preferredSize = const Size.fromHeight(50.0), // Initialize preferredSize
        super(key: key);

  @override
  _AppBarSearchState createState() => _AppBarSearchState();
}

@override
class _AppBarSearchState extends State<AppBarSearch> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formKeyAppBar = GlobalKey<FormState>();
  bool _isSearching = false;
  bool _isFilting = false;
  String inputText = "";

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void toggleSearching() {
    if (_isFilting) {
      Modular.to.pop('');
    }
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  void toggleFilting() {
    setState(() {
      _isFilting = !_isFilting;
    });
  }

  void onClose() {
    Modular.to.pop('');
  }

  void onApplyFilter(FilterObject? valueSortBy, FilterObject? valueCategory,
      FilterObject? valueTime, FilterObject? valuePrice) {
    widget.onSubmitFilter!(valueSortBy, valueCategory, valueTime, valuePrice);
    Modular.to.pop('');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _isSearching
          ? buildSearchField()
          : Text(
              widget.title!,
              style: Styles.heading4.copyWith(color: AppColors.background),
            ),
      backgroundColor: widget.backgroundColor ?? AppColors.primary,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 35,
      leading: widget.iconBack ?? false
          ? TouchableOpacity(
              onTap: () => Modular.to.pop(''),
              child: Container(
                color: AppColors.transparent,
                child: const Icon(
                  Icons.chevron_left,
                  size: 36,
                  color: AppColors.background,
                ),
              ),
            )
          : const SizedBox(),
      actions: <Widget>[
        _isSearching
            ? const SizedBox()
            : SizedBox(
                width: widthConvert(context, 55),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    const VerticalDivider(
                      width: 1,
                      color: AppColors.background,
                      endIndent: 10,
                      indent: 10,
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        IconEnums.search,
                        color: AppColors.background,
                      ),
                      onPressed: toggleSearching,
                    ),
                  ],
                ),
              ),
        widget.isShowFilter == true
            ? Container(
                width: 40,
                margin: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: SvgPicture.asset(
                    IconEnums.filter,
                    color: AppColors.background,
                  ),
                  onPressed: () => {
                    FocusManager.instance.primaryFocus?.unfocus(),
                    toggleSearching(),
                    _isFilting
                        ? onClose()
                        : {
                            showBottomSheet(
                              context: context,
                              builder: (context) => BuildFilterBottomSheet(
                                onClose: onClose,
                                onApplyFilter: onApplyFilter,
                                listSortBy: widget.listSortBy,
                                listCategory: widget.listCategory,
                                listTime: widget.listTime,
                                listPrice: widget.listPrice,
                              ),
                              backgroundColor: AppColors.transparent,
                            ).closed.whenComplete(
                                  () => {toggleFilting()},
                                ),
                            toggleFilting()
                          },
                  },
                ),
              )
            : SizedBox(width: _isSearching ? 50 : 20),
      ],
    );
  }

  Widget buildSearchField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Form(
        key: _formKeyAppBar,
        child: TextFormField(
          controller: _textEditingController,
          style: Styles.heading4.copyWith(color: AppColors.background),
          onChanged: (value) {
            setState(() {
              inputText = value;
            });
          },
          onFieldSubmitted: widget.onSubmitSearch,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n(context)!.search,
            hintStyle: Styles.heading4.copyWith(color: AppColors.background),
            contentPadding: const EdgeInsets.only(top: 20),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.background)),
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.background)),
            prefixIcon: IconButton(
                icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SvgPicture.asset(
                      IconEnums.search,
                      color: AppColors.background,
                    )),
                onPressed: () {
                  toggleSearching();
                  setState(() {
                    _textEditingController.clear();
                    inputText = "";
                  });
                  widget.onSubmitSearch!('');
                }),
            suffixIcon: inputText != ""
                ? IconButton(
                    icon: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SvgPicture.asset(
                          IconEnums.close,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          color: AppColors.background,
                        )),
                    onPressed: () {
                      setState(() {
                        _textEditingController.clear();
                        inputText = "";
                      });
                    })
                : null,
          ),
        ),
      ),
    );
  }
}

class BuildFilterBottomSheet extends StatefulWidget {
  final Function onClose;
  final Function onApplyFilter;
  final List<FilterObject> listSortBy;
  final List<FilterObject> listCategory;
  final List<FilterObject> listTime;
  final List<FilterObject>? listPrice;

  const BuildFilterBottomSheet({
    Key? key,
    required this.onClose,
    required this.onApplyFilter,
    required this.listSortBy,
    required this.listCategory,
    required this.listTime,
    this.listPrice,
  }) : super(key: key);

  @override
  _BuildFilterBottomSheetState createState() => _BuildFilterBottomSheetState();
}

class _BuildFilterBottomSheetState extends State<BuildFilterBottomSheet> {
  final _formKeyFilter = GlobalKey<FormState>();
  FilterObject? valueSortBy;
  FilterObject? valueCategory;
  FilterObject? valueTime;
  FilterObject? valuePrice;

  void onFresh() {
    onChangeValueSortBy(null);
    onChangeValueCategory(null);
    onChangeValueTime(null);
    onChangeValuePrice(null);
  }

  void onChangeValueSortBy(FilterObject? value) {
    setState(() {
      valueSortBy = value;
    });
  }

  void onChangeValueCategory(FilterObject? value) {
    setState(() {
      valueCategory = value;
    });
  }

  void onChangeValueTime(FilterObject? value) {
    setState(() {
      valueTime = value;
    });
  }

  void onChangeValuePrice(FilterObject? value) {
    setState(() {
      valuePrice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: widthConvert(context, 16)),
        margin: EdgeInsets.only(bottom: widthConvert(context, 0)),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              spreadRadius: 8,
              blurRadius: 8,
              offset: Offset(0, -2), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: widthConvert(context, 120),
                    right: widthConvert(context, 120),
                    top: 6),
                child: Container(
                  height: 6,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      color: AppColors.neutral200),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: heightConvert(context, 24),
                  bottom: heightConvert(context, 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TouchableOpacity(
                        child: const SizedBox(
                          width: 70,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.close,
                              color: AppColors.accent700,
                            ),
                          ),
                        ),
                        onTap: () => widget.onClose()),
                    Text(
                      l10n(context)!.search_filter,
                      style: Styles.heading4,
                    ),
                    TouchableOpacity(
                        child: SizedBox(
                          width: 70,
                          child: Text(
                            l10n(context)!.search_fresh,
                            style: Styles.buttonLargeLowercase
                                .copyWith(color: AppColors.primary500),
                          ),
                        ),
                        onTap: () => onFresh()),
                  ],
                ),
              ),
              buildFormFilter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormFilter() {
    return Form(
      key: _formKeyFilter,
      child: Column(
        children: <Widget>[
          AppPicker(
            title: l10n(context)!.search_sortby,
            hint: l10n(context)!.search_sortby_hint,
            icon: IconEnums.trendingUp,
            selectedColorIcon: AppColors.primary500,
            list: widget.listSortBy,
            value: valueSortBy,
            selectedValue: onChangeValueSortBy,
          ),
          AppPicker(
            title: l10n(context)!.search_category,
            hint: l10n(context)!.search_category_hint,
            icon: IconEnums.medicalFolder1,
            selectedColorIcon: AppColors.primary500,
            list: widget.listCategory,
            value: valueCategory,
            selectedValue: onChangeValueCategory,
          ),
          // AppPicker(
          //   title: l10n(context)!.search_time,
          //   hint: l10n(context)!.search_time_hint,
          //   icon: IconEnums.clock,
          //   selectedColorIcon: AppColors.primary500,
          //   list: widget.listTime,
          //   value: valueTime,
          //   selectedValue: onChangeValueTime,
          // ),
          widget.listPrice != null
              ? AppPicker(
                  title: l10n(context)!.search_price,
                  hint: l10n(context)!.search_price_hint,
                  icon: IconEnums.moneyWallet1,
                  selectedColorIcon: AppColors.primary500,
                  list: widget.listPrice!,
                  value: valuePrice,
                  selectedValue: onChangeValuePrice,
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.only(
                top: heightConvert(context, 12),
                bottom: heightConvert(context, 34)),
            child: AppButton(
              title: l10n(context)!.search_apply_filter,
              onPressed: () {
                if (_formKeyFilter.currentState!.validate()) {
                  widget.onApplyFilter(
                      valueSortBy, valueCategory, valueTime, valuePrice);
                }
              },
              isLeftGradient: true,
            ),
          ),
        ],
      ),
    );
  }
}
