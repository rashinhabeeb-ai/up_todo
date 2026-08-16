import 'package:flutter/material.dart';

class PriorityDialog extends StatefulWidget {
  final int initialPriority;

  const PriorityDialog({
    super.key,
    this.initialPriority = 1,
  });

  static Future<int?> show(BuildContext context, {int initialPriority = 1, DateTime? initialDate}) {
    return showDialog<int>(
      context: context,
      builder: (context) => PriorityDialog(initialPriority: initialPriority),
    );
  }

  @override
  State<PriorityDialog> createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  late int _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF363636),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      titlePadding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      actionsPadding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      title: const Column(
        children: [
          Text(
            'Task Priority',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Divider(color: Colors.white70,),
        ],
      ),
      content: SizedBox(
        width: 300,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final priorityNumber = index + 1;
            final isSelected = priorityNumber == _selectedPriority;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPriority = priorityNumber;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF8687E7) : const Color(0xFF272727),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.outlined_flag,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$priorityNumber',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF8687E7),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, _selectedPriority),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8687E7),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}