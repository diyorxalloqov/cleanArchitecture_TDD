import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_lesson/modules/weather/data/repository/weather_impl.dart';
import 'package:structure_lesson/modules/weather/domain/usecase/get_weather.dart';
import 'package:structure_lesson/application/bloc/weather_bloc.dart';
import 'package:structure_lesson/utils/enum.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc weatherBloc;

  @override
  void initState() {
    weatherBloc = WeatherBloc(GetWeatherUseCase(
        repo: RepositoryProvider.of<WeatherRepositoryImpl>(context)))
      ..add(GetWeather());

    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: weatherBloc,
        child: BlocListener<WeatherBloc, WeatherState>(
          listenWhen: (state1, state2) {
            return state2.status == ActionStatus.isFailure;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorText)));
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("TDD Clean Architechture"),
            ),
            body: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state.status == ActionStatus.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state.status == ActionStatus.isSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.list[index].first_name),
                          subtitle: Text(state.list[index].email),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Error`'),
                  );
                }
              },
            ),
          ),
        ),
      );
}
