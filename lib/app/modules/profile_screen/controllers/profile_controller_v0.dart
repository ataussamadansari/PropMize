import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth_screen/controllers/auth_controller.dart';

class ProfileController extends GetxController {

  final AuthController authController = Get.find<AuthController>();

  final RxBool isVisible = false.obs;
  var selectedIndex = 0.obs;
  final RxBool isEnable = false.obs;
  RxBool emailNotifications = true.obs;
  RxBool pushNotifications = true.obs;
  RxBool smsNotifications = true.obs;

  // Property preferences
  var preferredPropertyTypes = ''.obs;
  var priceRangeMin = ''.obs;
  var priceRangeMax = ''.obs;
  var preferredLocations = ''.obs;

  // Profile preferences
  var fullName = ''.obs;
  var emailAddress = ''.obs;
  var phoneNumber = ''.obs;
  var bio = ''.obs;
  var city = ''.obs;
  var street = ''.obs;
  var zipCode = ''.obs;
  var state = ''.obs;

  // Activity
  var savedProperties = 0.obs;
  var viewedProperties = 0.obs;
  var contactedOwners = 0.obs;
  var notifications = 0.obs;


  // TextEditingControllers
  late TextEditingController propertyTypesController;
  late TextEditingController priceMinController;
  late TextEditingController priceMaxController;
  late TextEditingController locationsController;

  late TextEditingController fullNameController;
  late TextEditingController emailAddressController;
  late TextEditingController phoneNumberController;
  late TextEditingController bioController;
  late TextEditingController cityController;
  late TextEditingController streetController;
  late TextEditingController zipCodeController;
  late TextEditingController stateController;

  // 🔹 FocusNodes
  final fullNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final bioFocus = FocusNode();
  final cityFocus = FocusNode();
  final streetFocus = FocusNode();
  final zipFocus = FocusNode();
  final stateFocus = FocusNode();


  @override
  void onInit() {
    super.onInit();

    authController.me();

    final userData = authController.profile.value?.data;

    if (userData != null) {
      // 🔹 Preferences
      /*preferredPropertyTypes.value = (userData.preferences?.propertyTypes?.isNotEmpty ?? false)
          ? userData.preferences!.propertyTypes!.join(", ")
          : "";*/

      priceRangeMin.value = userData.preferences?.priceRange?.min?.toString() ?? "";
      priceRangeMax.value = userData.preferences?.priceRange?.max?.toString() ?? "";

      preferredLocations.value = (userData.preferences?.locations?.isNotEmpty ?? false)
          ? userData.preferences!.locations!.join(", ")
          : "";

      // 🔹 Controllers for Preferences
      propertyTypesController = TextEditingController(text: preferredPropertyTypes.value);
      priceMinController = TextEditingController(text: priceRangeMin.value);
      priceMaxController = TextEditingController(text: priceRangeMax.value);
      locationsController = TextEditingController(text: preferredLocations.value);

      // 🔹 Profile Info
      fullName.value = userData.name ?? "";
      emailAddress.value = userData.email ?? "";
      phoneNumber.value = userData.phone ?? "";
      bio.value = userData.bio?.toString() ?? "";

      city.value = userData.address!.city ?? "";
      street.value = userData.address?.street ?? "";
      zipCode.value = userData.address?.zipCode ?? "";
      state.value = userData.address?.state ?? "";

      // 🔹 Controllers for Profile Info
      fullNameController = TextEditingController(text: fullName.value);
      emailAddressController = TextEditingController(text: emailAddress.value);
      phoneNumberController = TextEditingController(text: phoneNumber.value);
      bioController = TextEditingController(text: bio.value);
      cityController = TextEditingController(text: city.value);
      streetController = TextEditingController(text: street.value);
      zipCodeController = TextEditingController(text: zipCode.value);
      stateController = TextEditingController(text: state.value);

      // 🔹 Notifications
      emailNotifications.value = userData.preferences?.notifications?.email ?? true;
      smsNotifications.value = userData.preferences?.notifications?.sms ?? true;
      pushNotifications.value = userData.preferences?.notifications?.push ?? true;
    }
  }


  /*@override
  void onInit() {
    super.onInit();

    authController.me();
    // 🔹 Profile data se controllers ko initialize karo
    final userData = authController.profile.value?.data;

    propertyTypesController = TextEditingController(text: preferredPropertyTypes.value);
    priceMinController = TextEditingController(text: priceRangeMin.value);
    priceMaxController = TextEditingController(text: priceRangeMax.value);
    locationsController = TextEditingController(text: preferredLocations.value);


    fullName.value = userData?.name ?? "Not provided";
    emailAddress.value = userData?.email ?? "Not provided";
    phoneNumber.value = userData?.phone ?? "Not provided";
    bio.value = userData?.bio ?? "Not provided";
    city.value = userData?.address!.city ?? "Not provided";
    street.value = userData?.address!.street ?? "Not provided";
    zipCode.value = userData?.address!.zipCode ?? "Not provided";
    state.value = userData?.address!.state ?? "Not provided";

    fullNameController = TextEditingController(text: fullName.value);
    emailAddressController = TextEditingController(text: emailAddress.value);
    phoneNumberController = TextEditingController(text: phoneNumber.value);
    bioController = TextEditingController(text: bio.value);
    cityController = TextEditingController(text: city.value);
    streetController = TextEditingController(text: street.value);
    zipCodeController = TextEditingController(text: zipCode.value);
    stateController = TextEditingController(text: state.value);
  }*/

  void toggleTabs(bool value) {
    isVisible.value = value;
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  /*void toggleEnable() {
    isEnable.value = !isEnable.value;
  }*/

  void toggleEnable({bool save = false}) {
    if (save) {
      preferredPropertyTypes.value = propertyTypesController.text;
      priceRangeMin.value = priceMinController.text;
      priceRangeMax.value = priceMaxController.text;
      preferredLocations.value = locationsController.text;

      fullName.value = fullNameController.text;
      emailAddress.value = emailAddressController.text;
      phoneNumber.value = phoneNumberController.text;
      bio.value = bioController.text;
      city.value = cityController.text;
      street.value = streetController.text;
      zipCode.value = zipCodeController.text;
      state.value = stateController.text;
    }
    isEnable.value = !isEnable.value;
  }

  void updateProfile() async {
    try {
      isEnable.value = false; // Editing band kar do
      final auth = authController;

      // 🔹 Backend ke liye Map bana do
      final updateData = {
        "name": fullNameController.text,
        "bio": bioController.text,
        "address": {
          "street": streetController.text,
          "city": cityController.text,
          "state": stateController.text,
          "zipCode": zipCodeController.text,
          "country": "India",
        },
        "preferences": {
          "propertyTypes": propertyTypesController.text
              .split(",")
              .map((e) => e.trim())
              .toList(),
          "priceRange": {
            "min": int.tryParse(priceMinController.text) ?? 0,
            "max": int.tryParse(priceMaxController.text) ?? 10000000,
          },
          "locations": locationsController.text
              .split(",")
              .map((e) => e.trim())
              .toList(),
          "notifications": {
            "email": emailNotifications.value,
            "sms": smsNotifications.value,
            "push": pushNotifications.value,
          }
        }
      };

      // 🔹 AuthController ka updateProfile call
      final response = await auth.updateProfile(updateData);

      if (response.success) {
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



}