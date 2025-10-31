import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/repositories/properties/properties_repository.dart';
import 'package:prop_mize/app/modules/seller_modules/seller_main_screen/controllers/seller_main_controller.dart';

import '../../../../data/models/properties/lists/near_by_places.dart';

class SellRentPropertyController extends GetxController
{
    final PropertiesRepository _propertiesRepo = PropertiesRepository();
    final pageController = PageController();

    // ----- Stepper State -----
    final RxInt currentStep = 0.obs;
    final formKeys = [
        GlobalKey<FormState>(), // Step 1: Basic Details
        GlobalKey<FormState>(), // Step 2: Location & Features
        GlobalKey<FormState>() // Step 3: Media & Pricing
    ];

    // ----- Loading & Error State -----
    final RxBool isLoading = false.obs;
    final RxString errorMessage = ''.obs;

    // ----- Form Data -----
    // Step 1: Basic Details
    final propertyType = 'Apartment'.obs;
    final listingType = 'For Sale'.obs;
    final furnishingStatus = 'Unfurnished'.obs;
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final areaController = TextEditingController();
    final buildUpAreaController = TextEditingController();
    final superBuildUpAreaController = TextEditingController();
    final propertyAgeController = TextEditingController();
    final bedroomsController = TextEditingController();
    final bathroomsController = TextEditingController();
    final balconiesController = TextEditingController();
    final parkingController = TextEditingController();
    final floorController = TextEditingController();
    final totalFloorsController = TextEditingController();

    // State for Area units and optional fields
    final areaUnit = 'Sq. Ft.'.obs;
    final showBuildUpArea = false.obs;
    final showSuperBuildUpArea = false.obs;
    final buildUpAreaUnit = 'Sq. Ft.'.obs;
    final superBuildUpAreaUnit = 'Sq. Ft.'.obs;

    // Step 2: Location & Features
    final streetController = TextEditingController();
    final areaNameController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipCodeController = TextEditingController();
    final countryController = TextEditingController(text: 'India');
    final landmarkController = TextEditingController();
    final facing = 'North'.obs;
    final flooringTypeController = TextEditingController();
    final waterSupplyController = TextEditingController();

    // --- All Feature Booleans ---
    final RxBool powerBackup = false.obs;
    final RxBool servantRoom = false.obs;
    final RxBool poojaRoom = false.obs;
    final RxBool studyRoom = false.obs;
    final RxBool storeRoom = false.obs;
    final RxBool swimmingPool = false.obs;
    final RxBool gym = false.obs;
    final RxBool lift = false.obs;
    final RxBool security = false.obs;

    // --- Amenities ---
    final RxList<String> amenities = <String>[].obs;
    final List<String> availableAmenities = [
        'Power Backup',
        'Garden',
        "Children's Play Area",
        'Club House',
        'Parking',
        'CCTV',
        'Fire Safety',
        'Intercom',
        'WiFi',
        'Community Hall',
        'Jogging Track',
        'Sports Facility'
    ];

    // --- Select Amenities ---
    final RxBool amenitiesPowerBackup = false.obs;
    final RxBool childPlayArea = false.obs;
    final RxBool garden = false.obs;
    final RxBool clubHouse = false.obs;
    final RxBool parking = false.obs;
    final RxBool cctv = false.obs;
    final RxBool fireSafety = false.obs;
    final RxBool intercom = false.obs;
    final RxBool wifi = false.obs;
    final RxBool communityHall = false.obs;
    final RxBool joggingTrack = false.obs;
    final RxBool sportFacility = false.obs;

    // Step 3: Media & Pricing
    final images = <String>[].obs; // To store image paths/URLs
    final priceController = TextEditingController();
    final contactNameController = TextEditingController();
    final contactPhoneController = TextEditingController();
    final contactWhatsappController = TextEditingController();
    final contactType = 'Owner'.obs;
    final additionalNotesController = TextEditingController();

    // --- Nearby Places ---
    // Lists to hold the added places
    final RxList<Schools> nearbySchools = <Schools>[].obs;
    final RxList<Hospitals> nearbyHospitals = <Hospitals>[].obs;
    final RxList<Malls> nearbyMalls = <Malls>[].obs;
    final RxList<Transport> nearbyTransport = <Transport>[].obs;

    // Controllers for the input fields
    final schoolNameController = TextEditingController();
    final schoolDistanceController = TextEditingController();
    final schoolDistanceUnit = 'meter'.obs;

    final hospitalNameController = TextEditingController();
    final hospitalDistanceController = TextEditingController();
    final hospitalDistanceUnit = 'meter'.obs;

    final mallNameController = TextEditingController();
    final mallDistanceController = TextEditingController();
    final mallDistanceUnit = 'km'.obs;

    final transportNameController = TextEditingController();
    final transportDistanceController = TextEditingController();
    final transportDistanceUnit = 'km'.obs;

    // RxBool to toggle the visibility of the input forms
    final RxBool showAddSchool = false.obs;
    final RxBool showAddHospital = false.obs;
    final RxBool showAddMall = false.obs;
    final RxBool showAddTransport = false.obs;

