import 'package:flutter/material.dart';
import 'package:prueba_pragma/blocs/cat_information_bloc.dart';
import 'package:prueba_pragma/blocs/cat_information_event.dart';
import 'package:prueba_pragma/blocs/cat_information_state.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/screens/detail_screen.dart';
import 'package:prueba_pragma/utilities/colors.dart';
import 'package:prueba_pragma/utilities/dimens.dart';
import 'package:prueba_pragma/utilities/strings.dart';
import 'package:prueba_pragma/widgets/card_info_cat_information.dart';
import 'package:prueba_pragma/widgets/image_card_cat_information.dart';
import 'package:prueba_pragma/widgets/tittle_home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
          colors: <Color>[
            firstColorApp,
            secondColorApp,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(toolbarHeight: 0),
        body: BlocBuilder<CatInformationBloc, CatInformationState>(
          builder: (context, state) {
            if (state is CatInformationInitial) {
              BlocProvider.of<CatInformationBloc>(context)
                  .add(FetchCatInformation());
            } else if (state is CatInformationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CatInformationLoaded) {
              return Column(
                children: [
                  const SizedBox(height: sizeSpacing),
                  const TittleHomeScreen(),
                  const SizedBox(height: sizeSpacing),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: paddingVerticalSearchInputHomeScreen,
                        right: paddingVerticalSearchInputHomeScreen),
                    child: TextField(
                      onChanged: (query) {
                        context
                            .read<CatInformationBloc>()
                            .add(FilterCatInformationByName(query));
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: borderCardColor),
                            borderRadius: BorderRadius.all(Radius.circular(
                                borderRadiusSearchInputHomeScreen))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: borderCardColor),
                            borderRadius: BorderRadius.all(Radius.circular(
                                borderRadiusSearchInputHomeScreen))
                        ),
                        fillColor: backgroundLabelCard,
                        hintText: searchHintHomeScreen,
                        prefixIcon: Icon(Icons.search_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: borderCardColor),
                          borderRadius: BorderRadius.all(Radius.circular(
                              borderRadiusSearchInputHomeScreen)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: sizeSpacing),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.catInformationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              const EdgeInsets.all(paddingCardCatHomeScreen),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: sizeBorder, color: borderCardColor),
                                borderRadius: BorderRadius.circular(
                                    borderCardCatHomeScreen),
                                color: backgroundCards),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CardInfoCatInformation(
                                      icon: Icons.card_membership_outlined,
                                      label:
                                          state.catInformationList[index].name,
                                      color: backgroundCards,
                                    ),
                                    CardInfoCatInformation(
                                      icon: Icons.remove_red_eye,
                                      label: seeMoreLabelHomeScreen,
                                      method: goToDetailScreen,
                                      catInformation:
                                          state.catInformationList[index],
                                      color: secondColorApp,
                                    )
                                  ],
                                ),
                                ImageCardCatInformation(
                                    imageId: state
                                        .catInformationList[index].imageId),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CardInfoCatInformation(
                                        icon: Icons.location_on,
                                        label: state
                                            .catInformationList[index].origin,
                                        color: backgroundLabelCard),
                                    CardInfoCatInformation(
                                        icon: Icons.lightbulb_rounded,
                                        label: state.catInformationList[index]
                                            .intelligence,
                                        color: backgroundLabelCard),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else if (state is CatInformationError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text(unknownState));
          },
        ),
      ),
    );
  }

  void goToDetailScreen(CatInformation catInformation, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          catInformation: catInformation,
        ),
      ),
    );
  }
}
