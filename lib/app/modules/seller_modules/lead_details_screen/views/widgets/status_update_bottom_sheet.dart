import 'package:flutter/material.dart';

class StatusUpdateBottomSheet extends StatefulWidget {
  final String currentStatus;
  final Function(String) onStatusUpdate;

  const StatusUpdateBottomSheet({
    super.key,
    required this.currentStatus,
    required this.onStatusUpdate,
  });

  @override
  State<StatusUpdateBottomSheet> createState() => _StatusUpdateBottomSheetState();
}

class _StatusUpdateBottomSheetState extends State<StatusUpdateBottomSheet> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Update Lead Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Current Status
          Text(
            "Current Status: ${widget.currentStatus}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // Status Options
          _buildStatusOption("New", Icons.fiber_new, Colors.blue),
          _buildStatusOption("Contacted", Icons.phone, Colors.orange),
          _buildStatusOption("Converted", Icons.check_circle, Colors.green),
          _buildStatusOption("Rejected", Icons.cancel, Colors.red),

          const SizedBox(height: 24),

          // Update Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onStatusUpdate(_selectedStatus);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _getStatusColor(_selectedStatus),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                "Update Status",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(String status, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          status,
          style: TextStyle(
            fontWeight: _selectedStatus == status ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: _selectedStatus == status
            ? Icon(Icons.check_circle, color: color)
            : null,
        tileColor: _selectedStatus == status ? color.withOpacity(0.1) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: _selectedStatus == status ? color : Colors.transparent,
            width: 1.5,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedStatus = status;
          });
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "New":
        return Colors.blue;
      case "Contacted":
        return Colors.orange;
      case "Converted":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}