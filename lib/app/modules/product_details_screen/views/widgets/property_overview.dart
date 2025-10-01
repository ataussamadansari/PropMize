import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/data/models/properties/data.dart';

class PropertyOverView extends StatelessWidget
{
  final Data? data;
  const PropertyOverView({super.key, this.data});

  @override
  Widget build(BuildContext context)
  {
    return Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
            border: BoxBorder.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
            borderRadius: BorderRadius.circular(8.0),
            color: context.theme.cardColor,
            /*boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 10,
                  offset: const Offset(1, 1)
              )
            ]*/
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Property Overview", style: context.textTheme.headlineSmall),
              // Divider(color: context.theme.colorScheme.surfaceContainerHighest),
              Row(
                  children: [
                    PropertyOverviewCardItem(title: "Bedrooms", value: data?.bedrooms.toString(), icon: Icons.bed),
                    SizedBox(width: 8),
                    PropertyOverviewCardItem(title: "Bathrooms", value: data?.bathrooms.toString(), icon: Icons.bathtub_outlined)
                  ]
              ),
              SizedBox(height: 8),
              Row(
                  children: [
                    PropertyOverviewCardItem(title: "Area", value: "${data?.area?.value ?? 'N/A'} ${data?.area?.unit ?? ''}", icon: Icons.square_foot),
                    SizedBox(width: 8),
                    PropertyOverviewCardItem(title: "Parking", value: data?.parking.toString(), icon: Icons.local_parking)
                  ]
              ),
              SizedBox(height: 8),
              Row(
                  children: [
                    PropertyOverviewCardItem(title: "Balconies", value: data?.balconies.toString(), icon: Icons.balcony),
                    SizedBox(width: 8),
                    PropertyOverviewCardItem(title: "Floor", value: "${data?.floor ?? ''} ${data?.totalFloors != null ? 'of ${data?.totalFloors}' : ''}", icon: CupertinoIcons.building_2_fill)
                  ]
              ),
              SizedBox(height: 8),
              Row(
                  children: [
                    PropertyOverviewCardItem(title: "Age", value: "${data?.age} Years", icon: Icons.calendar_month_outlined),
                    SizedBox(width: 8),
                    PropertyOverviewCardItem(title: "Furnishing", value: data?.furnished.toString(), icon: CupertinoIcons.home)
                  ]
              )
            ]
        )

    );
  }
}

class PropertyOverviewCardItem extends StatelessWidget
{
  final String? title;
  final String? value;
  final IconData? icon;
  const PropertyOverviewCardItem({super.key, this.title, this.value, this.icon});

  @override
  Widget build(BuildContext context)
  {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: BoxBorder.all(color: context.theme.colorScheme.surfaceContainerHighest, width: 1),
                borderRadius: BorderRadius.circular(8.0),
                color: context.theme.cardColor
            ),
            child: Column(
                children: [
                  Icon(icon ?? Icons.home, size: 32, color: Colors.blue),
                  if (title != null)
                    Text(title!, style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  Text(value ?? "N/A", style: context.textTheme.headlineSmall)
                ]
            )
        )
    );
  }
}