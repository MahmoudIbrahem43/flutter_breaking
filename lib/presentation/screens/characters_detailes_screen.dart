import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/characters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/character.dart';

class CharacterDetailesScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailesScreen({Key key, @required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColor.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('job : ', character.jobs.join(' / ')),
                  buildDivider(300),
                  characterInfo(
                      'Appeared in : ', character.categoryForTwoSeries),
                  buildDivider(250),
                  characterInfo(
                      'Seasons : ', character.appearanceOfSeasons.join(' / ')),
                  buildDivider(280),
                  characterInfo('Status  : ', character.statusIfDeadOrAlive),
                  buildDivider(300),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : characterInfo('Better Call Saul Seasons  : ',
                          character.betterCallSaulAppearance.join(' / ')),
                  character.betterCallSaulAppearance.isEmpty
                      ? Container()
                      : buildDivider(150),
                  characterInfo('Actor/Actress : ', character.acotrName),
                  buildDivider(235),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CharactersCubit, CharactersState>(
                    builder: (context, state) {
                      return checkIfQuotesAreLoaded(state);
                    },
                  ),
                ],
              )),
            )
          ]))
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(
            color: MyColor.myWhite,
          ),
          // textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId, //must be unique
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
            color: MyColor.myWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: MyColor.myWhite,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColor.myYello,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      showProgressIndicator();
    }
    return showProgressIndicator();
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          //widget with animation
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColor.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColor.myYello,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColor.myYello,
      ),
    );
  }
}
