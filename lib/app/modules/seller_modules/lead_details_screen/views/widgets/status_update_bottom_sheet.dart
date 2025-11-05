import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // Status options with their display and backend mapping
  final List<Map<String, dynamic>> statusOptions = [
    {'display': 'New', 'icon': Icons.fiber_new, 'color': Colors.blue},
    {'display': 'Contacted', 'icon': Icons.phone, 'color': Colors.orange},
    {'display': 'Interested', 'icon': Icons.thumb_up, 'color': Colors.greenAccent},
    {'display': 'Not Interested', 'icon': Icons.thumb_down, 'color': Colors.amber},
    {'display': 'Converted', 'icon': Icons.check_circle, 'color': Colors.green},
    {'display': 'Lost', 'icon': Icons.error, 'color': Colors.red},
    {'display': 'Rejected', 'icon': Icons.cancel, 'color': Colors.deepOrange},
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Convert backend status to display status for default selection
    _selectedStatus = _convertToDisplayStatus(widget.currentStatus);
    print('🎯 Default selected status: $_selectedStatus');
  }

  /// Convert backend status (lowercase) to display status
  String _convertToDisplayStatus(String backendStatus) {
    final status = backendStatus.toLowerCase();
    return switch(status) {
      'new' => 'New',
      'contacted' => 'Contacted',
      'interested' => 'Interested',
      'not-interested' => 'Not Interested',
      'converted' => 'Converted',
      'lost' => 'Lost',
      'rejected' => 'Rejected',
      _ => backendStatus, // fallback
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 32.0, left: 16.0, right: 16.0, top: 16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
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
            "Current Status: ${_convertToDisplayStatus(widget.currentStatus)}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // Status Options
          ...statusOptions.map((status) => _buildStatusOption(
            status['display'] as String,
            status['icon'] as IconData,
            status['color'] as Color,
          )),

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
    final isSelected = _selectedStatus == status;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        status,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? color : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: color)
          : null,
      tileColor: isSelected ? color.withOpacity(0.1) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: isSelected ? color : Colors.transparent,
          width: 1.5,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedStatus = status;
          print('✅ Selected: $status');
        });
      },
    );
  }

  Color _getStatusColor(String status) {
    return switch(status) {
      'New' => Colors.blue,
      'Contacted' => Colors.orange,
      'Interested' => Colors.greenAccent,
      'Not Interested' => Colors.amber,
      'Converted' => Colors.green,
      'Lost' => Colors.red,
      'Rejected' => Colors.deepOrange,
      _ => Colors.blue,
    };
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusUpdateBottomSheet extends StatefulWidget
{
    final String currentStatus;
    final Function(String) onStatusUpdate;

    const StatusUpdateBottomSheet({
        super.key,
        required this.currentStatus,
        required this.onStatusUpdate
    });

    @override
    State<StatusUpdateBottomSheet> createState() => _StatusUpdateBottomSheetState();
}

class _StatusUpdateBottomSheetState extends State<StatusUpdateBottomSheet>
{
    late String _selectedStatus;

    @override
    void initState() 
    {
        super.initState();
        _selectedStatus = widget.currentStatus;
    }

    @override
    Widget build(BuildContext context) 
    {
        return Container(
            padding: const EdgeInsets.only(bottom: 32.0, left: 16.0, right: 16.0, top: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)
                )
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
                                    fontWeight: FontWeight.bold
                                )
                            ),
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close)
                            )
                        ]
                    ),
                    const SizedBox(height: 16),

                    // Current Status
                    Text(
                        "Current Status: ${widget.currentStatus}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600]
                        )
                    ),
                    const SizedBox(height: 20),

                    // Status Options
                    _buildStatusOption("New", Icons.fiber_new, Colors.blue),
                    _buildStatusOption("Contacted", Icons.phone, Colors.orange),
                    _buildStatusOption("Interested", Icons.thumb_up, Colors.greenAccent),
                    _buildStatusOption("Not Interested", Icons.thumb_down, Colors.amber),
                    _buildStatusOption("Converted", Icons.check_circle, Colors.green),
                    _buildStatusOption("Lost", Icons.error, Colors.red),
                    _buildStatusOption("Rejected", Icons.cancel, Colors.deepOrange),

                    const SizedBox(height: 24),

                    // Update Button
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: ()
                            {
                                widget.onStatusUpdate(_selectedStatus);
                                Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _getStatusColor(_selectedStatus),
                                padding: const EdgeInsets.symmetric(vertical: 16.0)
                            ),
                            child: const Text(
                                "Update Status",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                )
                            )
                        )
                    )
                ]
            )
        );
    }

    Widget _buildStatusOption(String status, IconData icon, Color color) 
    {
        return ListTile(
            leading: Icon(icon, color: color),
            title: Text(
                status,
                style: TextStyle(
                    fontWeight: _selectedStatus == status ? FontWeight.bold : FontWeight.normal
                )
            ),
            trailing: _selectedStatus == status
                ? Icon(Icons.check_circle, color: color)
                : null,
            tileColor: _selectedStatus == status ? color.withValues(alpha: 0.1) : null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                    color: _selectedStatus == status ? color : Colors.transparent,
                    width: 1.5
                )
            ),
            onTap: ()
            {
                setState(()
                    {
                        _selectedStatus = status;
                    }
                );
            }
        );
    }

    Color _getStatusColor(String status) 
    {
        switch (status)
        {
            case "New":
                return Colors.blue;
            case "Contacted":
                return Colors.orange;
            case "Converted":
                return Colors.green;
            case "Interested":
                return Colors.greenAccent;
            case "Not Interested":
                return Colors.amber;
            case "Lost":
                return Colors.red;
            case "Rejected":
                return Colors.deepOrange;
            default:
            return Colors.blue;
        }
    }
}
*/