    // Method to add a school to the list
    void addSchool() {
        if (schoolNameController.text.isNotEmpty && schoolDistanceController.text.isNotEmpty) {
            nearbySchools.add(Schools(
                name: schoolNameController.text,
                distance: int.tryParse(schoolDistanceController.text),
                unit: schoolDistanceUnit.value,
            ));
            // Clear inputs and hide the form
            schoolNameController.clear();
            schoolDistanceController.clear();
            showAddSchool.value = false;
        }
    }

    // Method to add a hospital to the list
    void addHospital() {
        if (hospitalNameController.text.isNotEmpty && hospitalDistanceController.text.isNotEmpty) {
            nearbyHospitals.add(Hospitals(
                name: hospitalNameController.text,
                distance: int.tryParse(hospitalDistanceController.text),
                unit: hospitalDistanceUnit.value,
            ));
            hospitalNameController.clear();
            hospitalDistanceController.clear();
            showAddHospital.value = false;
        }
    }

    // Method to add a mall to the list
    void addMall() {
        if (mallNameController.text.isNotEmpty && mallDistanceController.text.isNotEmpty) {
            nearbyMalls.add(Malls(
                name: mallNameController.text,
                distance: int.tryParse(mallDistanceController.text),
                unit: mallDistanceUnit.value,
            ));
            mallNameController.clear();
            mallDistanceController.clear();
            showAddMall.value = false;
        }
    }

    // Method to add a transport option to the list
    void addTransport() {
        if (transportNameController.text.isNotEmpty && transportDistanceController.text.isNotEmpty) {
            nearbyTransport.add(Transport(
                name: transportNameController.text,
                distance: int.tryParse(transportDistanceController.text),
                unit: transportDistanceUnit.value,
            ));
            transportNameController.clear();
            transportDistanceController.clear();
            showAddTransport.value = false;
        }
    }

    // --- Image Picker ---
    final ImagePicker _picker = ImagePicker();

    /// Pick multiple images from the gallery
    Future<void> pickImages() async {
        final List<XFile> pickedFiles = await _picker.pickMultiImage(
            imageQuality: 80
        );

        if(pickedFiles.isNotEmpty) {
            for(var file in pickedFiles) {
                images.add(file.path);
            }
        } else {
            // User canceled the picker
            AppHelpers.showSnackBar(
                title: "No Images Selected",
                message: "You didn't select any new images.",
            );
        }
    }

    /// Remove an image from the list
    void removeImage(int index) {
        if (index >= 0 && index < images.length) {
            images.removeAt(index);
        }
    }


    // ----- Stepper Navigation -----

