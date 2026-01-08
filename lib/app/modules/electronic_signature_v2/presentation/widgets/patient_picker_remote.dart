// widgets/patient_picker_remote.dart  (MỚI)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/patients_cubit/patients_cubit.dart';
import '../cubits/patients_cubit/patients_state.dart';
import '../../../../../../constant/color.dart';
import '../../presentation/pages/sign_home_page.dart' show PickValue;
import 'filter_bar.dart';

class PatientPickerRemote extends StatefulWidget {
  const PatientPickerRemote({super.key});

  @override
  State<PatientPickerRemote> createState() => _PatientPickerRemoteState();
}

class _PatientPickerRemoteState extends State<PatientPickerRemote> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (!_scroll.hasClients) return;
      if (_scroll.position.maxScrollExtent - _scroll.position.pixels <= 240) {
        context.read<PatientsCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) {
            return Material(
              color: Colors.white,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text('Chọn bệnh nhân',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                    child: TextField(
                      controller: _ctrl,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Nhập ≥ 2 ký tự để tìm...',
                        prefixIcon: const Icon(Icons.search),
                        isDense: true,
                        filled: true,
                        fillColor: const Color(0xFFF7F9FC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFF1E7FFF), width: 2),
                        ),
                      ),
                      onChanged: (v) =>
                          context.read<PatientsCubit>().searchDebounced(v),
                      onSubmitted: (v) =>
                          context.read<PatientsCubit>().search(v),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: BlocBuilder<PatientsCubit, PatientsState>(
                      builder: (context, st) {
                        if (st.keyword.length < 2) {
                          return const _Hint(
                              'Nhập tối thiểu 2 ký tự để tìm bệnh nhân');
                        }
                        if (st.status == PatientsStatus.loading &&
                            st.items.isEmpty) {
                          return const _Loading();
                        }
                        if (st.status == PatientsStatus.failure &&
                            st.items.isEmpty) {
                          return _Hint(st.error ?? 'Không thể tải dữ liệu');
                        }
                        if (st.items.isEmpty) {
                          return const _Hint(
                              'Không tìm thấy bệnh nhân phù hợp');
                        }

                        return Stack(
                          children: [
                            ListView.separated(
                              controller: _scroll,
                              padding: const EdgeInsets.only(bottom: 12),
                              itemCount: st.items.length + (st.hasMore ? 1 : 0),
                              separatorBuilder: (_, __) => const Divider(
                                  height: 1, color: Color(0xFFF1F5F9)),
                              itemBuilder: (_, i) {
                                if (i < st.items.length) {
                                  final p = st.items[i];
                                  final title = p.name ?? p.code ?? 'N/A';
                                  final subtitle = p.code ?? '';
                                  return ListTile(
                                    title: Text(title),
                                    subtitle: subtitle.isEmpty
                                        ? null
                                        : Text(subtitle),
                                    onTap: () => Navigator.pop(
                                      context,
                                      PickValue(
                                          p.code ?? '', p.name ?? p.code ?? ''),
                                    ),
                                  );
                                }
                                // loader cuối list
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(
                                            Color(0xFF1E7FFF)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (st.status == PatientsStatus.loadingMore)
                              const Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: LinearProgressIndicator(minHeight: 2),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Color(0xFF1E7FFF)),
        ),
      );
}

class _Hint extends StatelessWidget {
  final String text;
  const _Hint(this.text);

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF6B7280))),
        ),
      );
}
