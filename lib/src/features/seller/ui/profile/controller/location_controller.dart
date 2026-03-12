import 'package:get/get.dart';
import '../model/location_model.dart';
import '../repository/profile_repository.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();
  final ProfileRepository apiService = ProfileRepository();

  // Observables
  final RxList<Datum> countries = <Datum>[].obs;
  final RxList<Datum> states = <Datum>[].obs;
  final RxList<Datum> cities = <Datum>[].obs;

  // Dropdown visibility states (make them reactive)
  final RxBool isCountryDropdownOpen = false.obs;
  final RxBool isStateDropdownOpen = false.obs;
  final RxBool isCityDropdownOpen = false.obs;

  // Selected values
  final Rx<Datum?> selectedCountry = Rx<Datum?>(null);
  final Rx<Datum?> selectedState = Rx<Datum?>(null);
  final Rx<Datum?> selectedCity = Rx<Datum?>(null);

  // Loading states
  final RxBool isLoadingCountries = false.obs;
  final RxBool isLoadingStates = false.obs;
  final RxBool isLoadingCities = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  @override
  void onClose() {
    countries.clear();
    states.clear();
    cities.clear();
    super.onClose();
  }

  // Fetch all countries
  Future<void> fetchCountries() async {
    try {
      isLoadingCountries.value = true;
      print('Fetching countries...'); // Debug
      final response = await apiService.getCountries();
      print('Countries response status: ${response.status}'); // Debug
      print('Countries data length: ${response.data?.length ?? 0}'); // Debug
      if (response.status == true && response.data != null) {
        countries.assignAll(response.data!);
        print('Successfully assigned ${response.data!.length} countries'); // Debug
      }
    } catch (e) {
      print('Error fetching countries: $e');
    } finally {
      isLoadingCountries.value = false;
    }
  }

  // Fetch states by country ID
  Future<void> fetchStates(int countryId) async {
    try {
      isLoadingStates.value = true;
      states.clear();
      selectedState.value = null;
      cities.clear();
      selectedCity.value = null;

      final response = await apiService.getStates(countryId);
      if (response.status == true && response.data != null) {
        states.assignAll(response.data!);
      }
    } catch (e) {
      print('Error fetching states: $e');
    } finally {
      isLoadingStates.value = false;
    }
  }

  // Fetch cities by state ID
  Future<void> fetchCities(int stateId) async {
    try {
      isLoadingCities.value = true;
      cities.clear();
      selectedCity.value = null;

      final response = await apiService.getCities(stateId);
      if (response.status == true && response.data != null) {
        cities.assignAll(response.data!);
      }
    } catch (e) {
      print('Error fetching cities: $e');
    } finally {
      isLoadingCities.value = false;
    }
  }

  // Set selected country and fetch its states
  void setSelectedCountry(Datum? country) {
    selectedCountry.value = country;
    if (country != null) {
      print('Selected country: ${country.name} (ID: ${country.id})');
      fetchStates(country.id!);
    } else {
      states.clear();
      selectedState.value = null;
      cities.clear();
      selectedCity.value = null;
    }
  }

  // Set selected state and fetch its cities
  void setSelectedState(Datum? state) {
    selectedState.value = state;
    if (state != null) {
      print('Selected state: ${state.name} (ID: ${state.id})');
      fetchCities(state.id!);
    } else {
      cities.clear();
      selectedCity.value = null;
    }
  }

  // Set selected city
  void setSelectedCity(Datum? city) {
    selectedCity.value = city;
    if (city != null) {
      print('Selected city: ${city.name}');
    }
  }

  // Clear all selections
  void clearAll() {
    selectedCountry.value = null;
    selectedState.value = null;
    selectedCity.value = null;
    states.clear();
    cities.clear();
  }
}