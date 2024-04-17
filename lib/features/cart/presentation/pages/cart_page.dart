import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/square_button.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/cart/presentation/widgets/remove_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var items = [
      '1',
      '2',
      '3',
      '4',
      '5',
    ];
    return Scaffold(
      appBar: const AppBarSearchBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: AppPallete.lightgreyColor,
            height: 50,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Cart',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '(4 items)',
                      style: TextStyle(
                        color: AppPallete.greyTextColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  'AED 12352.00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    child: Row(
                      children: [
                        //for the first column
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //for the heading
                              const Text(
                                'Sony PlayStation 5 Console (Disc Version) With Controller',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Constants.kHeight,
                              //for the price
                              const Row(
                                children: [
                                  Text(
                                    'AED',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '1779.0',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Constants.kHeight,
                              //for the delivery
                              const Row(
                                children: [
                                  Text(
                                    'Free Delivery by',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Tomorrow, Mar 5',
                                    style: TextStyle(
                                      color: AppPallete.primaryAppButtonColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              Constants.kHeight,
                              //for the vendor name
                              const Row(
                                children: [
                                  Text('Sold by'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'i-Gadgets',
                                    style: TextStyle(
                                      // color: AppPallete.primaryAppButtonColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              Constants.kHeight,
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  hint: Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  // value: '1',
                                  onChanged: (String? value) {
                                    // setState(() {
                                    //   selectedValue = value;
                                    // });
                                  },
                                  iconStyleData: const IconStyleData(
                                    icon: SvgIcon(
                                      icon: CustomIcons.angleDownSvg,
                                      radius: 10,
                                    ),
                                    openMenuIcon: SvgIcon(
                                      icon: CustomIcons.angleUpSvg,
                                      radius: 10,
                                    ),
                                  ),
                                  buttonStyleData: const ButtonStyleData(
                                    elevation: 1,
                                    overlayColor:
                                        MaterialStatePropertyAll<Color>(
                                      AppPallete.darkgreyColor,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppPallete.darkgreyColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          5,
                                        ),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14),
                                    width: 70,
                                    height: 30,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),

                              // for the carted item
                              // Container(
                              //   height: 30,
                              //   width: 70,
                              //   decoration: const BoxDecoration(
                              //     color: AppPallete.darkgreyColor,
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(
                              //         5,
                              //       ),
                              //     ),
                              //   ),
                              //   child: InkWell(
                              //     onTap: () {

                              //     },
                              //     child: const Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceAround,
                              //       children: [
                              //         Text('2'),
                              //         SvgIcon(
                              //           icon: CustomIcons.angleDownSvg,
                              //           radius: 10,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        //for the second column with image and remove and favourite button

                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/dev/hp-laptop-png.png',
                                fit: BoxFit.contain,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //remove button
                                  RemoveButton(
                                    onTap: () {},
                                  ),
                                  //heart button
                                  const SquareButton(
                                    icon: SvgIcon(
                                      icon: CustomIcons.heartSvg,
                                      color: AppPallete.greyTextColor,
                                      radius: 5,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 10,
                  color: AppPallete.lightgreyColor,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
