import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/helpers.dart';
import '../../auth_screen/controllers/auth_controller.dart';
import 'package:prop_mize/app/data/models/user/user_me.dart';

class ProfileController extends GetxController
{
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

    // ✅ FIX: Controllers ko constructor mein initialize karo
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

    // FocusNodes
    final fullNameFocus = FocusNode();
    final emailFocus = FocusNode();
    final phoneFocus = FocusNode();
    final bioFocus = FocusNode();
    final cityFocus = FocusNode();
    final streetFocus = FocusNode();
    final zipFocus = FocusNode();
    final stateFocus = FocusNode();

    // Loading state
    final RxBool isLoading = false.obs;
    final RxBool isDataLoaded = false.obs;

    @override
    void onInit()
    {
        super.onInit();
        initializeControllers();

        loadProfileData();
    }

    // ✅ FIX: Controllers ko hamesha initialize karo - chahe data ho ya na ho
    void initializeControllers()
    {
        propertyTypesController = TextEditingController();
        priceMinController = TextEditingController();
        priceMaxController = TextEditingController();
        locationsController = TextEditingController();

        fullNameController = TextEditingController();
        emailAddressController = TextEditingController();
        phoneNumberController = TextEditingController();
        bioController = TextEditingController();
        cityController = TextEditingController();
        streetController = TextEditingController();
        zipCodeController = TextEditingController();
        stateController = TextEditingController();
    }

    void loadProfileData()
    {
        // ✅ AuthController ke profile changes observe karo
        ever(authController.profile, (profile)
            {
                if (profile != null && profile.data != null)
                {
                    updateControllersWithProfileData(profile.data!);
                }
            }
        );

        // ✅ Agar data already available hai to use karo
        if (authController.profile.value != null &&
            authController.profile.value!.data != null)
        {
            updateControllersWithProfileData(authController.profile.value!.data!);
        }
        else
        {
            authController.me();
        }
    }

    /*void updateControllersWithProfileData(Data userData)
    {
        try
        {
            if (userData.name == null && userData.email == null) 
            {
                return;
            }

            // 🔹 Preferences Data - SAFE ACCESS
            priceRangeMin.value = userData.preferences?.priceRange?.min?.toString() ?? "";
            priceRangeMax.value = userData.preferences?.priceRange?.max?.toString() ?? "";

            // ✅ Property Types handle karo
            if (userData.preferences?.propertyTypes != null &&
                userData.preferences!.propertyTypes!.isNotEmpty)
            {
                preferredPropertyTypes.value = userData.preferences!.propertyTypes!.join(", ");
            }
            else
            {
                preferredPropertyTypes.value = "";
            }

            // ✅ Locations handle karo
            if (userData.preferences?.locations != null &&
                userData.preferences!.locations!.isNotEmpty)
            {
                preferredLocations.value = userData.preferences!.locations!.join(", ");
            }
            else
            {
                preferredLocations.value = "";
            }

            // 🔹 Profile Info - WITH NULL CHECKS
            fullName.value = userData.name ?? "";
            emailAddress.value = userData.email ?? "";
            phoneNumber.value = userData.phone ?? "";
            bio.value = userData.bio?.toString() ?? "";

            // ✅ Address data safely handle karo
            city.value = userData.address?.city ?? "";
            street.value = userData.address?.street ?? "";
            zipCode.value = userData.address?.zipCode ?? "";
            state.value = userData.address?.state ?? "";

            // 🔹 Controllers me values set karo - WITH NULL SAFETY
            propertyTypesController.text = preferredPropertyTypes.value;
            priceMinController.text = priceRangeMin.value;
            priceMaxController.text = priceRangeMax.value;
            locationsController.text = preferredLocations.value;


            fullNameController.text = fullName.value;
            emailAddressController.text = emailAddress.value;
            phoneNumberController.text = phoneNumber.value;
            bioController.text = bio.value;
            cityController.text = city.value;
            streetController.text = street.value;
            zipCodeController.text = zipCode.value;
            stateController.text = state.value;

            // 🔹 Notifications - WITH DEFAULTS
            emailNotifications.value = userData.preferences?.notifications?.email ?? true;
            smsNotifications.value = userData.preferences?.notifications?.sms ?? true;
            pushNotifications.value = userData.preferences?.notifications?.push ?? true;

            isDataLoaded.value = true;
        }
        catch (e)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: "$e",
                isError: true
            );
        }
    }*/

