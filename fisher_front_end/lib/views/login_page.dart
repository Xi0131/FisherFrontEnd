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
          padding: const EdgeInsets.all(20), // padding: 與邊邊留白的距離
          width: 500, // 邊框長度
          height: 500,

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
              const Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.black,
                ),
              ),
              const SizedBox(height: 20),
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
                      padding: const EdgeInsets.symmetric(
                        // 按鈕內的邊距（上下 15 像素，左右 25 像素），使文字有足夠的空間
                        vertical: 15,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        // 控制外觀
                        color: selectedRole == 'Captain'
                            ? CupertinoColors.activeBlue // 選中為blue
                            : CupertinoColors.lightBackgroundGray, // 否則為灰色
                        borderRadius: const BorderRadius.only(
                          // 只圓角左上角跟左下角
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Captain',
                        style: TextStyle(
                          fontSize: 30, // 增加字體大小
                          fontWeight: FontWeight.bold, //文字加粗
                          color: selectedRole ==
                                  'Captain' //如果是選captain的話，文字為白色，否則為黑色
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
                        selectedRole = 'Worker';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: selectedRole == 'Worker'
                            ? CupertinoColors.activeBlue
                            : CupertinoColors.lightBackgroundGray,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      child: Text(
                        'Worker',
                        style: TextStyle(
                          fontSize: 30, // 增加字體大小
                          fontWeight: FontWeight.bold,
                          color: selectedRole == 'Worker'
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35), //與上方元件的距離
              // 用戶名輸入框
              SizedBox(
                height: 70,
                width: 500,
                child: CupertinoTextField(
                  placeholder: 'Username',
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // 調整內邊距
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  style: const TextStyle(fontSize: 30), // 增加輸入框文字大小
                ),
              ),

              const SizedBox(height: 15), //與上方元件的距離
              // 密碼輸入框
              SizedBox(
                height: 70,
                width: 500,
                child: CupertinoTextField(
                  placeholder: 'Password',
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 20), // 調整內邊距
                  obscureText: true, // 啟用密碼遮罩功能
                  decoration: BoxDecoration(
                    color: CupertinoColors.lightBackgroundGray,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  style: const TextStyle(fontSize: 30), // 增加輸入框文字大小
                ),
              ),
              // 登錄按鈕
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: CupertinoButton(
                  onPressed: () {
                    // 按下按鈕的行為
                    if (selectedRole == 'Captain') {
                      Navigator.pushNamed(context, 'captainPage');
                    } else {
                      Navigator.pushNamed(context, 'crewPage');
                    }
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 30, // 修改點：增加字體大小
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
