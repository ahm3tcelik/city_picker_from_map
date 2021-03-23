# City Picker From Map 

A flutter package for select a city from svg map.

![](https://github.com/ahm3tcelik/city_picker_from_map/blob/master/showcase/selecting_city.gif)

Supported countries (+150) are [here](https://github.com/ahm3tcelik/city_picker_from_map/blob/master/lib/src/maps.dart).

## Screenshots
![](https://github.com/ahm3tcelik/city_picker_from_map/blob/master/showcase/responsive.gif)


![](https://github.com/ahm3tcelik/city_picker_from_map/blob/master/showcase/ss3.jpg)
![](https://github.com/ahm3tcelik/city_picker_from_map/blob/master/showcase/ss4.png)

## Getting Started

In the `pubspec.yaml` of your **Flutter** project, add the following dependency:

```yaml
dependencies:
  ...
  city_picker_from_map: any
```

In your library file add the following import:

```dart
import 'package:city_picker_from_map/city_picker_from_map.dart';
```

## Usage

```dart
CityPickerMap(
	width: double.infinity,
	height: double.infinity,
	map: Maps.TURKEY,
	onChanged: (city) {
	  setState(() {
		selectedCity = city;
	  });
	},
	actAsToggle: true,
	dotColor: Colors.white,
	selectedColor: Colors.lightBlueAccent,
	strokeColor: Colors.white24,
)
```
## Props
| props                   | types           | description                                                                                                     |
| :---------------------- | :-------------: | :---------------------------------------------------------------------------------------------------------------: |
| key        | `Key?`        |  |
| map       | `String`     | Name of the map you want to show. Use as Maps.<MAP_NAME> All maps are in the [maps.dart](https://github.com/ahm3tcelik/city_picker_from_map/blob/master/lib/src/maps.dart)  |
| width           | `double?`     | Map width. Default value is double.infinity |
| height       | `double?`     | Map height. Default value is double.infinity |
| dotColor | `Color?`         | Color of the dot in the center of the city  |
| strokeColor       | `Color?`     | Color of the city borders |
| selectedColor       | `Color?`     | Color of the selected city |
| actAsToggle | `boolean?`         | City selecting act as like toggle button |
| onChanged       | `Function(City? city)`     | Returns new city value when it changed |

Author
------

* [Ahmet ÇELİK](https://github.com/ahm3tcelik/)
