import 'package:flutter/material.dart';

typedef ItemLabel<T> = String Function(T item);
typedef ItemKey<T> = String Function(T item);

class SearchableListSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final ItemLabel<T> labelOf;
  final ItemKey<T>? keyOf;
  final void Function(T selected) onSelected;
  final String hintText;
  final bool enableDivider;
  final bool autofocus; // NEW

  const SearchableListSheet({
    super.key,
    required this.title,
    required this.items,
    required this.labelOf,
    required this.onSelected,
    this.keyOf,
    this.hintText = 'Tìm theo tên...',
    this.enableDivider = true,
    this.autofocus = false, // tránh tự bật KB gây overflow
  });

  @override
  State<SearchableListSheet<T>> createState() => _SearchableListSheetState<T>();
}

class _SearchableListSheetState<T> extends State<SearchableListSheet<T>> {
  final _ctrl = TextEditingController();
  late List<T> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = [...widget.items];
    _ctrl.addListener(_apply);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_apply);
    _ctrl.dispose();
    super.dispose();
  }

  void _apply() {
    final q = _ctrl.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = [...widget.items];
      } else {
        _filtered = widget.items.where((e) {
          final text = widget.labelOf(e).toLowerCase();
          final id = widget.keyOf?.call(e).toLowerCase() ?? '';
          return text.contains(q) || id.contains(q);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.8,
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
                        Expanded(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                    child: TextField(
                      controller: _ctrl,
                      autofocus: widget.autofocus, // NEW
                      decoration: InputDecoration(
                        hintText: widget.hintText,
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => widget.enableDivider
                          ? const Divider(height: 1, color: Color(0xFFF1F5F9))
                          : const SizedBox.shrink(),
                      itemBuilder: (_, i) {
                        final it = _filtered[i];
                        return ListTile(
                          title: Text(widget.labelOf(it)),
                          onTap: () {
                            widget.onSelected(it);
                            Navigator.pop(context);
                          },
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
