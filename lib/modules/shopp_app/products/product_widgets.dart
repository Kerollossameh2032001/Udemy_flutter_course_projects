import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/models/shop_app/catrgoties_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../shared/style/colors.dart';

Widget productBuilder(HomeModel model, ShopCubit cubit) =>
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(e.image),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                              )))))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                height: 250.0,
                viewportFraction: 1.0,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoryItem(cubit.categoriesModel!.data.data[index]),
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.0,
                ),
                itemCount: cubit.categoriesModel!.data.data.length,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            const Text(
              'New Products',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.blueGrey[100],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.82,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], cubit)),
              ),
            )
          ],
        ),
      ),
    );

Stack buildCategoryItem(DataModel model) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        width: 100.0,
        color: Colors.black87.withOpacity(0.8),
        child: Text(
          model.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

Widget buildGridProduct(ProductModel model, ShopCubit cubit) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,
              fit: BoxFit.fill,
            ),
            if (model.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, height: 1.3),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(color: defaultColor, fontSize: 12.0),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      cubit.changeFavoritesItem(model.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor: cubit.favorites[model.id]!
                          ? defaultColor
                          : Colors.grey,
                      radius: 15.0,
                      child:  Icon(
                        color: Colors.white,
                        Icons.favorite_border,
                        size: 14.0,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
