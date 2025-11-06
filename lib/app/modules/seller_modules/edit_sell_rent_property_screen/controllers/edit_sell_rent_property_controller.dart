import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_mize/app/core/utils/helpers.dart';
import 'package:prop_mize/app/data/repositories/properties/properties_repository.dart';
import 'package:prop_mize/app/modules/seller_modules/my_property_screen/controllers/my_property_controller.dart';

import '../../../../data/models/properties/data.dart';
import '../../../../data/models/properties/lists/near_by_places.dart';

class EditSellRentPropertyController extends GetxController
{
    // ========== DEPENDENCIES ==========
    final PropertiesRepository _propertiesRepo = PropertiesRepository();
    final pageController = PageController();
    final ImagePicker _picker = ImagePicker();

    // ========== STATE MANAGEMENT ==========
    final RxInt currentStep = 0.obs;
    final RxBool isLoading = false.obs;
    final RxString errorMessage = ''.obs;
    final RxString editingPropertyId = ''.obs;

    // ========== FORM VALIDATION ==========
    final formKeys = [
        GlobalKey<FormState>(), // Step 1: Basic Details
        GlobalKey<FormState>(), // Step 2: Location & Features
        GlobalKey<FormState>() // Step 3: Media & Pricing
    ];

    // ========== STEP 1: BASIC DETAILS ==========

    // Reactive Values
    final propertyType = 'Apartment'.obs;
    final listingType = 'For Sale'.obs;
    final furnishingStatus = 'Unfurnished'.obs;

    // Area Units
    final areaUnit = 'Sq. Ft.'.obs;
    final buildUpAreaUnit = 'Sq. Ft.'.obs;
    final superBuildUpAreaUnit = 'Sq. Ft.'.obs;

    // Optional Fields Visibility
    final showBuildUpArea = false.obs;
    final showSuperBuildUpArea = false.obs;

    // Text Controllers
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

    // ========== STEP 2: LOCATION & FEATURES ==========

    // Reactive Values
    final facing = 'North'.obs;

    // Text Controllers
    final streetController = TextEditingController();
    final areaNameController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipCodeController = TextEditingController();
    final countryController = TextEditingController(text: 'India');
    final landmarkController = TextEditingController();
    final flooringTypeController = TextEditingController();
    final waterSupplyController = TextEditingController();

    // Feature Booleans
    final RxBool powerBackup = false.obs;
    final RxBool servantRoom = false.obs;
    final RxBool poojaRoom = false.obs;
    final RxBool studyRoom = false.obs;
    final RxBool storeRoom = false.obs;
    final RxBool swimmingPool = false.obs;
    final RxBool gym = false.obs;
    final RxBool lift = false.obs;
    final RxBool security = false.obs;
    final RxBool garden = false.obs;

