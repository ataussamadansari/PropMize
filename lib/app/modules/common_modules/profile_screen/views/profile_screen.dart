import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prop_mize/app/core/themes/app_colors.dart';
import 'package:prop_mize/app/core/utils/DateTimeHelper.dart';
import 'package:prop_mize/app/global_widgets/profile/custom_text_form_fields.dart';
import '../controllers/profile_controller.dart';
import '../../../../data/models/user/user_me.dart';

class ProfileScreen extends GetView<ProfileController>
{
    const ProfileScreen({super.key});

    @override
    Widget build(BuildContext context)
    {
        final user = controller.authController.profile.value?.data;

        return Obx(()
        {
          if (controller.authController.profile.value == null) {
            // return const Center(child: CircularProgressIndicator());
            // return ShimmerProfileView();
          }
          if (controller.isLoading.value) {
            // return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .cardTheme
                          .color,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4)
                        )
                      ]
                  ),
                  child: Column(
                      children: [

                        Stack(
                            children: [
                              // 🔹 Gradient Header
                              Container(
                                  height: 150,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12))
                                  )
                              ),
                              // 🔹 Gradient Header
                              Container(
                                  height: 100,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      gradient: AppColors.primaryGradient
                                  )
                              ),

                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 10,
                                child: Obx(() {
                                  // ✅ Priority: Selected Image > Network Image > Default
                                  final selectedImage = controller.selectedImage.value;
                                  final avatarUrl = controller.avatar.value;

                                  return CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Theme.of(context).cardTheme.color,
                                    child: CircleAvatar(
                                      radius: 38,
                                      backgroundColor: Colors.white,
                                      child: selectedImage != null
                                          ? ClipOval(
                                        child: Image.file(
                                          selectedImage,
                                          fit: BoxFit.cover,
                                          width: 76,
                                          height: 76,
                                        ),
                                      )
                                          : avatarUrl.isNotEmpty
                                          ? ClipOval(
                                        child: FadeInImage(
                                          placeholder: AssetImage('assets/images/logo.png'),
                                          image: NetworkImage(avatarUrl),
                                          fit: BoxFit.cover,
                                          width: 76,
                                          height: 76,
                                          imageErrorBuilder: (context, error, stackTrace) =>
                                              _buildInitials(user),
                                        ),
                                      )
                                          : _buildInitials(user),
                                    ),
                                  );
                                }),
                              ),

                              /*Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 10,
                                  child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Theme
                                          .of(context)
                                          .cardTheme
                                          .color,
                                      child: CircleAvatar(
                                          radius: 38,
                                          backgroundImage: controller
                                              .selectedImage.value != null
                                              ? FileImage(
                                              controller.selectedImage
                                                  .value!) as ImageProvider
                                              : (user?.avatar != null &&
                                              user!.avatar!.isNotEmpty
                                              ? NetworkImage(user.avatar!) // 👈 backend image
                                              : null),

                                          child: (controller.selectedImage
                                              .value == null &&
                                              (user?.avatar == null ||
                                                  user!.avatar!.isEmpty))
                                              ? Text(
                                              (user?.name?.isNotEmpty ==
                                                  true
                                                  ? user!.name!.substring(
                                                  0, 1).toUpperCase()
                                                  : "U"),
                                              style: context.textTheme
                                                  .displayLarge?.copyWith(
                                                  color: Colors.white
                                              )
                                          )
                                              : null
                                      )
                                  )
                              ),*/

                              controller.isEnable.value ?
                              Positioned(
                                  left: 50, right: 0, bottom: 12,
                                  child: InkWell(
                                      onTap: controller.showImageSourceOptions,
                                      child: Container(
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              color: context.theme.cardTheme
                                                  .color,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.1),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 8)
                                                )
                                              ]
                                          ),
                                          child: Icon(
                                              CupertinoIcons.camera, size: 16)
                                      )
                                  )
                              ) : SizedBox.shrink()
                            ]
                        ),

                        // 🔹 Name & Location
                        Text(
                            controller.authController.profile.value!.data
                                ?.name ?? "User",
                            style: context.textTheme.titleLarge
                        ),
                        SizedBox(height: 4),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on, size: 14,
                                  color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                  controller.authController.profile.value?.data
                                      ?.address!.city ?? "Not Provided",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))
                            ]
                        ),
                        const SizedBox(height: 16),

                        // 🔹 Info Cards
                        _infoTile(context, Icons.email, "Email",
                            controller.authController.profile.value!.data!
                                .email ?? "Not Provided"),
                        _infoTile(context, Icons.phone, "Phone",
                            controller.authController.profile.value!.data!
                                .phone ?? "Not provided"),
                        _infoTile(context, Icons.person, "Member since",
                            DateTimeHelper.formatMonthYear(
                                controller.authController.profile.value!.data!
                                    .createdAt ?? "")),

                        const SizedBox(height: 12)
                      ]
                  )
              ),

              const SizedBox(height: 12),

              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .cardTheme
                          .color,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4)
                        )
                      ]
                  ),
                  child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Personal Information',
                            style: context.textTheme.headlineSmall),
                        Text(
                            'Update your personal details and contact information',
                            style: context.textTheme.bodySmall),
                        CustomTextFormFields(
                            label: "Full Name",
                            hint: "Enter your name",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.fullNameController,
                            singleLine: true,
                            focusNode: controller.fullNameFocus,
                            nextFocus: controller.emailFocus
                        ),
                        CustomTextFormFields(
                            label: "Email Address",
                            hint: "Enter your email address",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.emailAddressController,
                            singleLine: true,
                            focusNode: controller.emailFocus,
                            nextFocus: controller.phoneFocus,
                            keyboardType: TextInputType.emailAddress
                        ),
                        CustomTextFormFields(
                            label: "Phone Number",
                            hint: "Enter your phone number",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.phoneNumberController,
                            singleLine: true,
                            focusNode: controller.phoneFocus,
                            nextFocus: controller.bioFocus,
                            keyboardType: TextInputType.phone
                        ),
                        CustomTextFormFields(
                            label: "Bio",
                            hint: "Enter your bio",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.bioController,
                            maxLine: controller.isEnable.value ? 5 : controller
                                .bioController.text.isEmpty ? 1 : 3,
                            singleLine: false,
                            focusNode: controller.bioFocus,
                            keyboardType: TextInputType.multiline
                        ),
                        CustomTextFormFields(
                            label: "City",
                            hint: "Enter your city",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.cityController,
                            singleLine: true,
                            focusNode: controller.cityFocus,
                            nextFocus: controller.streetFocus
                        ),
                        CustomTextFormFields(
                            label: "Street",
                            hint: "Enter your street",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.streetController,
                            singleLine: true,
                            focusNode: controller.streetFocus,
                            nextFocus: controller.zipFocus,
                            keyboardType: TextInputType.streetAddress
                        ),
                        CustomTextFormFields(
                            label: "Zip Code",
                            hint: "Enter your zip code",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.zipCodeController,
                            singleLine: true,
                            focusNode: controller.zipFocus,
                            nextFocus: controller.stateFocus,
                            keyboardType: TextInputType.number
                        ),
                        CustomTextFormFields(
                            label: "State",
                            hint: "Enter your state",
                            obscureText: false,
                            enabled: controller.isEnable.value,
                            controller: controller.stateController,
                            singleLine: true,
                            focusNode: controller.stateFocus
                        )
                      ]
                  )
              )
            ]
        );}
        );
    }

    // 🔹 Reusable Info Tile
    static Widget _infoTile(BuildContext context, IconData icon, String title, String value)
    {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
                children: [
                    Icon(icon, size: 18, color: Colors.grey.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(title,
                                    style: Theme.of(context).textTheme.labelSmall),
                                Text(value,
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w500))
                            ]
                        )
                    )
                ]
            )
        );
    }
    // Helper method for initials
    Widget _buildInitials(Data? user) {
      return Text(
        (user?.name?.isNotEmpty == true
            ? user!.name!.substring(0, 1).toUpperCase()
            : "U"),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      );
    }
}
