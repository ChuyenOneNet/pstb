// lib/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_home_page_final.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pstb/app/models/document_type_model.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_type_page_v2.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_documents_page_v2.dart';
import '../../../../../../constant/color.dart';
import '../cubits/filters_cubit/filters_cubit.dart';
import '../cubits/filters_cubit/filters_cubit_v2.dart';
import '../cubits/filters_cubit/filters_state_v2.dart';
import '../widgets/empty_view.dart';
import 'sign_documents_page.dart';
import 'sign_document_type_page.dart';
import '../../../../../../di/locator.dart';
import '../cubits/departments_cubit/departments_cubit.dart';
import '../cubits/documents_cubit/documents_cubit.dart';
import '../cubits/roles_cubit/roles_cubit.dart';
import '../cubits/patients_cubit/patients_cubit.dart';
import '../cubits/sign_action_cubit/sign_action_cubit.dart';

class SignHomePageV2 extends StatefulWidget {
  final String userName;
  const SignHomePageV2({super.key, required this.userName});

  @override
  State<SignHomePageV2> createState() => _SignHomePageV2State();
}

class _SignHomePageV2State extends State<SignHomePageV2>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final _searchCtrl = TextEditingController();
  Timer? _debounce;
  late final TabController _tabController;

  DateTime? _fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime? _toDate = DateTime.now();

  final List<String?> _statuses = ['unsigned', 'signed', null];
// trong _SignHomePageV2State
  String _cacheKey(DateTime from, DateTime to) =>
      '${widget.userName}_${_formatDateVN(from)}_${_formatDateVN(to)}';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _searchCtrl.addListener(_onSearchChanged);

    // CACHE SIÊU THÔNG MINH
    final box = Hive.box('sign_cache');
    final key = _cacheKey(_fromDate!, _toDate!);
    final cached = box.get(key);

    if (cached is Map &&
        cached['time'] is DateTime &&
        DateTime.now().difference(cached['time'] as DateTime).inHours < 0.5) {
      // ✅ Đọc payload JSON-friendly
      context
          .read<FiltersCubitV2>()
          .hydrateFromCache(Map<String, dynamic>.from(cached));
    } else {
      _loadData();
    }
    serviceLocator<DepartmentsCubit>().load();
    _scheduleMidnightRefresh();
  }

  void _loadData() {
    context
        .read<FiltersCubitV2>()
        .load(
          userName: widget.userName,
          fromDate: _formatDateVN(_fromDate!),
          toDate: _formatDateVN(_toDate!),
        )
        .then((_) {
      final state = context.read<FiltersCubitV2>().state;
      Hive.box('sign_cache').put(
        _cacheKey(_fromDate!, _toDate!),
        FiltersCubitV2.stateToCache(state),
      );
    });
  }

  void _scheduleMidnightRefresh() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    Timer(tomorrow.difference(now), () {
      if (mounted) _loadData();
    });
  }

  String _formatDateVN(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  String _getFullDateDisplay() =>
      '${_formatDateVN(_fromDate!)} → ${_formatDateVN(_toDate!)}';

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDateRange: DateTimeRange(start: _fromDate!, end: _toDate!),
      locale: const Locale('vi', 'VN'),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF1E7FFF)),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _fromDate = picked.start;
        _toDate = picked.end;
      });
      _loadData();
    }
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => setState(() {}));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _debounce?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _showDateRangePicker,
            icon: Stack(
              children: [
                const Icon(Icons.date_range, size: 26),
                if (_fromDate != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: const Text('!',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ký số điện tử',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text('Xin chào, ${widget.userName}',
                style: TextStyle(
                    fontSize: 13, color: Colors.white.withOpacity(0.85))),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: Column(
            children: [
              if (_fromDate != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.25),
                        Colors.white.withOpacity(0.1)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time_filled,
                          size: 20, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Đang lọc theo ngày',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 11)),
                            Text(_getFullDateDisplay(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _showDateRangePicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text('Thay đổi',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildSearchBar()),
              const SizedBox(height: 12),
              BlocSelector<FiltersCubitV2, FiltersStateV2, Map<String, int>>(
                selector: (s) => s.totalCounts,
                builder: (context, counts) => Material(
                  elevation: 1,
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xFF1E7FFF),
                    unselectedLabelColor: const Color(0xFFB0BEC5),
                    indicator: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFF1E7FFF), width: 3))),
                    tabs: [
                      _tab('Chưa ký', counts['unsigned'] ?? 0),
                      _tab('Đã ký', counts['signed'] ?? 0),
                      _tab('Tất cả', counts['all'] ?? 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1E40AF), const Color(0xFF1E3A8A)]
                  : [const Color(0xFF1E7FFF), const Color(0xFF0D47A1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<FiltersCubitV2, FiltersStateV2>(
        builder: (context, state) {
          if (state.isLoading) return _buildLoading();
          if (state.hasError) return _buildError();

          return TabBarView(
            controller: _tabController,
            children: _statuses
                .map((status) => _TabContent(
                      statusKey: status,
                      userName: widget.userName,
                      searchQuery: _searchCtrl.text.trim().toLowerCase(),
                      fromDate: _fromDate!,
                      toDate: _toDate!,
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() => SizedBox(
        height: 48,
        child: TextField(
          controller: _searchCtrl,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Tìm loại tài liệu...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            suffixIcon: _searchCtrl.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _searchCtrl.clear()),
            filled: true,
            fillColor: Colors.white.withOpacity(0.12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white, width: 2)),
          ),
        ),
      );

  Widget _buildLoading() => ListView.builder(
      itemCount: 8,
      itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 8), child: _SkeletonItem()));
  Widget _buildError() => EmptyView(
        title: 'Lỗi kết nối',
        message: 'Vui lòng kiểm tra mạng',
        action: ElevatedButton.icon(
          onPressed: _loadData,
          icon: const Icon(Icons.refresh),
          label: const Text('Thử lại'),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E7FFF)),
        ),
      );

  Tab _tab(String label, int count) => Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15)),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xFF1E7FFF).withOpacity(0.15),
                  const Color(0xFF1E7FFF).withOpacity(0.08)
                ]),
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: const Color(0xFF1E7FFF).withOpacity(0.2)),
              ),
              child: Text('$count',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF1E7FFF))),
            ),
          ],
        ),
      );
}