    void updateControllersWithProfileData(Data userData)
    {
        try
        {
            // 🔹 Preferences Data
            priceRangeMin.value = userData.preferences?.priceRange?.min?.toString() ?? "";
            priceRangeMax.value = userData.preferences?.priceRange?.max?.toString() ?? "";

            // ✅ Property Types handle karo
            if (userData.preferences?.propertyTypes != null &&
                userData.preferences!.propertyTypes!.isNotEmpty) 
            {
                preferredPropertyTypes.value = userData.preferences!.propertyTypes!.join(", ");
            }
            else 
            {
                preferredPropertyTypes.value = "";
            }

            // ✅ Locations handle karo
            if (userData.preferences?.locations != null &&
                userData.preferences!.locations!.isNotEmpty) 
            {
                preferredLocations.value = userData.preferences!.locations!.join(", ");
            }
            else 
            {
                preferredLocations.value = "";
            }

            // 🔹 Profile Info
            fullName.value = userData.name ?? "";
            emailAddress.value = userData.email ?? "";
            phoneNumber.value = userData.phone ?? "";
            bio.value = userData.bio?.toString() ?? "";

            // ✅ Address data safely handle karo
            city.value = userData.address?.city ?? "";
            street.value = userData.address?.street ?? "";
            zipCode.value = userData.address?.zipCode ?? "";
            state.value = userData.address?.state ?? "";

            // 🔹 Controllers me values set karo
            propertyTypesController.text = preferredPropertyTypes.value;
            priceMinController.text = priceRangeMin.value;
            priceMaxController.text = priceRangeMax.value;
            locationsController.text = preferredLocations.value;

            fullNameController.text = fullName.value;
            emailAddressController.text = emailAddress.value;
            phoneNumberController.text = phoneNumber.value;
            bioController.text = bio.value;
            cityController.text = city.value;
            streetController.text = street.value;
            zipCodeController.text = zipCode.value;
            stateController.text = state.value;

            // 🔹 Notifications
            emailNotifications.value = userData.preferences?.notifications?.email ?? true;
            smsNotifications.value = userData.preferences?.notifications?.sms ?? true;
            pushNotifications.value = userData.preferences?.notifications?.push ?? true;

            isDataLoaded.value = true;

        }
        catch (e)
        {
          AppHelpers.showSnackBar(title: "Error", message: "Updating profile data: $e", isError: true);
        }
    }

    void toggleTabs(bool value)
    {
        isVisible.value = value;
    }

    void changeTab(int index)
    {
        selectedIndex.value = index;
    }

    void toggleEnable({bool save = false})
    {
        if (save)
        {
            saveLocalData();
            updateProfile();
        }
        else
        {
            isEnable.value = !isEnable.value;
        }
    }