    // Amenities
    final RxList<String> amenities = <String>[].obs;
    final List<String> availableAmenities = [
        'Power Backup',
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

    // ========== STEP 3: MEDIA & PRICING ==========

    // Images
    final images = <String>[].obs;

    // Pricing Controllers
    final priceController = TextEditingController();
    final monthlyRentController = TextEditingController();
    final maintenanceChargesController = TextEditingController();
    final securityDepositController = TextEditingController();

    // Contact Controllers
    final contactNameController = TextEditingController();
    final contactPhoneController = TextEditingController();
    final contactWhatsappController = TextEditingController();
    final contactType = 'Owner'.obs;
    final additionalNotesController = TextEditingController();

    // ========== NEARBY PLACES ==========

    // Lists
    final RxList<Schools> nearbySchools = <Schools>[].obs;
    final RxList<Hospitals> nearbyHospitals = <Hospitals>[].obs;
    final RxList<Malls> nearbyMalls = <Malls>[].obs;
    final RxList<Transport> nearbyTransport = <Transport>[].obs;

    // Controllers
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

    // Form Visibility
    final RxBool showAddSchool = false.obs;
    final RxBool showAddHospital = false.obs;
    final RxBool showAddMall = false.obs;
    final RxBool showAddTransport = false.obs;

    // ========== LIFECYCLE METHODS ==========

    @override
    void onClose()
    {
        pageController.dispose();
        _disposeAllControllers();
        super.onClose();
    }

    // ========== EDITING METHODS ==========

    void loadPropertyForEditing(Data data)
    {
        editingPropertyId.value = data.id ?? '';

        // Load basic details
        propertyType.value = _capitalizeFirst(data.propertyType ?? 'apartment');
        listingType.value = _formatListingTypeForDisplay(data.listingType ?? 'sale');
        titleController.text = data.title ?? '';
        descriptionController.text = data.description ?? '';

        // Load area details
        areaController.text = data.area?.value?.toString() ?? '';
        areaUnit.value = _formatUnitForDisplay(data.area?.unit ?? 'sqft');

        // Load built-up area if exists
        if (data.buildUpArea?.value != null)
        {
            showBuildUpArea.value = true;
            buildUpAreaController.text = data.buildUpArea!.value!.toString();
            buildUpAreaUnit.value = _formatUnitForDisplay(data.buildUpArea?.unit ?? 'sqft');
        }

        // Load super built-up area if exists
        if (data.superBuildUpArea?.value != null)
        {
            showSuperBuildUpArea.value = true;
            superBuildUpAreaController.text = data.superBuildUpArea!.value!.toString();
            superBuildUpAreaUnit.value = _formatUnitForDisplay(data.superBuildUpArea?.unit ?? 'sqft');
        }

        // Load other basic details
        propertyAgeController.text = data.age?.toString() ?? '';
        furnishingStatus.value = _formatListingFurnished(data.furnished ?? "unfurnished");
        bedroomsController.text = data.bedrooms?.toString() ?? '';
        bathroomsController.text = data.bathrooms?.toString() ?? '';
        balconiesController.text = data.balconies?.toString() ?? '';
        parkingController.text = data.parking?.toString() ?? '';
        floorController.text = data.floor?.toString() ?? '';
        totalFloorsController.text = data.totalFloors?.toString() ?? '';

        // Load location details
        streetController.text = data.address?.street ?? '';
        areaNameController.text = data.address?.area ?? '';
        cityController.text = data.address?.city ?? '';
        stateController.text = data.address?.state ?? '';
        zipCodeController.text = data.address?.zipCode ?? '';
        countryController.text = data.address?.country ?? 'India';
        landmarkController.text = data.address?.landmark ?? '';

        // Load features
        facing.value = _formatFacingType(data.features?.facing ?? 'north');
        flooringTypeController.text = data.features?.flooringType ?? '';
        waterSupplyController.text = data.features?.waterSupply ?? '';

        // Load boolean features
        powerBackup.value = data.features?.powerBackup ?? false;
        servantRoom.value = data.features?.servantRoom ?? false;
        poojaRoom.value = data.features?.poojaRoom ?? false;
        studyRoom.value = data.features?.studyRoom ?? false;
        storeRoom.value = data.features?.storeRoom ?? false;
        swimmingPool.value = data.features?.swimmingPool ?? false;
        gym.value = data.features?.gym ?? false;
        lift.value = data.features?.lift ?? false;
        security.value = data.features?.security ?? false;

        // Load amenities
        amenities.value = List<String>.from(data.amenities ?? []);

        // Load pricing
        priceController.text = data.price?.toString() ?? '';

        final pricing = data.pricing!;

        if (pricing.basePrice != null)
        {
            monthlyRentController.text = pricing.basePrice.toString();
        }
        if (pricing.maintenanceCharges != null)
        {
            maintenanceChargesController.text = pricing.maintenanceCharges.toString();
        }
        if (pricing.securityDeposit != null)
        {
            securityDepositController.text = pricing.securityDeposit.toString();
        }

        // Load contact info
        contactNameController.text = data.contact?.name ?? '';
        contactPhoneController.text = data.contact?.phone ?? '';
        contactWhatsappController.text = data.contact?.whatsapp ?? '';
        contactType.value = _capitalizeFirst(data.contact?.type ?? 'Owner');

        // Load nearby places
        nearbySchools.value = data.nearbyPlaces?.schools?.cast<Schools>() ?? <Schools>[].obs;
        nearbyHospitals.value = data.nearbyPlaces?.hospitals?.cast<Hospitals>() ?? <Hospitals>[].obs;
        nearbyMalls.value = data.nearbyPlaces?.malls?.cast<Malls>() ?? <Malls>[].obs;
        nearbyTransport.value = data.nearbyPlaces?.transport?.cast<Transport>() ?? <Transport>[].obs;

        // Load images
        images.value = List<String>.from(data.images ?? []);

        additionalNotesController.text = data.notes ?? '';
    }

    // ========== NEARBY PLACES METHODS ==========

    void addSchool()
    {
        if (schoolNameController.text.isNotEmpty && schoolDistanceController.text.isNotEmpty)
        {
            nearbySchools.add(Schools(
                    name: schoolNameController.text,
                    distance: int.tryParse(schoolDistanceController.text),
                    unit: schoolDistanceUnit.value
                ));
            schoolNameController.clear();
            schoolDistanceController.clear();
            showAddSchool.value = false;
        }
    }

    void addHospital()
    {
        if (hospitalNameController.text.isNotEmpty && hospitalDistanceController.text.isNotEmpty)
        {
            nearbyHospitals.add(Hospitals(
                    name: hospitalNameController.text,
                    distance: int.tryParse(hospitalDistanceController.text),
                    unit: hospitalDistanceUnit.value
                ));
            hospitalNameController.clear();
            hospitalDistanceController.clear();
            showAddHospital.value = false;
        }
    }

    void addMall()
    {
        if (mallNameController.text.isNotEmpty && mallDistanceController.text.isNotEmpty)
        {
            nearbyMalls.add(Malls(
                    name: mallNameController.text,
                    distance: int.tryParse(mallDistanceController.text),
                    unit: mallDistanceUnit.value
                ));
            mallNameController.clear();
            mallDistanceController.clear();
            showAddMall.value = false;
        }
    }

    void addTransport()
    {
        if (transportNameController.text.isNotEmpty && transportDistanceController.text.isNotEmpty)
        {
            nearbyTransport.add(Transport(
                    name: transportNameController.text,
                    distance: int.tryParse(transportDistanceController.text),
                    unit: transportDistanceUnit.value
                ));
            transportNameController.clear();
            transportDistanceController.clear();
            showAddTransport.value = false;
        }
    }

    // ========== IMAGE METHODS ==========

    Future<void> pickImages() async
    {
        final List<XFile> pickedFiles = await _picker.pickMultiImage(imageQuality: 80);

        if (pickedFiles.isNotEmpty)
        {
            for (var file in pickedFiles)
            {
                images.add(file.path);
            }
        }
        else
        {
            AppHelpers.showSnackBar(
                title: "No Images Selected",
                message: "You didn't select any new images."
            );
        }
    }

    void removeImage(int index)
    {
        if (index >= 0 && index < images.length)
        {
            images.removeAt(index);
        }
    }

    // ========== STEPPER NAVIGATION ==========

    void nextStep()
    {
        if (currentStep.value >= formKeys.length)
        {
            submitProperty();
            return;
        }

        if (formKeys[currentStep.value].currentState!.validate())
        {
            currentStep.value++;
            pageController.animateToPage(
                currentStep.value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease
            );
        }
    }

    void previousStep()
    {
        if (currentStep.value > 0)
        {
            currentStep.value--;
            pageController.animateToPage(
                currentStep.value,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease
            );
        }
    }

    void onStepTapped(int step)
    {
        if (step < currentStep.value)
        {
            currentStep.value = step;
            pageController.animateToPage(
                step,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease
            );
        }
        else if (step > currentStep.value)
        {
            bool allValid = true;
            for (int i = currentStep.value; i < step; i++)
            {
                if (!formKeys[i].currentState!.validate())
                {
                    allValid = false;
                    currentStep.value = i;
                    pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease
                    );
                    break;
                }
            }
            if (allValid)
            {
                currentStep.value = step;
                pageController.animateToPage(
                    step,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease
                );
            }
        }
    }

