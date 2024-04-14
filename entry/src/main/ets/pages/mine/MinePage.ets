import router from '@ohos.router'
import emitter from '@ohos.events.emitter'
import { RouterPath } from '../../common/RouterPath'
import PreferenceUtil from '../../utils/PreferenceUtil'
import Api from '../../viewmodel/Api'
import { LoadingDialog } from '../../view/LoadingDialog'
import { ToastUtils } from '../../utils/ToastUtils'


@Entry
@Component
export
struct MinePage {
  @State message: string = 'Hello World'
  @State name: string = '未登录'
  @State isLogin: boolean = false
  commonLoading: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({loadingTips: '加载中'}),
    autoCancel: false,
    gridCount:2,

  })

  aboutToAppear(){

    PreferenceUtil.get(getContext()).getUserInfo().then((user)=>{
      if (user != null) {
        this.name = user.username
      }
    });

    let loginEvent = {
      eventId: 1
    }

    let loginCallBack = (eventData: emitter.EventData)=>{
      this.name = eventData.data.userName
      this.isLogin = true
      console.log('登录后回调用')
    }

    emitter.on(loginEvent, loginCallBack)

  }

  build() {
    Column(){
      Image($r("app.media.ic_hm"))
        .width(80)
        .height(80)
        .margin({
          top:15
        })


      Text(this.name)
        .fontColor(this.isLogin ? $r('app.color.co_212121') : $r('app.color.co_4CAF50'))
        .fontSize(15)
        .margin({top: 15})
        .onClick(()=>{
          console.log('点击去登录')
          if (true) {
            router.pushUrl(
              {
                url: RouterPath.RegisterPage
              }
            )
          }
        })

      Divider()
        .height(30)
        .color(Color.Transparent)

      Row(){
        Text('我的积分')
          .fontSize(13)
          .fontColor($r('app.color.co_212121'))
        Blank()
        Text('1200')
          .fontSize(13)
          .fontColor($r('app.color.co_212121'))
      }.width('90%')
      .padding(15)
      .borderRadius(5)
      .backgroundColor(Color.White)

      Divider()
        .height(15)
        .color(Color.Transparent)

      Row(){
        Text('我的收藏')
          .fontSize(13)
          .fontColor($r('app.color.co_212121'))

        Blank()

        Image($r('app.media.ic_arrow_right'))
          .width(20)
          .height(20)

      }.width('90%')
      .padding(15)
      .borderRadius(5)
      .backgroundColor(Color.White)

      Divider()
        .height(15)
        .color(Color.Transparent)

      Row() {
        Text('我的微信')
          .fontSize(13)
          .fontColor($r('app.color.co_212121'))

        Blank()

        Text('hmssz1')
          .fontColor($r('app.color.co_212121'))
          .fontSize(13)

      }.width('90%')
      .padding(15)
      .borderRadius(5)
      .backgroundColor(Color.White)

      Divider()
        .layoutWeight(1)
        .color(Color.Transparent)

      if (this.isLogin){
        Button('退出登录')
          .borderRadius(15)
          .backgroundColor(Color.Red)
          .margin({
            bottom:50
          })
          .width('90%')
          .onClick(async ()=>{
            this.commonLoading.open()
            //调用退出登录的接口
            let res =  await Api.get().getLogout()
            this.commonLoading.close()
            if (res.code ===0) {
              console.log('退出成功：' + res.msg)
              ToastUtils.show('退出成功')
              this.isLogin = false
              this.name = '未登录'
              PreferenceUtil.get(getContext()).clearUser()
              PreferenceUtil.get(getContext()).putLogin(false)
            }

          })

      }


    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.co_DCDCDC'))
  }
}