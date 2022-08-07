import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/favorites_model.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) =>
              buildFavItem(cubit.favoritesData!.data!.data![index],context),
          separatorBuilder: (context, index) => Divider(),
          itemCount:cubit.favoritesData!.data!.data!.length,
        );
      },
    );
  }

  Container buildFavItem(FavoriteItemData model, context) {
    return Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.product!.image!),
              height: 120,width: 120,
              fit: BoxFit.fill,
            ),
            if (model.product!.discount! != 0)
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, height: 1.3),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '${model.product!.price!.round()}',
                    style: TextStyle(color: defaultColor, fontSize: 12.0),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  //if (model.product!.discount! != 0)
                    Text(
                      '${model.product!.oldPrice!.round()}',
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
                      ShopCubit.get(context).changeFavoritesItem(model.product!.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id]! ? defaultColor : Colors.grey,
                      radius: 15.0,
                      child: Icon(
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
}

/*class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Image(image: NetworkImage('https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg'));
          /*ListView.separated(
          itemBuilder: (context, index) => ),
             // buildFavItem(cubit.favoritesData!.data!.data![index], context),
          separatorBuilder: (context, index) => Divider(),
          itemCount: cubit.favoritesData!.data!.data!.length,
        )*/
      },
    );
  }
*/

//}
/*
* Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product!.image!),
                width: double.infinity,
                height: 200,
                fit: BoxFit.fill,
              ),
              if (model.product!.discount! != 0)
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.product!.price!.round()}',
                      style: TextStyle(color: defaultColor, fontSize: 12.0),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if (model.product!.discount! != 0)
                      Text(
                        '${model.product!.oldPrice!.round()}',
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
                        ShopCubit.get(context)
                            .changeFavoritesItem(model.product!.id!);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.product!.id]!
                                ? defaultColor
                                : Colors.grey,
                        radius: 15.0,
                        child: Icon(
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
    )*/