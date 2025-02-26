import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:konfio_app_dog/config/colors.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:konfio_app_dog/general_widgets/skeleton.dart';

class CardDogWidget extends StatelessWidget {
  const CardDogWidget({
    super.key,
    required this.dog,
  });

  final DogModel dog;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.background,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              height: 200,
              child: CachedNetworkImage(
                imageUrl: dog.image!,
                placeholder: (context, url) => const Skeleton(
                  height: 15,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/home/dog3.jpeg'),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 170,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dog.dogName!,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(dog.description!,
                            style: const TextStyle(color: AppColors.secondary)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Almost ${dog.age!} years',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
