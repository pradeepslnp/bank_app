import 'package:bank/animation.dart';
import 'package:bank/application/application_business.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PANFormScreen extends StatefulWidget {
  @override
  State<PANFormScreen> createState() => _PANFormScreenState();
}

class _PANFormScreenState extends State<PANFormScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PanFormBusiness>(context, listen: false).resetForm();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Exit App"),
            content: const Text("Do you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Yes"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<PanFormBusiness>(
            builder: (context, viewModel, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text(
                        "First Few steps to set\nyou up with a Bank Account",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("PAN NUMBER"),
                      ],
                    ),
                    SizedBox(
                      // width: 350.0,
                      // height: 50,
                      child: TextField(
                        controller: viewModel.panController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "PAN NUMBER",
                        ),
                        onChanged: viewModel.setPAN,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("BIRTHDATE"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: viewModel.dayController,
                            maxLength: 2,
                            decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: "DD",
                                fillColor: Colors.white10),
                            keyboardType: TextInputType.number,
                            onChanged: viewModel.setDay,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: viewModel.monthController,
                            maxLength: 2,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: "MM",
                                fillColor: Colors.white10),
                            keyboardType: TextInputType.number,
                            onChanged: viewModel.setMonth,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: viewModel.yearController,
                            maxLength: 4,
                            decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: "YYYY",
                                fillColor: Colors.white10),
                            keyboardType: TextInputType.number,
                            onChanged: viewModel.setYear,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // if (viewModel.errorMessage.isNotEmpty)
                    //   Text(
                    //     viewModel.errorMessage,
                    //     style: const TextStyle(color: Colors.red, fontSize: 14),
                    //   ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: InkWell(
                        onTap: () async {
                          if (viewModel.isValid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Details submitted successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Provider.of<PanFormBusiness>(context, listen: false)
                                .resetForm();
                            setState(() {});

                            navigateWithFade(context, SuccessScreen());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(viewModel.errorMessage),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(color: Colors.blue, spreadRadius: 3),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            child: Center(
                                child: const Text(
                              "NEXT",
                              style: TextStyle(color: Colors.white),
                            ))),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigateWithFade(context, const HomePage());
                      },
                      child: const Text("I don’t have a PAN"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Success")),
      body: const Center(child: Text("Details Submitted Successfully!")),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(title: const Text("Home Page")),
        body: const Center(child: Text("")),
      ),
    );
  }
}

Future<bool> _onWillPop(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit App"),
          content: Text("Do you want to go back ?"),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // Dismiss dialog
              child: Text("No"),
            ),
            TextButton(
              onPressed: () =>
                  navigateWithFade(context, PANFormScreen()), // Allow exit
              child: Text("Yes"),
            ),
          ],
        ),
      ) ??
      false;
}
