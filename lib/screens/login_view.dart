import 'package:flutter/material.dart';

import 'package:New_Project_KMUTTNEWS/tabview/login_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/register_tab_view.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center, // การจัดในแกนขวาง  ขนาดไม่เท่ากัน ก็ได้
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'KMUTT NEWS',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Itim',
                        fontSize: 28,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: DefaultTabController(
                  length: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15, //ขอบขาว ถึงตัวหนังสือ
                        ),
                        Container(
                          constraints: BoxConstraints.expand(height: 50),
                          child: TabBar(
                              indicatorWeight: 3, //ความหนาของเส้นขีดเส้นใต้
                              indicatorColor: Colors.orange,
                              labelColor: Colors.orange,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                    child: Text('Login',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: 'Itim'))),
                                Tab(
                                    child: Text('Register',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: 'Itim'))),
                              ]),
                        ),
                        Expanded(
                            child: Container(
                          child: TabBarView(children: <Widget>[
                            LoginTabView(),
                            RegisterTabView(),
                          ]),
                        ))
                      ],
                    ),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
