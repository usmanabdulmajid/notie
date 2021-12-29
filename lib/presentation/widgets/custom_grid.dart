import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomGrid extends StatelessWidget {
  final String title;
  final String body;
  final int index;
  const CustomGrid(
      {Key? key, required this.title, required this.body, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
      crossAxisCount: 4,
      itemCount: 23,
      itemBuilder: (BuildContext context, int index) => Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'note ${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Text(
                '''nm,dnm,n,mnjfmnfmvfnvnmfvnmfnmfvn,mfnv,mnf,mn,mfnvfmbvb,nf,bvnmbfvnmbv,mfjbvjbnkjrhntkjgrbhjnrfvjnjhnkjnvkjdn,jbdcd,hjbad,djbnckjn,kjhfkjhckjehfckjhrkfjhr''',
                overflow: TextOverflow.ellipsis,
                maxLines: index.isOdd ? 12 : 6,
              ),
            )
          ],
        ),
      ),
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(2, index.isOdd ? 2 : 1.5);
      },
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 10.0,
    );
  }
}
