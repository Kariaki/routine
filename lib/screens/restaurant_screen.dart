import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key,required this.id,this.promoCode});
  final String id;
  final String? promoCode;
  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Restaurant details'),
      ),
      body: Center(
        child: Text('Welcome to this restaurant -> ${widget.id}'),
      ),
    );
  }
}
