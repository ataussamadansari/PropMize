import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/modules/assistant_chat_screen/controllers/assistant_chat_controller.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/capitalize.dart';

class HeaderView extends GetView<AssistantChatController>
{
    final dynamic isLoggedIn;
    final dynamic user;
    final dynamic avatarUrl;
    const HeaderView({
      super.key,
      required this.isLoggedIn,
      required this.user,
      required this.avatarUrl
    });

    @override
    Widget build(BuildContext context) 
    {
        return isLoggedIn ? Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 24.0, bottom: 8.0),
            child: Column(
                children: [
                  if (controller.authController.profile.value?.data != null) ...[

                    /*CircleAvatar(
                         radius: 38,
                         backgroundColor: Colors.deepOrange,
                         backgroundImage: NetworkImage(avatarUrl),
                         child: Text(
                             (controller.authController.profile.value?.data?.name?.isNotEmpty == true
                                 ? controller.authController.profile.value!.data!.name!.substring(0, 1).toUpperCase()
                                 : "U"),
                             style: context.textTheme.displayLarge?.copyWith(color: Colors.white)
                         )
                     ),*/

                    /*CircleAvatar(
                        radius: 38,
                        backgroundColor: avatarUrl.isNotEmpty ? AppColors.primary : Colors.deepOrange,

                        // ✅ Agar avatarUrl available hai to network image show hoga
                        backgroundImage:
                        avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,

                        // ✅ Agar image URL empty hai to fallback letter show hoga
                        child: avatarUrl.isEmpty
                            ? Text(
                            (user?.name?.isNotEmpty == true
                                ? user!.name!.substring(0, 1).toUpperCase()
                                : "U"),
                            style: context.textTheme.displayLarge?.copyWith(
                                color: Colors.white
                            )
                        )
                            : null
                    ),*/

                    CircleAvatar(
                      radius: 38,
                      backgroundColor: avatarUrl.isNotEmpty ? AppColors.white : Colors.deepOrange,
                      child: avatarUrl.isNotEmpty
                          ? ClipOval(
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/logo.png'), // Add a placeholder image
                          image: NetworkImage(avatarUrl),
                          fit: BoxFit.cover,
                          width: 76,
                          height: 76,
                          imageErrorBuilder: (context, error, stackTrace) => Text(
                            (user?.name?.isNotEmpty == true
                                ? user!.name!.substring(0, 1).toUpperCase()
                                : "U"),
                            style: context.textTheme.displayLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          : Text(
                        (user?.name?.isNotEmpty == true
                            ? user!.name!.substring(0, 1).toUpperCase()
                            : "U"),
                        style: context.textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                        controller.authController.profile.value?.data?.name ?? "User",
                        style: context.textTheme.headlineMedium,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false
                    ),

                    Text(
                        controller.authController.profile.value?.data?.email ?? "---",
                        style: context.textTheme.labelMedium,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false
                    ),

                    const SizedBox(height: 8),
                    Text(
                        capitalize(controller.authController.profile.value?.data?.role ?? "Not Available"),
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)
                    )
                  ]
                ]
            )
        ) : SizedBox.shrink();
    }
}
