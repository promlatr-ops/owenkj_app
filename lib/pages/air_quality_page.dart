import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/aqicn_service.dart';

class AirQualityPage extends StatefulWidget {
  const AirQualityPage({super.key});

  @override
  State<AirQualityPage> createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  String _status = 'Initializing...';
  AqiResponse? _response;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      setState(() {
        _loading = true;
        _status = 'Checking permissions...';
      });
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final req = await Geolocator.requestPermission();
        if (req == LocationPermission.denied || req == LocationPermission.deniedForever) {
          setState(() {
            _status = 'Location permission denied';
            _loading = false;
          });
          return;
        }
      }

      setState(() => _status = 'Getting location...');
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final token = dotenv.env['AQICN_TOKEN'];
      if (token == null || token.isEmpty) throw Exception('AQICN_TOKEN not set in .env');

      setState(() => _status = 'Fetching air quality...');
      final service = AqicnService(token);
      final resp = await service.fetchByGeo(pos.latitude, pos.longitude);

      setState(() {
        _response = resp;
        _status = 'Updated';
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _status = 'Error: ${e.toString()}';
        _loading = false;
      });
    }
  }

  String _formatTime(DateTime? t) {
    if (t == null) return '-';
    return DateFormat.yMd().add_Hm().format(t.toLocal());
  }
  Color _aqiColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow.shade700;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  String _aqiCategory(int aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }

  Widget _buildCard() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_response == null) return Center(child: Text(_status));

    final aqiVal = _response!.aqi ?? -1;
    final aqi = aqiVal >= 0 ? aqiVal.toString() : '-';
    final pm = _response!.pm25 != null ? _response!.pm25!.toStringAsFixed(1) : '-';
    final station = _response!.station;
    final time = _formatTime(_response!.time);
    final color = aqiVal >= 0 ? _aqiColor(aqiVal) : Colors.grey;
    final category = aqiVal >= 0 ? _aqiCategory(aqiVal) : 'Unknown';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(station, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  child: Center(
                      child: Text(aqi, style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold))),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('PM2.5', style: TextStyle(color: Colors.white70)),
                            Text(pm, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                          ]),
                          const SizedBox(width: 24),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Last update', style: TextStyle(color: Colors.white70)),
                            Text(time, style: const TextStyle(color: Colors.white70)),
                          ])
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: _load, icon: const Icon(Icons.refresh), label: const Text('Refresh'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Air Quality'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E335A), Color(0xFF4B6CB7)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                      Text('Current Air', style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 6),
                      Text('PM2.5 & AQI', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ]),
                    IconButton(onPressed: _load, icon: const Icon(Icons.refresh, color: Colors.white))
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: SingleChildScrollView(child: _buildCard())),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(_status, style: const TextStyle(color: Colors.white70)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/products');
                      },
                      icon: const Icon(Icons.info_outline, color: Colors.white70))
                ]),
              ),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _load,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