    /// Go to the next step, validating the current form if necessary
    void nextStep()
    {
        // On the final review step, the button text is "Submit", so this will trigger submitProperty
        if (currentStep.value >= formKeys.length) {
            submitProperty();
            return;
        }

        // Validate the current step's form before proceeding
        if (formKeys[currentStep.value].currentState!.validate())
        {
            currentStep.value++;
            pageController.animateToPage(currentStep.value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }
    }

    /// Go back to the previous step
    void previousStep()
    {
        if (currentStep.value > 0)
        {
            currentStep.value--;
            pageController.animateToPage(currentStep.value, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }
    }

    /// Handle step tapped
    void onStepTapped(int step)
    {
        // Allow navigation only to previous, validated steps
        if (step < currentStep.value)
        {
            currentStep.value = step;
            pageController.animateToPage(step, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }
        else if (step > currentStep.value)
        {
            // If trying to jump forward, validate all steps in between
            bool allValid = true;
            for (int i = currentStep.value; i < step; i++)
            {
                if (!formKeys[i].currentState!.validate())
                {
                    allValid = false;
                    // Jump to the first invalid step
                    currentStep.value = i;
                    pageController.animateToPage(i, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    break;
                }
            }
            if (allValid)
            {
                currentStep.value = step;
                pageController.animateToPage(step, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            }
        }
    }

    /// Converts the display unit (e.g., "Sq. Ft.") to the API format (e.g., "sqft").
    String _formatUnit(String unit) {
        switch (unit) {
            case 'Sq. Ft.':
                return 'sqft';
            case 'Sq. M.':
                return 'sqm';
            case 'Acre':
                return 'acre';
            case 'Hectare':
                return 'hectare';
            default:
                return 'sqft';
        }
    }

    // ----- Data Submission -----
    Future<void> submitProperty() async
    {
        isLoading.value = true;
        errorMessage.value = '';

        // Construct the payload from all controllers
        final Map<String, dynamic> payload =
        {
            "title": titleController.text,
            "description": descriptionController.text,
            "propertyType": propertyType.value.toLowerCase(),
            "listingType": listingType.value.toLowerCase().replaceAll('for ', ''),
            "price": num.tryParse(priceController.text) ?? 0,
            "area": {
                "value": num.tryParse(areaController.text),
                "unit": _formatUnit(areaUnit.value)
            },
            if (buildUpAreaController.text.isNotEmpty)
                "buildUpArea": {
                    "value": num.tryParse(buildUpAreaController.text),
                    "unit": _formatUnit(buildUpAreaUnit.value)
                },
            if (superBuildUpAreaController.text.isNotEmpty)
                "superBuildUpArea": {
                    "value": num.tryParse(superBuildUpAreaController.text),
                    "unit": _formatUnit(superBuildUpAreaUnit.value)
                },
            "furnished": furnishingStatus.value.toLowerCase(),
            "age": int.tryParse(propertyAgeController.text) ?? 0,
            "bedrooms": int.tryParse(bedroomsController.text),
            "bathrooms": int.tryParse(bathroomsController.text),
            "balconies": int.tryParse(balconiesController.text),
            "parking": int.tryParse(parkingController.text),
            "floor": int.tryParse(floorController.text),
            "totalFloors": int.tryParse(totalFloorsController.text),
            "address":
            {
                "street": streetController.text,
                "area": areaNameController.text,
                "city": cityController.text,
                "state": stateController.text,
                "zipCode": zipCodeController.text,
                "country": countryController.text,
                "landmark": landmarkController.text
            },
            "features":
            {
                "facing": facing.value.toLowerCase().replaceAll('-', ''), // "north-east" -> "northeast"
                "flooringType": flooringTypeController.text,
                "waterSupply": waterSupplyController.text,
                "powerBackup": powerBackup.value,
                "servantRoom": servantRoom.value,
                "poojaRoom": poojaRoom.value,
                "studyRoom": studyRoom.value,
                "storeRoom": storeRoom.value,
                "garden": garden.value,
                "swimmingPool": swimmingPool.value,
                "gym": gym.value,
                "lift": lift.value,
                "security": security.value
            },
            // FIX 1: Send amenities as a List<String>
            "amenities": amenities.toList(),
            /*"amenities":
            {
                "powerBackup": amenitiesPowerBackup.value,
                "childPlayArea": childPlayArea.value,
                "garden": garden.value,
                "clubHouse": clubHouse.value,
                "parking": parking.value,
                "cctv": cctv.value,
                "fireSafety": fireSafety.value,
                "intercom": intercom.value,
                "wifi": wifi.value,
                "communityHall": communityHall.value,
                "joggingTrack": joggingTrack.value,
                "sportFacility": sportFacility.value
            },*/
            "nearbyPlaces": {
                "schools": nearbySchools.map((school) => school.toJson()).toList(),
                "hospitals": nearbyHospitals.map((hospital) => hospital.toJson()).toList(),
                "malls": nearbyMalls.map((mall) => mall.toJson()).toList(),
                "transport": nearbyTransport.map((transport) => transport.toJson()).toList(),
            },
            "images": images.toList(),
            "contact":
            {
                "name": contactNameController.text,
                "phone": contactPhoneController.text,
                "whatsapp": contactWhatsappController.text,
                "type": contactType.value.toLowerCase()
            },
            "notes": additionalNotesController.text,
            "pricing": { // Default pricing structure
                "priceNegotiable": true
            }
        };

        // Remove null values from nested objects for cleaner API calls
        (payload['features'] as Map).removeWhere((key, value) => value == null || (value is String && value.isEmpty));
        (payload['address'] as Map).removeWhere((key, value) => value == null || (value is String && value.isEmpty));

        try
        {
            final response = await _propertiesRepo.createProperty(payload);
            if (response.success)
            {
                AppHelpers.showSnackBar(title: "Success",
                    message: "Property listed successfully!",
                    isError: false
                );

                Future.delayed(Duration.zero);
                Get.find<SellerMainController>().viewAllMyProperties();
            }
            else
            {
                errorMessage.value = response.message;
                AppHelpers.showSnackBar(
                    title: "Error",
                    message: response.message,
                    isError: true
                );
            }
        }
        catch(e)
        {
            errorMessage.value = "An unexpected error occurred: $e";
            AppHelpers.showSnackBar(
                title: "Error",
                message: errorMessage.value,
                isError: true
            );
        }
        finally
        {
            isLoading.value = false;
        }
    }

    @override
    void onClose()
    {
        pageController.dispose();
        // Dispose all text editing controllers to prevent memory leaks
        titleController.dispose();
        descriptionController.dispose();
        areaController.dispose();
        buildUpAreaController.dispose();
        superBuildUpAreaController.dispose();
        propertyAgeController.dispose();
        bedroomsController.dispose();
        bathroomsController.dispose();
        balconiesController.dispose();
        parkingController.dispose();
        floorController.dispose();
        totalFloorsController.dispose();
        streetController.dispose();
        areaNameController.dispose();
        cityController.dispose();
        stateController.dispose();
        zipCodeController.dispose();
        countryController.dispose();
        landmarkController.dispose();
        flooringTypeController.dispose();
        waterSupplyController.dispose();
        priceController.dispose();
        contactNameController.dispose();
        contactPhoneController.dispose();
        contactWhatsappController.dispose();
        additionalNotesController.dispose();
        super.onClose();
    }
}

