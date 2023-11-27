import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:target_cards/stores/cards.dart';
import 'package:target_cards/themes/colors.dart';
import 'package:target_cards/ui/components/custom_action_dialog.dart';
import 'package:target_cards/ui/components/custom_text_field.dart';
import 'package:target_cards/ui/components/privacy_policy_button.dart';
import 'package:target_cards/ui/widgets/cards/card_component.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final cards = Cards();

  late final ScrollController scrollController;
  late final FocusNode focusNode;
  late final TextEditingController textEditingController;

  int? cardIndexToUpdate;

  @override
  void initState() {
    cards.initialize();
    scrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    Future.delayed(const Duration(milliseconds: 400), () => _scrollStart());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void _scrollStart() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1800),
        curve: Curves.fastOutSlowIn);
  }

  void _showDeleteDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomActionDialog(
              text:
                  "Tem certeza que deseja excluir esse as informações desse cartão?",
              subText: "O card será removido permanentemente de sua aplicação",
              customAction: () {
                Navigator.of(context).pop();
                cards.remove(index);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    var keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return GestureDetector(
        onTap: () {
          cardIndexToUpdate = null;
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
            decoration: BoxDecoration(gradient: AppColors.appBackgroundColor),
            child: SafeArea(
                child: ResponsiveBuilder(builder: (context, sizingInformation) {
              var cardsManagementBoxSize = keyboardIsOpen
                  ? sizingInformation.screenSize.height * .48
                  : sizingInformation.screenSize.height * .65;
              var textFieldWidth = sizingInformation.screenSize.width * .8;

              return Column(
                children: [
                  SizedBox(
                      height: cardsManagementBoxSize,
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Observer(builder: (_) {
                              return cards.items.isEmpty
                                  ? const CircularProgressIndicator()
                                  : ListView.separated(
                                      controller: scrollController,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: cards.items.length,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              cardsManagementBoxSize * .14,
                                          horizontal:
                                              cardsManagementBoxSize * .05),
                                      reverse: true,
                                      shrinkWrap: true,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                              width:
                                                  cardsManagementBoxSize * .06),
                                      itemBuilder: (context, index) {
                                        bool canUpdate =
                                            (cards.items.length - 1) != index;
                                        return CardComponent(
                                            text: cards.items[index],
                                            index: index,
                                            cardWidth: textFieldWidth,
                                            canUpdate: canUpdate,
                                            onUpdate: canUpdate
                                                ? (int index) {
                                                    cardIndexToUpdate = index;
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            focusNode);
                                                  }
                                                : null,
                                            onDelete: canUpdate
                                                ? (int index) =>
                                                    _showDeleteDialog(index)
                                                : null);
                                      });
                            })),
                            CustomTextField(
                                fieldHeight: 60,
                                fieldWidth: textFieldWidth,
                                controller: textEditingController,
                                focusNode: focusNode,
                                inputAction: TextInputAction.done,
                                label:
                                    keyboardIsOpen ? null : "Digite seu texto",
                                onDone: (String text) {
                                  if (text.isNotEmpty) {
                                    textEditingController.clear();
                                    if (cardIndexToUpdate != null) {
                                      cards.update(cardIndexToUpdate!, text);
                                      cardIndexToUpdate = null;
                                    } else {
                                      cards.add(text);
                                    }
                                  } else {
                                    cardIndexToUpdate = null;
                                  }
                                },
                                onTap: () => _scrollStart(),
                                border: false)
                          ])),
                  const Expanded(child: Center(child: PrivacyPolicyButton()))
                ],
              );
            }))));
  }
}
