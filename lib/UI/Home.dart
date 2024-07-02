import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weatherassign/Data/Provider.dart';
import 'package:weatherassign/Data/datasouce.dart';
import 'package:weatherassign/UI/Details.dart';
import 'package:weatherassign/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cityProvider = Provider.of<CityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: cityProvider.filterCities,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<City>>(
              future: cityProvider.cities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No cities found'));
                }
                final cities = snapshot.data!;
                return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider<WeatherBlocBloc>(
                                create: (context) => WeatherBlocBloc()
                                  ..add(fetchWeather(cityName: city.city)),
                                child: const WeatherDetailsScreen(
                                    cityName: 'Patna'))));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(city.city),
                          subtitle: Text('${city.country}'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
