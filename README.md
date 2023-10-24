## Project Overview
This weather app is designed to fetch weather data from the Open Meteo API and display it in a user-friendly manner. It is built using Flutter with Riverpod for state management.

## Features
- Display current weather conditions, including temperature, humidity, wind speed, and more.
- Provide 7-day weather forecast and hourly forecast for a given location.

## Getting Started
Follow these steps to set up and run the weather app on your local development environment:

### Prerequisites
- Ensure you have Flutter installed. If not, you can follow the installation instructions at [Flutter's official website](https://flutter.dev/docs/get-started/install).
- Clone the repository to your local machine.

### Installation
1. Open a terminal and navigate to the project directory.
2. Run the following command to fetch the project dependencies:

   ```bash
   flutter pub get
   ```

### Running the App
1. Open a terminal and navigate to the project directory.
2. Run the app on an emulator or a physical device with the following command:

   ```bash
   flutter run
   ```

The app should now be up and running, displaying weather information based on your location or the location you search for.

## Code Structure
The project follows a structured organization to keep the code clean and maintainable:

- `lib/` - Contains the main Dart code for the app.
  - `main.dart` - The entry point of the app.
  - `providers.dart` - Contains Riverpod providers for managing state.
  - `pages/` - Houses the different screens of the app.
  - `data/` - Includes services for interacting with various data sources.
  - `repositories/` - Includes repositories for fetching data from different sources.
  - `widgets/` - Contains reusable widgets used throughout the app.
  - `models/` - Includes data models and business logic for the app.

## Data Source
- Open Meteo API is used to fetch weather data.
- For demo purposes, geocoding is hard-coded (`repositories/location/geocoding_data.dart`). In a real-world app, it would be fetched from a geocoding API.
- WMO code's description is provided from [this repo](https://gist.github.com/stellasphere/9490c195ed2b53c707087c8c2db4ec0c).

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
