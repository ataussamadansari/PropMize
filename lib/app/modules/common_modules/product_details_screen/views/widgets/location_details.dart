import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../data/models/properties/lists/address.dart';
import '../../../../../data/models/properties/lists/near_by_places.dart';

class LocationDetails extends StatelessWidget
{
    final Address? address;
    final NearbyPlaces? nearbyPlaces;

    const LocationDetails({super.key, this.address, this.nearbyPlaces});

    @override
    Widget build(BuildContext context)
    {

        final hasNearbyPlaces = nearbyPlaces != null &&
            ((nearbyPlaces!.schools?.isNotEmpty ?? false) ||
                (nearbyPlaces!.hospitals?.isNotEmpty ?? false) ||
                (nearbyPlaces!.malls?.isNotEmpty ?? false) ||
                (nearbyPlaces!.transport?.isNotEmpty ?? false));

        return Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    width: 1
                ),
                borderRadius: BorderRadius.circular(12.0),
                color: context.theme.cardColor
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Address
                    if (address != null) _AddressInfo(address: address!),

                    // Nearby Places
                    if (hasNearbyPlaces) ...[
                        const SizedBox(height: 4),
                        Text(
                            "Nearby Places",
                            style: context.textTheme.titleLarge?.copyWith(color: AppColors.textSecondary)
                        ),
                        if (nearbyPlaces!.schools?.isNotEmpty ?? false)
                        _NearbyPlacesSection(iconData: Icons.school, title: "Schools", items: nearbyPlaces!.schools),
                        if (nearbyPlaces!.hospitals?.isNotEmpty ?? false)
                        _NearbyPlacesSection(iconData: Icons.local_hospital, title: "Hospitals", items: nearbyPlaces!.hospitals),
                        if (nearbyPlaces!.transport?.isNotEmpty ?? false)
                        _NearbyPlacesSection(iconData: Icons.emoji_transportation_outlined, title: "Transport", items: nearbyPlaces!.transport),
                        if (nearbyPlaces!.malls?.isNotEmpty ?? false)
                        _NearbyPlacesSection(iconData: Icons.local_mall_sharp, title: "Malls", items: nearbyPlaces!.malls)
                    ]
                ]
            )
        );
    }
}

// Address box
class _AddressInfo extends StatelessWidget
{
    final Address address;
    const _AddressInfo({required this.address});

    @override
    Widget build(BuildContext context)
    {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha:0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withValues(alpha:0.3), width: 1)
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const Icon(Icons.location_on_outlined, color: Colors.blue),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    "${address.area}, ${address.city}",
                                    style: context.textTheme.headlineMedium
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    "${address.area}, ${address.state} - ${address.zipCode}",
                                    style: context.textTheme.titleMedium?.copyWith(color: AppColors.textSecondary)
                                ),
                                if (address.landmark != null && address.landmark!.isNotEmpty)
                                Text.rich(
                                    TextSpan(
                                        children: [
                                            TextSpan(
                                                text: "Landmark: ",
                                                style: context.textTheme.titleMedium?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textSecondary
                                                )
                                            ),
                                            TextSpan(
                                                text: address.landmark,
                                                style: context.textTheme.titleMedium?.copyWith(
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.textSecondary
                                                )
                                            )
                                        ]
                                    )
                                )

                            ]
                        )
                    )
                ]
            )
        );
    }
}

class _NearbyPlacesSection extends StatelessWidget
{
    final IconData? iconData;
    final String title;
    final List<dynamic>? items;

    const _NearbyPlacesSection({
        this.iconData,
        required this.title,
        this.items
    });

    @override
    Widget build(BuildContext context)
    {
        if (items == null || items!.isEmpty) return const SizedBox.shrink();

        return Container(
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    width: 1
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: context.theme.cardColor
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        children: [
                            Icon(iconData),
                            const SizedBox(width: 8),
                            Text(
                                title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)
                            )
                        ]
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                        height: 70,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: items!.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index)
                            {
                                final item = items![index];

                                // Default values
                                String name = "-";
                                int distance = 0;
                                String unit = "";

                                // Properly cast based on type
                                if (item is Schools)
                                {
                                    name = item.name ?? "-";
                                    distance = item.distance ?? 0;
                                    unit = item.unit ?? "";
                                }
                                else if (item is Hospitals)
                                {
                                    name = item.name ?? "-";
                                    distance = item.distance ?? 0;
                                    unit = item.unit ?? "";
                                }
                                else if (item is Malls)
                                {
                                    name = item.name ?? "-";
                                    distance = item.distance ?? 0;
                                    unit = item.unit ?? "";
                                }
                                else if (item is Transport)
                                {
                                    name = item.name ?? "-";
                                    distance = item.distance ?? 0;
                                    unit = item.unit ?? "";
                                }

                                return _NearbyPlaceItem(
                                    name: name,
                                    distance: distance,
                                    unit: unit
                                );
                            }
                        )
                    )
                ]
            )
        );
    }
}

class _NearbyPlaceItem extends StatelessWidget
{
    final String name;
    final int distance;
    final String unit;
    const _NearbyPlaceItem({required this.name, required this.distance, required this.unit});
    @override Widget build(BuildContext context)
    {
        return Container(
            padding: const EdgeInsets.all(8), 
            // width: 140,
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.theme.colorScheme.surfaceContainerHighest,
                    width: 1
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(name,
                        style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                        "$distance $unit away",
                        style: context.textTheme.bodySmall
                    )
                ]
            )
        );
    }
}

