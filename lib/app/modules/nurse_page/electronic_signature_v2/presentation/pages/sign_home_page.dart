import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_detail_page.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_documents_page.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature_v2/presentation/pages/sign_document_type_page.dart';
import '../../../../../../constant/color.dart';
import '../../../../../../di/locator.dart';
import '../../data/filter_signature_model.dart';
import '../../data/repositories/signature_repository.dart';
import '../cubits/departments_cubit/departments_cubit.dart';
import '../cubits/documents_cubit/documents_cubit.dart';
import '../cubits/filters_cubit/filters_cubit.dart';
import '../cubits/filters_cubit/filters_state.dart';
import '../cubits/roles_cubit/roles_cubit.dart';
import '../cubits/patients_cubit/patients_cubit.dart';
import '../cubits/sign_action_cubit/sign_action_cubit.dart';
import '../widgets/empty_view.dart';
import 'package:pstb/app/models/document_type_model.dart';
import 'package:get_it/get_it.dart';

class SignHomePage extends StatefulWidget {
  final String userName;
  const SignHomePage({super.key, required this.userName});

  @override
  State<SignHomePage> createState() => _SignHomePageState();
}

class _SignHomePageState extends State<SignHomePage>
    with TickerProviderStateMixin {
  final _searchCtrl = TextEditingController();
  Timer? _debounce;
  late final TabController _tabController;

  // MỚI: Thời gian mặc định 30 ngày
  DateTime? _fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime? _toDate = DateTime.now();

  // Đổi thứ tự tab: Chưa ký → Đã ký → Tất cả
  final List<String?> _statuses = ['unsigned', 'signed', null]; // ĐẢO NGƯỢC!

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: 0); // Mở tab "Chưa ký"

    // Load với 30 ngày mặc định
    context.read<FiltersCubit>().add(LoadEvent(
          userName: widget.userName,
          fromDate: _formatDateVN(_fromDate!),
          toDate: _formatDateVN(_toDate!),
        ));

    serviceLocator<DepartmentsCubit>().load();
    _searchCtrl.addListener(_onSearchChanged);
  }

  // String _formatDate(DateTime? date) => date == null
  //     ? ''
  //     : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  // NÚT CHỌN THỜI GIAN SIÊU ĐẸP
  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDateRange: DateTimeRange(start: _fromDate!, end: _toDate!),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E7FFF),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fromDate = picked.start;
        _toDate = picked.end;
      });

      context.read<FiltersCubit>().add(LoadEvent(
            userName: widget.userName,
            fromDate: _formatDateVN(picked.start),
            toDate: _formatDateVN(picked.end),
          ));
    }
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    _debounce?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {}); // Rebuild để filter
    });
  }

  List<TypeDocumentModel> _filterTypes(List<TypeDocumentModel> types) {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return types;
    return types
        .where((t) => (t.name ?? '').toLowerCase().contains(q))
        .toList();
  }

  String _getDisplayDate() {
    if (_fromDate == null) return 'Tất cả';
    final days = DateTime.now().difference(_fromDate!).inDays;
    if (days == 6) return '7 ngày';
    if (days == 29) return '30 ngày';
    return '${_fromDate!.day}/${_fromDate!.month}';
  }

  String _getFullDateDisplay() {
    if (_fromDate == null || _toDate == null) return 'Tất cả thời gian';
    return '${_formatDateVN(_fromDate!)} → ${_formatDateVN(_toDate!)}';
  }

// ĐỊNH DẠNG CHO BE: dd/MM/yyyy
  String _formatDateVN(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '!',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            tooltip: 'Lọc theo ngày',
          ),
          const SizedBox(width: 8),
        ],
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ký số điện tử',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: -0.5)),
            Text('Xin chào, ${widget.userName}',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.85))),
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
                        Colors.white.withOpacity(0.1),
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
                            const Text(
                              'Đang lọc theo ngày',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getFullDateDisplay(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Thay đổi',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: _buildSearchBar()),
              BlocSelector<FiltersCubit, FiltersState, Map<String, int>>(
                selector: (state) => state.totalCounts,
                builder: (context, counts) {
                  return Material(
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
                  );
                },
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF1E7FFF), Color(0xFF0D47A1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<FiltersCubit, FiltersState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.docTypes != current.docTypes ||
            previous.typeCounts != current.typeCounts ||
            previous.totalCounts != current.totalCounts,
        builder: (context, state) {
          if (state.status == FiltersStatus.loading) {
            return _buildLoadingState();
          }
          if (state.status == FiltersStatus.failure) {
            return _buildErrorState(context);
          }

          return TabBarView(
            controller: _tabController,
            children: _statuses.map((statusKey) {
              return _TabContent(
                key: ValueKey('tab_$statusKey'),
                statusKey: statusKey,
                userName: widget.userName,
                searchQuery: _searchCtrl.text.trim().toLowerCase(),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: _searchCtrl,
        textInputAction: TextInputAction.search,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: 'Tìm loại tài liệu...',
          hintStyle:
              TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
          prefixIcon: Icon(Icons.search,
              color: Colors.white.withOpacity(0.7), size: 20),
          suffixIcon: _searchCtrl.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close,
                      color: Colors.white.withOpacity(0.7), size: 20),
                  onPressed: () {
                    _searchCtrl.clear();
                    _onSearchChanged();
                  },
                ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.3))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 2)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.12),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: 8,
      itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 8), child: _SkeletonItem()),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return EmptyView(
      title: 'Lỗi khi tải',
      message: 'Không thể tải dữ liệu. Vui lòng thử lại.',
      icon: Icons.error_outline,
      action: ElevatedButton.icon(
        onPressed: () => context
            .read<FiltersCubit>()
            .add(LoadEvent(userName: widget.userName)),
        icon: const Icon(Icons.refresh, color: AppColors.whiteColor),
        label: const Text('Thử lại',
            style: TextStyle(color: AppColors.whiteColor)),
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E7FFF)),
      ),
    );
  }

  Tab _tab(String label, int count) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15))),
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
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E7FFF))),
          ),
        ],
      ),
    );
  }
}