// ==================== TAB CONTENT + ITEM + SKELETON ====================
class _TabContent extends StatelessWidget {
  final String? statusKey;
  final String userName;
  final String searchQuery;
  final DateTime fromDate;
  final DateTime toDate;

  const _TabContent(
      {required this.statusKey,
      required this.userName,
      required this.searchQuery,
      required this.fromDate,
      required this.toDate});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FiltersCubitV2, FiltersStateV2,
        Map<TypeDocumentModel, int>>(
      selector: (s) => s.groupedDocuments[statusKey] ?? {},
      builder: (context, map) {
        var list = map.entries.where((e) => e.value > 0).toList();
        if (searchQuery.isNotEmpty) {
          list = list
              .where(
                  (e) => (e.key.name ?? '').toLowerCase().contains(searchQuery))
              .toList();
        }
        list.sort((a, b) => b.value.compareTo(a.value));

        if (list.isEmpty) {
          return const EmptyView(
              title: 'Không có dữ liệu',
              message: 'Thử thay đổi bộ lọc',
              icon: Icons.search_off);
        }

        return RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.whiteColor,
          onRefresh: () async => context.read<FiltersCubitV2>().load(
                userName: userName,
                fromDate:
                    '${fromDate.day.toString().padLeft(2, '0')}/${fromDate.month.toString().padLeft(2, '0')}/${fromDate.year}',
                toDate:
                    '${toDate.day.toString().padLeft(2, '0')}/${toDate.month.toString().padLeft(2, '0')}/${toDate.year}',
              ),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: list.length,
            itemExtent: 72,
            itemBuilder: (_, i) => _DocumentTypeItem(
              type: list[i].key,
              documentCount: list[i].value,
              onTap: () => _navigate(context, list[i].key),
            ),
          ),
        );
      },
    );
  }

  void _navigate(BuildContext context, TypeDocumentModel type) {
    final page = statusKey == null
        ? SignDocumentTypePage(
            userName: userName,
            docType: type,
            initialFromDate: fromDate, // đồng bộ range từ Home
            initialToDate: toDate,
          )
        : SignDocumentsPage(
            userName: userName,
            docType: type,
            statusKey: statusKey!,
            initialFromDate: fromDate, // đồng bộ range từ Home
            initialToDate: toDate,
          );

    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (_, __, ___) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
              value: context.read<FiltersCubitV2>()), // giữ state ở Home
          BlocProvider(create: (_) => DocumentsCubit()),
          BlocProvider(create: (_) => RolesCubit()),
          BlocProvider(create: (_) => SignActionCubit()),
          BlocProvider(create: (_) => PatientsCubit()),
          BlocProvider(
              create: (_) => FiltersCubit()), // cho pickers (dept) ở trang con
        ],
        child: page,
      ),
      transitionsBuilder: (_, a, __, c) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: c,
      ),
    ));
  }
}

class _DocumentTypeItem extends StatelessWidget {
  final TypeDocumentModel type;
  final int documentCount;
  final VoidCallback onTap;
  const _DocumentTypeItem(
      {required this.type, required this.documentCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            height: 64,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xFF1E7FFF).withOpacity(0.2),
                      const Color(0xFF1E7FFF).withOpacity(0.1)
                    ]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.description,
                      color: Color(0xFF1E7FFF), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    type.name ?? 'Unknown',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1E7FFF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('$documentCount',
                      style: const TextStyle(
                          color: Color(0xFF1E7FFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  const _SkeletonItem();
  @override
  Widget build(BuildContext context) => Container(
        height: 64,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      );
}
