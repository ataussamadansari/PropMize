import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHistoryLoader extends StatelessWidget
{
    const ShimmerHistoryLoader({super.key});

    @override
    Widget build(BuildContext context) 
    {
        return Shimmer.fromColors(
            baseColor: Colors.grey.withAlpha(100),
            highlightColor: Colors.grey.withAlpha(25),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  spacing: 4,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    Container(
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ],
                )
            )
        );
    }
}