// MARK: - Tab Content Widget (Fix crash + giữ scroll)
// MARK: - Tab Content Widget (LAZY LOAD + SHIMMER + ScrollController)
class _TabContent extends StatefulWidget {
  final String? statusKey;
  final String userName;
  final String searchQuery;

  const _TabContent({
    Key? key,
    required this.statusKey,
    required this.userName,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<_TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<_TabContent> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.9) {
      final cubit = context.read<FiltersCubit>();
      context.read<FiltersCubit>().add(LoadMoreEvent(
            userName: widget.userName,
            fromDate: cubit.state.lastFromDate,
            toDate: cubit.state.lastToDate,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FiltersCubit, FiltersState, List<TypeDocumentModel>>(
      selector: (state) => state.docTypes,
      builder: (context, docTypes) {
        final String countKey = widget.statusKey ?? 'all';

        final filtered = widget.searchQuery.isEmpty
            ? docTypes
            : docTypes
                .where((t) =>
                    (t.name ?? '').toLowerCase().contains(widget.searchQuery))
                .toList();
        filtered.sort((a, b) {
          final countA = context
                  .read<FiltersCubit>()
                  .state
                  .typeCounts[a.code ?? '']?[countKey] ??
              0;
          final countB = context
                  .read<FiltersCubit>()
                  .state
                  .typeCounts[b.code ?? '']?[countKey] ??
              0;
          return countB.compareTo(countA); // Giảm dần
        });
        final isLoadingMore = context.read<FiltersCubit>().state.status ==
            FiltersStatus.loadingMore;

        if (filtered.isEmpty && !isLoadingMore) {
          return const EmptyView(
            title: 'Không tìm thấy',
            message: 'Không có loại tài liệu nào phù hợp.',
            icon: Icons.search_off,
          );
        }

        return RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.whiteColor,
          onRefresh: () async {
            context
                .read<FiltersCubit>()
                .add(LoadEvent(userName: widget.userName));
          },
          child: ListView.builder(
            controller: _scrollController, // DÒNG DUY NHẤT CẦN THÊM
            key: PageStorageKey<String>(
                'tab_${widget.userName}_${widget.statusKey ?? 'all'}'),
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: filtered.length + (isLoadingMore ? 3 : 0),
            itemExtent: 72,
            cacheExtent: 300,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemBuilder: (context, index) {
              // SHIMMER KHI ĐANG LOAD MORE
              if (index >= filtered.length) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: _SkeletonItem(),
                );
              }

              final type = filtered[index];
              final String countKey = widget.statusKey ?? 'all';
              final int count = context
                      .read<FiltersCubit>()
                      .state
                      .typeCounts[type.code ?? '']?[countKey] ??
                  0;

              if (count == 0) return const SizedBox.shrink();

              return _DocumentTypeItem(
                key: ValueKey('${type.code}_${widget.statusKey}'),
                type: type,
                userName: widget.userName,
                statusKey: widget.statusKey,
                documentCount: count,
                onTap: () =>
                    _navigate(context, type, widget.statusKey, widget.userName),
              );
            },
          ),
        );
      },
    );
  }

  void _navigate(BuildContext context, TypeDocumentModel type,
      String? statusKey, String userName) {
    final page = statusKey == null
        ? SignDocumentTypePage(userName: userName, docType: type)
        : SignDocumentsPage(
            userName: userName, docType: type, statusKey: statusKey);
    serviceLocator<DepartmentsCubit>().load();
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (_, __, ___) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<FiltersCubit>(),
          ),
          // BlocProvider(
          //   create: (_) {
          //     final cubit = FiltersCubit();
          //     cubit.add(LoadEvent(userName: userName));
          //     return cubit;
          //   },
          // ),
          //BlocProvider.value(value: context.read<DepartmentsCubit>()),
          BlocProvider(create: (_) => DocumentsCubit()),
          BlocProvider(create: (_) => RolesCubit()),
          BlocProvider(create: (_) => SignActionCubit()),
          BlocProvider(create: (_) => PatientsCubit()),
        ],
        child: page,
      ),
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        );
      },
    ));
  }
}

// MARK: - Document Item (Stateless + No Animation = 60 FPS)
class _DocumentTypeItem extends StatelessWidget {
  final TypeDocumentModel type;
  final String userName;
  final String? statusKey;
  final int documentCount;
  final VoidCallback onTap;

  const _DocumentTypeItem({
    Key? key,
    required this.type,
    required this.userName,
    required this.statusKey,
    required this.documentCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
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
                    type.name ?? type.code ?? 'N/A',
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$documentCount',
                    style: const TextStyle(
                        color: Color(0xFF1E7FFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// MARK: - Skeleton
class _SkeletonItem extends StatelessWidget {
  const _SkeletonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12))),
          const SizedBox(width: 16),
          Expanded(
              child: Container(
            height: 16,
            color: Colors.grey.shade300,
          )),
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 28,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
