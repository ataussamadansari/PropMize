import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/product_details_screen/controllers/product_details_controller.dart';

class PropertyHistorySheet extends GetView<ProductDetailsController>
{
    const PropertyHistorySheet({super.key});

    @override
    Widget build(BuildContext context) 
    {
        final details = controller.details?.data;

        if (details == null) 
        {
            return const SizedBox(
                height: 100,
                child: Center(child: Text("No history available"))
            );
        }

        final views = details.views ?? 0;
        final likes = details.likes?.length ?? 0;
        final listedOn = details.createdAt != null
            ? DateTime.parse(details.createdAt!)
            : null;
        final expiresOn = details.expiresAt != null
            ? DateTime.parse(details.expiresAt!)
            : null;

        return Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6
            ),
            decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    // Drag handle
                    Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2)
                        )
                    ),

                    const Text(
                        "Property History",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    ListTile(
                        leading: const Icon(Icons.remove_red_eye),
                        title: const Text("Views"),
                        trailing: Text("$views")
                    ), ListTile(
                        leading: const Icon(Icons.favorite),
                        title: const Text("Likes"),
                        trailing: Text("$likes")
                    ),
                    if (listedOn != null)
                    ListTile(
                        leading: const Icon(Icons.date_range),
                        title: const Text("Listed On"),
                        trailing:
                        Text("${listedOn.day}-${listedOn.month}-${listedOn.year}")
                    ),

                    if (expiresOn != null)
                    ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text("Expires On"),
                        trailing:
                        Text("${expiresOn.day}-${expiresOn.month}-${expiresOn.year}")
                    )

                ]
            )
        );
    }
}

/*
import 'package:flutter/material.dart';
import 'package:prop_mize/app/data/models/properties/property_by_id_model.dart';


class PropertyHistorySheet extends StatelessWidget {
  final PropertyByIdModel data;
  const PropertyHistorySheet({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final views = data.data?.views ?? 0;
    final likes = data.data?.likes?.length ?? 0;
    final listedOn = data.data?.createdAt != null
        ? DateTime.parse(data.data!.createdAt!)
        : null;
    final expiresOn = data.data?.expiresAt != null
        ? DateTime.parse(data.data!.expiresAt!)
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const Text(
            "Property History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          if (listedOn != null)
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text("Listed On"),
              trailing:
              Text("${listedOn.day}-${listedOn.month}-${listedOn.year}"),
            ),
          ListTile(
            leading: const Icon(Icons.remove_red_eye),
            title: const Text("Views"),
            trailing: Text("$views"),
          ),
          if (expiresOn != null)
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Expires On"),
              trailing:
              Text("${expiresOn.day}-${expiresOn.month}-${expiresOn.year}"),
            ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Likes"),
            trailing: Text("$likes"),
          ),
        ],
      ),
    );
  }
}
*/
