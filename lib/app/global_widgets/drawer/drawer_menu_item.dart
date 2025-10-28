import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';

class DrawerMenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailing;
  final IconData leading;
  final VoidCallback onTap;
  final bool selected;

  const DrawerMenuItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
     this.trailing,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      selectedTileColor: AppColors.primary.withValues(alpha: 0.25),
      dense: true,
      splashColor: AppColors.primaryLight,
      selected: selected,
      leading: Icon(leading),
      title: Text(title, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: context.textTheme.bodySmall),
      trailing: trailing != null ? Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.green.withAlpha(100),
              borderRadius: BorderRadius.circular(12)
          ),
          child: Text(
            trailing!,
            style: TextStyle(color: Colors.green),
          )
      ) : Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}
