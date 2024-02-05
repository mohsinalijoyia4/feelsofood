import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_ai/res/app_colors.dart';
import 'package:recipe_ai/view/pages/HistoryDetails.dart';
import 'package:recipe_ai/view_model/history_view_model.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Recipe History",
          style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: ChangeNotifierProvider(
        create: (context) => HistoryViewModel(),
        child: Consumer<HistoryViewModel>(
          builder: (context, value, child) {
            if(value.isLoading){
              return const Center(child: CircularProgressIndicator(color: AppColors.orangeColor,),);
            }

            if(!value.isLoading && value.model.isEmpty){
              return const Center(child: Text("No History Found", style: TextStyle(fontSize: 19),));
            }

            return SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...value.model.asMap().entries.map((e) => GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetails(model: e.value),));

                      },
                      child: Card(
                        child:  Container(width: MediaQuery.of(context).size.width * 0.95, child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              child:  ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                child: CachedNetworkImage(
                                  imageUrl: e.value.imageUrl,
                                  placeholder: (context, url) =>  Container(
                                    width: double.infinity,
                                    height: 360,

                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                    ),
                                    child: Center(child: CircularProgressIndicator(color: AppColors.orangeColor,),),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),

                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10,),
                                    Text(e.value.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                    const SizedBox(height: 5,),
                                    Align(alignment: Alignment.topLeft,child: Text("${e.value.description.trim().substring(0, 30)}...", style: TextStyle(fontSize: 15),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),),
                      ),
                    ))

                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
