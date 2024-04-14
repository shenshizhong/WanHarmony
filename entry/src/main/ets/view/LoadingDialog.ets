
/**
 * 自定义加载dialog
 * */
@Preview
@CustomDialog
export struct LoadingDialog{
  @Prop loadingTips: string
  @State rotateAngle: number = 0
  //弹框控制器
  controller: CustomDialogController
  aboutToAppear(){
    setTimeout(()=>{
      this.rotateAngle = 360
    }, 500)

  }

  build(){

    Stack(){

      Column(){
        Image($r("app.media.ic_loading"))
          .height(50)
          .width(50)
          .rotate({angle: this.rotateAngle})
          .animation({
            duration: 500,
            iterations: -1,      //无限循环
            curve: Curve.Friction,  //摩擦力
            playMode: PlayMode.Normal
          })


        Text(this.loadingTips)
          .fontSize(15)
          .margin({top: 10})

      }
      .justifyContent(FlexAlign.Center)  //居中
      .height(150)
      .width(150)
      .backgroundColor(Color.White)
      .border({radius:5})

    }
  }
}