    void saveLocalData()
    {
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

    /*void updateProfile() async
    {
        try
        {
            isLoading.value = true;

            if (authController.profile.value?.data == null) 
            {
                AppHelpers.showSnackBar(title: "Error", message: "Please login to update profile", isError: true);
                return;
            }

      // final updateData = {
      //   "name": fullNameController.text.trim(),
      //   "bio": bioController.text.trim(),
      //   "email": emailAddressController.text.trim(),
      //   "address": {
      //     "street": streetController.text.trim(),
      //     "city": cityController.text.trim(),
      //     "state": stateController.text.trim(),
      //     "zipCode": zipCodeController.text.trim(),
      //     "country": authController.profile.value?.data?.address?.country ?? "India",
      //   },
      //   "preferences": {
      //     "propertyTypes": propertyTypesController.text
      //         .split(",")
      //         .map((e) => e.trim())
      //         .where((e) => e.isNotEmpty)
      //         .toList(),
      //     "priceRange": {
      //       "min": int.tryParse(priceMinController.text) ?? 0,
      //       "max": int.tryParse(priceMaxController.text) ?? 10000000,
      //     },
      //     "locations": locationsController.text
      //         .split(",")
      //         .map((e) => e.trim())
      //         .where((e) => e.isNotEmpty)
      //         .toList(),
      //     "notifications": {
      //       "email": emailNotifications.value,
      //       "sms": smsNotifications.value,
      //       "push": pushNotifications.value,
      //     }
      //   }
      // };

            final updateData = 
            {
                "name": fullNameController.text.trim(),
                "bio": bioController.text.trim(),
                "email": emailAddressController.text.trim(),
                "address.street": streetController.text.trim(),
                "address.city": cityController.text.trim(),
                "address.state": stateController.text.trim(),
                "address.zipCode": zipCodeController.text.trim(),
                "address.country": authController.profile.value?.data?.address?.country ?? "India",

                "preferences.propertyTypes": propertyTypesController.text
                    .split(",")
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList(),
                "preferences.priceRange":
                {
                    "min": int.tryParse(priceMinController.text) ?? 0,
                    "max": int.tryParse(priceMaxController.text) ?? 10000000
                },
                "preferences.locations": locationsController.text
                    .split(",")
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList(),
                "preferences.notifications":
                {
                    "email": emailNotifications.value,
                    "sms": smsNotifications.value,
                    "push": pushNotifications.value
                }
            };

            final response = await authController.updateProfile(updateData);

            if (response.success) 
            {
                isEnable.value = false;
                AppHelpers.showSnackBar(title: "Success", message: "Profile updated successfully", isError: false);
                authController.me();
            }
            else 
            {
              AppHelpers.showSnackBar(title: "Error", message: "else updateProfile ${response.message}", isError: true);
            }
        }
        catch (e)
        {
            AppHelpers.showSnackBar(title: "Error", message: "Cache updateProfile$e", isError: true);

        }
        finally
        {
            isLoading.value = false;
        }
    }*/

    void updateProfile() async
    {
        try
        {
            isLoading.value = true;

            if (authController.profile.value?.data == null) 
            {
                AppHelpers.showSnackBar(title: "Error", message: "Please login to update profile", isError: true);
                return;
            }

            final Map<String, dynamic> updateData = {};

            // ✅ ONLY CHANGED FALUES ADD KARENGE

            // 🔹 Basic Info - Compare with original data
            final originalData = authController.profile.value!.data!;

            if (fullNameController.text.trim() != (originalData.name ?? "")) 
            {
                updateData["name"] = fullNameController.text.trim();
            }

            if (bioController.text.trim() != (originalData.bio?.toString() ?? "")) 
            {
                updateData["bio"] = bioController.text.trim();
            }

            if (emailAddressController.text.trim() != (originalData.email ?? "")) 
            {
                updateData["email"] = emailAddressController.text.trim();
            }

            // 🔹 Address - Only if changed
            final originalAddress = originalData.address;
            if (streetController.text.trim() != (originalAddress?.street ?? "")) 
            {
                updateData["address.street"] = streetController.text.trim();
            }
            if (cityController.text.trim() != (originalAddress?.city ?? "")) 
            {
                updateData["address.city"] = cityController.text.trim();
            }
            if (stateController.text.trim() != (originalAddress?.state ?? "")) 
            {
                updateData["address.state"] = stateController.text.trim();
            }
            if (zipCodeController.text.trim() != (originalAddress?.zipCode ?? "")) 
            {
                updateData["address.zipCode"] = zipCodeController.text.trim();
            }

            // 🔹 Preferences - Only if changed
            final originalPrefs = originalData.preferences;

            // Property Types
            final newPropertyTypes = propertyTypesController.text
                .split(",")
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();

            final originalPropertyTypes = originalPrefs?.propertyTypes ?? [];
            if (!_areListsEqual(newPropertyTypes, originalPropertyTypes)) 
            {
                updateData["preferences.propertyTypes"] = newPropertyTypes;
            }

            // Price Range
            final newMin = int.tryParse(priceMinController.text) ?? 0;
            final newMax = int.tryParse(priceMaxController.text) ?? 10000000;
            final originalMin = originalPrefs?.priceRange?.min ?? 0;
            final originalMax = originalPrefs?.priceRange?.max ?? 10000000;

            if (newMin != originalMin || newMax != originalMax) 
            {
                updateData["preferences.priceRange"] = 
                {
                    "min": newMin,
                    "max": newMax
                };
            }

            // Locations
            final newLocations = locationsController.text
                .split(",")
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();

            final originalLocations = originalPrefs?.locations ?? [];
            if (!_areListsEqual(newLocations, originalLocations)) 
            {
                updateData["preferences.locations"] = newLocations;
            }

            // Notifications - Only if changed
            final originalNotifications = originalPrefs?.notifications;
            if (emailNotifications.value != (originalNotifications?.email ?? true)) 
            {
                updateData["preferences.notifications.email"] = emailNotifications.value;
            }
            if (smsNotifications.value != (originalNotifications?.sms ?? true)) 
            {
                updateData["preferences.notifications.sms"] = smsNotifications.value;
            }
            if (pushNotifications.value != (originalNotifications?.push ?? true)) 
            {
                updateData["preferences.notifications.push"] = pushNotifications.value;
            }

            // ✅ Agar koi change nahi hai to API call avoid karo
            if (updateData.isEmpty) 
            {
                Get.snackbar("Info", "No changes detected to update");
                isLoading.value = false;
                return;
            }

            final response = await authController.updateProfile(updateData);

            if (response.success) 
            {
                isEnable.value = false;
                AppHelpers.showSnackBar(
                    title: "Profile Update",
                    message: response.message,
                    isError: false
                );
                authController.me(); // Refresh data
            }
            else {
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true
                );
            }
        }
        on DioException catch (e)
        {
            AppHelpers.showSnackBar(
                title: "Error",
                message: e.message ?? "Something went wrong",
                isError: true
            );
        }
        finally
        {
            isLoading.value = false;
        }
    }


    // ✅ Helper method to compare lists
    bool _areListsEqual(List<dynamic> list1, List<dynamic> list2) 
    {
        if (list1.length != list2.length) return false;
        for (int i = 0; i < list1.length; i++)
        {
            if (list1[i] != list2[i]) return false;
        }
        return true;
    }

    @override
    void onClose()
    {
        // ✅ Dispose controllers
        propertyTypesController.dispose();
        priceMinController.dispose();
        priceMaxController.dispose();
        locationsController.dispose();
        fullNameController.dispose();
        emailAddressController.dispose();
        phoneNumberController.dispose();
        bioController.dispose();
        cityController.dispose();
        streetController.dispose();
        zipCodeController.dispose();
        stateController.dispose();

        fullNameFocus.dispose();
        emailFocus.dispose();
        phoneFocus.dispose();
        bioFocus.dispose();
        cityFocus.dispose();
        streetFocus.dispose();
        zipFocus.dispose();
        stateFocus.dispose();

        super.onClose();
    }
}