    // ========== DATA SUBMISSION ==========

    Future<void> submitProperty() async
    {
        isLoading.value = true;
        errorMessage.value = '';

        final Map<String, dynamic> payload =
            {
                "title": titleController.text,
                "description": descriptionController.text,
                "propertyType": propertyType.value.toLowerCase(),
                "listingType": listingType.value.toLowerCase().replaceAll('for ', ''),
                "price": num.tryParse(priceController.text) ?? '',
                "area":
                {
                    "value": num.tryParse(areaController.text) ?? '',
                    "unit": _formatUnit(areaUnit.value)
                },
                if (buildUpAreaController.text.isNotEmpty) "buildUpArea":
                {
                    "value": num.tryParse(buildUpAreaController.text) ?? '',
                    "unit": _formatUnit(buildUpAreaUnit.value)
                },
                if (superBuildUpAreaController.text.isNotEmpty) "superBuildUpArea":
                {
                    "value": num.tryParse(superBuildUpAreaController.text) ?? '',
                    "unit": _formatUnit(superBuildUpAreaUnit.value)
                },
                "furnished": furnishingStatus.value.toLowerCase(),
                "age": num.tryParse(propertyAgeController.text) ?? '',
                "bedrooms": num.tryParse(bedroomsController.text) ?? '',
                "bathrooms": num.tryParse(bathroomsController.text) ?? '',
                "balconies": num.tryParse(balconiesController.text) ?? '',
                "parking": num.tryParse(parkingController.text) ?? '',
                "floor": num.tryParse(floorController.text) ?? '',
                "totalFloors": num.tryParse(totalFloorsController.text) ?? '',
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
                    "facing": facing.value.toLowerCase().replaceAll('-', ''),
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
                "amenities": amenities.toList(),
                "nearbyPlaces":
                {
                    "schools": nearbySchools.map((school) => school.toJson()).toList(),
                    "hospitals": nearbyHospitals.map((hospital) => hospital.toJson()).toList(),
                    "malls": nearbyMalls.map((mall) => mall.toJson()).toList(),
                    "transport": nearbyTransport.map((transport) => transport.toJson()).toList()
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
                "pricing":
                {
                    "basePrice": num.tryParse(monthlyRentController.text) ?? '',
                    "maintenanceCharges": num.tryParse(maintenanceChargesController.text) ?? '',
                    "securityDeposit": num.tryParse(securityDepositController.text) ?? '',
                    "priceNegotiable": true
                }
            };

        // Clean up payload
        (payload['features'] as Map).removeWhere((key, value) =>
            value == null || (value is String && value.isEmpty));
        (payload['address'] as Map).removeWhere((key, value) =>
            value == null || (value is String && value.isEmpty));

        try
        {
            final response = await _propertiesRepo.updateProperty(editingPropertyId.value, payload);

            debugPrint("👁️ update response: ${response.success}");
            if (response.success)
            {
                Future.delayed(Duration.zero, ()
                    {
                        AppHelpers.showSnackBar(
                            title: "Success",
                            message: "Property updated successfully!",
                            isError: false
                        );
                        resetForm();
                    }
                );
                Get.back(result: Get.find<MyPropertyController>().loadMyProperties());
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

    // ========== FORM MANAGEMENT ==========

    Future<bool> resetForm() async
    {
        editingPropertyId.value = '';
        currentStep.value = 0;
        if (pageController.hasClients)
        {
            pageController.jumpToPage(0);
        }

        _clearAllControllers();
        _resetAllRxValues();
        _clearAllLists();
        _resetFormValidation();

        return true;
    }

    void _clearAllControllers()
    {
        // Basic Details
        titleController.clear();
        descriptionController.clear();
        areaController.clear();
        buildUpAreaController.clear();
        superBuildUpAreaController.clear();
        propertyAgeController.clear();
        bedroomsController.clear();
        bathroomsController.clear();
        balconiesController.clear();
        parkingController.clear();
        floorController.clear();
        totalFloorsController.clear();

        // Location & Features
        streetController.clear();
        areaNameController.clear();
        cityController.clear();
        stateController.clear();
        zipCodeController.clear();
        countryController.clear();
        landmarkController.clear();
        flooringTypeController.clear();
        waterSupplyController.clear();

        // Pricing & Contact
        priceController.clear();
        monthlyRentController.clear();
        maintenanceChargesController.clear();
        securityDepositController.clear();
        contactNameController.clear();
        contactPhoneController.clear();
        contactWhatsappController.clear();
        additionalNotesController.clear();

        // Nearby Places
        schoolNameController.clear();
        schoolDistanceController.clear();
        hospitalNameController.clear();
        hospitalDistanceController.clear();
        mallNameController.clear();
        mallDistanceController.clear();
        transportNameController.clear();
        transportDistanceController.clear();
    }

    void _resetAllRxValues()
    {
        debugPrint("Call Reset All Rx Values...");

        // Basic Details
        propertyType.value = 'Apartment';
        listingType.value = 'For Sale';
        furnishingStatus.value = 'Unfurnished';
        areaUnit.value = 'Sq. Ft.';
        buildUpAreaUnit.value = 'Sq. Ft.';
        superBuildUpAreaUnit.value = 'Sq. Ft.';

        // Features
        facing.value = 'North';
        contactType.value = 'Owner';

        // Boolean Values
        showBuildUpArea.value = false;
        showSuperBuildUpArea.value = false;
        powerBackup.value = false;
        servantRoom.value = false;
        poojaRoom.value = false;
        studyRoom.value = false;
        storeRoom.value = false;
        swimmingPool.value = false;
        gym.value = false;
        lift.value = false;
        security.value = false;
        garden.value = false;

        // Nearby Places
        showAddSchool.value = false;
        showAddHospital.value = false;
        showAddMall.value = false;
        showAddTransport.value = false;
        schoolDistanceUnit.value = 'meter';
        hospitalDistanceUnit.value = 'meter';
        mallDistanceUnit.value = 'km';
        transportDistanceUnit.value = 'km';
    }

    void _clearAllLists()
    {
        debugPrint("Call Clear All Lists...");

        amenities.clear();
        nearbySchools.clear();
        nearbyHospitals.clear();
        nearbyMalls.clear();
        nearbyTransport.clear();
        images.clear();
    }

    void _resetFormValidation()
    {
        debugPrint("Call Reset Form Validation...");

        for (var formKey in formKeys)
        {
            formKey.currentState?.reset();
        }
    }

    void _disposeAllControllers()
    {
        debugPrint("Call Dispose All Controllers...");
        // Basic Details
        titleController.dispose();
        debugPrint("📌 ${titleController.text}");
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

        // Location & Features
        streetController.dispose();
        areaNameController.dispose();
        cityController.dispose();
        stateController.dispose();
        zipCodeController.dispose();
        countryController.dispose();
        landmarkController.dispose();
        flooringTypeController.dispose();
        waterSupplyController.dispose();

        // Pricing & Contact
        priceController.dispose();
        monthlyRentController.dispose();
        maintenanceChargesController.dispose();
        securityDepositController.dispose();
        contactNameController.dispose();
        contactPhoneController.dispose();
        contactWhatsappController.dispose();
        additionalNotesController.dispose();

        // Nearby Places
        schoolNameController.dispose();
        schoolDistanceController.dispose();
        hospitalNameController.dispose();
        hospitalDistanceController.dispose();
        mallNameController.dispose();
        mallDistanceController.dispose();
        transportNameController.dispose();
        transportDistanceController.dispose();
    }

    // ========== HELPER METHODS ==========

    String _capitalizeFirst(String text)
    {
        if (text.isEmpty) return text;
        final words = text.split(' ');
        final capitalizedWords = words.map((word)
            {
                if (word.isEmpty) return word;
                return word[0].toUpperCase() + word.substring(1).toLowerCase();
            }
        );
        return capitalizedWords.join(' ');
    }

    String _formatListingFurnished(String furnishing)
    {
        switch (furnishing.toLowerCase())
        {
            case 'unfurnished': return 'Unfurnished';
            case 'semi-furnished': return 'Semi-Furnished';
            case 'furnished': return 'Furnished';
            default: return 'Unfurnished';
        }
    }

    String _formatListingTypeForDisplay(String listingType)
    {
        switch (listingType.toLowerCase())
        {
            case 'sale': return 'For Sale';
            case 'rent': return 'For Rent';
            case 'lease': return 'For Lease';
            default: return 'For Sale';
        }
    }

    String _formatFacingType(String facing)
    {
        switch (facing.toLowerCase())
        {
            case 'north': return 'North';
            case 'south': return 'South';
            case 'east': return 'East';
            case 'west': return 'West';
            case 'northeast': return 'North-East';
            case 'northwest': return 'North-West';
            case 'southeast': return 'South-East';
            case 'southwest': return 'South-West';
            default: return 'North';
        }
    }

    String _formatUnitForDisplay(String unit)
    {
        switch (unit.toLowerCase())
        {
            case 'sqft': return 'Sq. Ft.';
            case 'sqm': return 'Sq. M.';
            case 'acre': return 'Acre';
            case 'hectare': return 'Hectare';
            case 'meter': return 'Meter';
            case 'km': return 'Km';
            default: return 'Sq. Ft.';
        }
    }

    String _formatUnit(String unit)
    {
        switch (unit)
        {
            case 'Sq. Ft.': return 'sqft';
            case 'Sq. M.': return 'sqm';
            case 'Acre': return 'acre';
            case 'Hectare': return 'hectare';
            default: return 'sqft';
        }
    }
}
