import { LoadingDialog } from '../view/LoadingDialog'

@Entry
@Component
struct TestPage {

  // onBackPress(){
  //   console.log('按下返回键')
  // }

  build() {
    Column(){
      Button('这是文本按钮')
        .borderWidth(2)
        .borderColor(Color.Red)
        .backgroundColor(Color.Green)
        .fontColor(Color.Black)
    }

  }
}