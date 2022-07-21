import 'package:becadmin/screens/addOns/utils/commonAddOn.dart';
import 'package:becadmin/screens/uploads/widgets/text_addOn_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/addOns/testController.dart';
import '../../controllers/addOns/yearController.dart';

class AddTestYear extends StatefulWidget {
  const AddTestYear({Key? key}) : super(key: key);

  @override
  State<AddTestYear> createState() => _AddTestYearState();
}

class _AddTestYearState extends State<AddTestYear> {
  final _testController = TextEditingController();
  final testCont = Get.put(TestController());

  final _yearController = TextEditingController();
  final yearCont = Get.put(YearController());

  @override
  void initState() {
    testCont.fetchTests();
    yearCont.fetchYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('add years and tests')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.35,
                child: CommonAddOnScreen(
                  'Test',
                  _testController,
                  () => testCont.addNewTest(_testController.text),
                  GetBuilder<TestController>(builder: (_) {
                    return SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: testCont.testList
                            .map((each) =>
                                TextAddOnChip('test', each, _testController))
                            .toList(),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: size.height * 0.4,
                child: CommonAddOnScreen(
                  'Year',
                  _yearController,
                  () => yearCont.addNewYear(_yearController.text),
                  GetBuilder<YearController>(builder: (_) {
                    return SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: yearCont.yearList
                            .map((each) =>
                                TextAddOnChip('year', each, _yearController))
                            .toList(),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
