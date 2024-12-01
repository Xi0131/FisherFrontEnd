import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 用來跟蹤選擇的是 Captain 還是 Crew
  String selectedRole = 'Captain'; // 預設選擇 Captain

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F5), // 背景顏色
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(40), // padding: 與邊邊留白的距離
          width: 1000, // 邊框長度
          height: 750,

          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(40), // 圓角
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withOpacity(0.1), //陰影特效
                blurRadius: 15, //陰影模糊半徑
                spreadRadius: 8, //陰影擴散半徑
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text( // SIGN IN
                'SIGN IN',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.black,
                ),
              ),
              const SizedBox(height: 45),
              // Captain 和 Crew 選擇按鈕
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Captain 按鈕
                  CupertinoButton(
                    padding: EdgeInsets.zero, // 移除 CupertinoButton 的默認內邊距
                    onPressed: () {
                      setState(() {
                        selectedRole = 'Captain';
                      });
                    },

                    child: Container(
                      padding: const EdgeInsets.symmetric(// 按鈕內的邊距（上下 15 像素，左右 25 像素），使文字有足夠的空間
                        vertical: 25,
                        horizontal: 50,
                      ),
                      decoration: BoxDecoration(// 控制外觀
                        color: selectedRole == 'Captain'
                            ? CupertinoColors.activeBlue // 選中為blue
                            : CupertinoColors.lightBackgroundGray, // 否則為灰色
                        borderRadius: const BorderRadius.only( // 只圓角左上角跟左下角
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Captain',
                        style: TextStyle(
                          fontSize: 50, // 增加字體大小
                          fontWeight: FontWeight.bold, //文字加粗
                          color: selectedRole == 'Captain' //如果是選captain的話，文字為白色，否則為黑色
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                    ),
                  ),

                  // Crew 按鈕

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        selectedRole = 'Crew';
                      });
                    },
                    //onTap: () {
                      //setState(() {
                        //selectedRole = 'Crew';
                      //});
                    //},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 75,
                      ),
                      decoration: BoxDecoration(
                        color: selectedRole == 'Crew'
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.lightBackgroundGray,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Crew',
                        style: TextStyle(
                          fontSize: 50, // 增加字體大小
                          fontWeight: FontWeight.bold,
                          color: selectedRole == 'Crew'
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 50), //與上方元件的距離
              // 用戶名輸入框
              SizedBox(
                height: 100,
                width: 750,
                child:CupertinoTextField(
                  placeholder: 'Username',
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40), // 調整內邊距
                    decoration: BoxDecoration(
                      color: CupertinoColors.lightBackgroundGray,
                      borderRadius: BorderRadius.circular(80),
                    ),
                  style: const TextStyle(fontSize: 50), // 增加輸入框文字大小
                ),
              ),

              const SizedBox(height: 15), //與上方元件的距離
              // 密碼輸入框
              SizedBox(
                height: 100,
                width: 750,
                child:CupertinoTextField(
                  placeholder: 'Password',
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40), // 調整內邊距
                  obscureText: true, // 啟用密碼遮罩功能
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  style: const TextStyle(fontSize: 50), // 增加輸入框文字大小
                ),
              ),
              // 登錄按鈕
              const SizedBox(height: 37),
              SizedBox(
                width: 400,
                child: CupertinoButton(
                  onPressed: () {
                  // 按下按鈕的行為
                  //
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 50, // 修改點：增加字體大小
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // child: Container(
                //   decoration: BoxDecoration(
                //     color: CupertinoColors.activeBlue,
                //     borderRadius: BorderRadius.circular(100), // 圓角
                //   ),
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 20, // 控制按鈕的高度
                //     horizontal: 45, // 控制按鈕的寬度
                //   ),
                //   child: const Text(
                //     'LOGIN',
                //     style: TextStyle(
                //       fontSize: 40, // 合理的字體大小
                //       color: CupertinoColors.white,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // 用來跟蹤選擇的是 Captain 還是 Crew
//   String selectedRole = 'Captain'; // 預設選擇 Captain

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       backgroundColor: const Color(0xFFF5F5F5), // 背景顏色
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.all(40), // padding: 與邊邊留白的距離
//           width: 1000, // 邊框長度
//           height: 750,

//           decoration: BoxDecoration(
//             color: CupertinoColors.white,
//             borderRadius: BorderRadius.circular(40), // 圓角
//             boxShadow: [
//               BoxShadow(
//                 color: CupertinoColors.black.withOpacity(0.1), //陰影特效
//                 blurRadius: 15, //陰影模糊半徑
//                 spreadRadius: 8, //陰影擴散半徑
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text( // SIGN IN
//                 'SIGN IN',
//                 style: TextStyle(
//                   fontSize: 100,
//                   fontWeight: FontWeight.bold,
//                   color: CupertinoColors.black,
//                 ),
//               ),
//               const SizedBox(height: 45),
//               // Captain 和 Crew 選擇按鈕
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Captain 按鈕
//                   CupertinoButton(
//                     padding: EdgeInsets.zero, // 移除 CupertinoButton 的默認內邊距
//                     onPressed: () {
//                       setState(() {
//                         selectedRole = 'Captain';
//                       });
//                     },
//                     //onTap: () {
//                       //setState(() {
//                         //selectedRole = 'Captain';
//                       //});
//                     //},
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(// 按鈕內的邊距（上下 15 像素，左右 25 像素），使文字有足夠的空間
//                         vertical: 25,
//                         horizontal: 75,
//                       ),
//                       decoration: BoxDecoration(// 控制外觀
//                         color: selectedRole == 'Captain'
//                             ? CupertinoColors.activeBlue // 選中為blue
//                             : CupertinoColors.lightBackgroundGray, // 否則為灰色
//                         borderRadius: const BorderRadius.only( // 只圓角左上角跟左下角
//                           topLeft: Radius.circular(100),
//                           bottomLeft: Radius.circular(100),
//                         ),
//                       ),
//                       child: Text(
//                         'Captain',
//                         style: TextStyle(
//                           fontSize: 50, // 增加字體大小
//                           fontWeight: FontWeight.bold, //文字加粗
//                           color: selectedRole == 'Captain' //如果是選captain的話，文字為白色，否則為黑色
//                               ? CupertinoColors.white
//                               : CupertinoColors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Crew 按鈕
//                   CupertinoButton(
//                     padding: EdgeInsets.zero,
//                     onPressed: () {
//                       setState(() {
//                         selectedRole = 'Crew';
//                       });
//                     },
//                     //onTap: () {
//                       //setState(() {
//                         //selectedRole = 'Crew';
//                       //});
//                     //},
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 25,
//                         horizontal: 75,
//                       ),
//                       decoration: BoxDecoration(
//                         color: selectedRole == 'Crew'
//                             ? CupertinoColors.activeBlue
//                             : CupertinoColors.lightBackgroundGray,
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(100),
//                           bottomRight: Radius.circular(100),
//                         ),
//                       ),
//                       child: Text(
//                         'Crew',
//                         style: TextStyle(
//                           fontSize: 50, // 增加字體大小
//                           fontWeight: FontWeight.bold,
//                           color: selectedRole == 'Crew'
//                               ? CupertinoColors.white
//                               : CupertinoColors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50), //與上方元件的距離
//               // 用戶名輸入框
//               SizedBox(
//                 height: 100,
//                 width: 750,
//                 child:CupertinoTextField(
//                   placeholder: 'Username',
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // 調整內邊距
//                     decoration: BoxDecoration(
//                       color: CupertinoColors.lightBackgroundGray,
//                       borderRadius: BorderRadius.circular(80),
//                     ),
//                   style: const TextStyle(fontSize: 50), // 增加輸入框文字大小
//                 ),
//               ),

//               const SizedBox(height: 15), //與上方元件的距離
//               // 密碼輸入框
//               SizedBox(
//                 height: 100,
//                 width: 750,
//                 child:CupertinoTextField(
//                   placeholder: 'Password',
//                   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // 調整內邊距
//                   obscureText: true, // 啟用密碼遮罩功能
//                   decoration: BoxDecoration(
//                     color: CupertinoColors.lightBackgroundGray,
//                     borderRadius: BorderRadius.circular(80),
//                   ),
//                   style: const TextStyle(fontSize: 50), // 增加輸入框文字大小
//                 ),
//               ),
//               // 登錄按鈕
//               const SizedBox(height: 37),

//               CupertinoButton(
//                 padding: EdgeInsets.zero, // 避免 CupertinoButton 的內建 padding 干擾
//                 onPressed: () {
//                   // 按下按鈕的行為
//                   //
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: CupertinoColors.activeBlue,
//                     borderRadius: BorderRadius.circular(100), // 圓角
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 20, // 控制按鈕的高度
//                     horizontal: 45, // 控制按鈕的寬度
//                   ),
//                   child: const Text(
//                     'LOGIN',
//                     style: TextStyle(
//                       fontSize: 40, // 合理的字體大小
//                       color: CupertinoColors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               )

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
