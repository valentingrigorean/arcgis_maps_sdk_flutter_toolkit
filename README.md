# ArcGIS Maps SDK Flutter Toolkit

Enhance your Flutter applications with advanced mapping capabilities using the ArcGIS Maps SDK Flutter Toolkit. This package provides additional widgets and utilities, such as a Compass widget, to improve interaction with the ArcGIS Maps SDK for Flutter.

## Features

- **Compass Widget**: Enhance your maps with a fully functional compass that indicates north and auto-hides when the map is aligned accordingly.

## Getting Started

To integrate the ArcGIS Maps SDK Flutter Toolkit into your project, follow these steps:

### Prerequisites

Ensure you have Flutter installed on your system and have set up the ArcGIS Maps SDK for Flutter. If you haven't set up the SDK yet, visit [earlyadopter.esri.com](https://earlyadopter.esri.com/) to download the package and follow the unpacking instructions.

### Installation

Clone or download the `arcgis_maps_sdk_flutter_toolkit` next to your `arcgis_maps_package`. Your directory structure should look like this:

```
parent_directory
   |
   |__ arcgis_maps_sdk_flutter_toolkit
   |
   |__ arcgis_maps_package
```

## Usage

Import the toolkit in your Flutter project and use the components like the Compass widget:

```dart
import 'package:arcgis_maps_sdk_flutter_toolkit/arcgis_maps_sdk_flutter_toolkit.dart';

ArcGISMapViewController controller = ArcGISMapViewController();

Widget compass = Compass(
  width: 50,
  height: 50,
  autoHide: true,
  controller: controller,
);
```

## Licensing

### Toolkit Licensing

The `arcgis_maps_sdk_flutter_toolkit` is open-source and is licensed under the MIT License. This allows you to use and modify the toolkit for free, even in commercial applications.

### External SDK Licensing
Please note that while the arcgis_maps_sdk_flutter_toolkit is free to use under the MIT License, using the ArcGIS Maps SDK for Flutter, which is required for some functionalities of the toolkit, is subject to the licensing terms and conditions imposed by Esri. Ensure you comply with Esri's license terms when using their SDK.

For details on the licensing of the ArcGIS Maps SDK for Flutter, please refer to Esri's official licensing page.