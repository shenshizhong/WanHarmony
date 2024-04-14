import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import emitter from '@ohos.events.emitter'
import EntryContext from '../../common/EntryContext'
import PersistentCookieJar from '../../net/cookie/PersistentCookieJar'
import PreferenceUtil from '../../utils/PreferenceUtil'
import { ToastUtils } from '../../utils/ToastUtils'
import Api from '../../viewmodel/Api'
import { LoadingDialog } from '../../view/LoadingDialog'

@Entry
@Component
struct RegisterPage {
  @State enableClick: boolean = false
  private account: string
  private pwd: string
  commonLoading: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({loadingTips: '加载中'}),
    autoCancel: false,
    gridCount:2,

  })

  build() {
    Column(){
      Column(){
        //图片组件
        Image($r("app.media.ic_hm"))
          .width(50)
          .height(50)
          .borderRadius(10)
          .interpolation(ImageInterpolation.High) //图片的插值效果（去掉锯齿是图片清晰）
          .margin({bottom: 10})
          .onComplete(img =>{

          })
          .onError(()=>{
            //图片加载报错，走这里
          })

        //文本组件
        Text($r('app.string.str_welcome'))
          .fontSize(20)  //字体大小
          .lineHeight(30) //行高
          .fontColor($r('app.color.co_1296DB')) //字体颜色
          .fontWeight(FontWeight.Medium)//字体粗细
          .margin({bottom: 10})
          .onClick(()=>{
            console.log('点击事件')
          })
      }
      .margin({top: 25, bottom: 25})


      Row(){
        Image($r('app.media.phone'))
          .width(40)
          .height(40)
        //文本输入框
        TextInput({placeholder:'请输入用户名'}) //这里头是提示文本
          .width('80%')
          .height(40)
          .backgroundColor('#cdcdcd')
          .margin({left: 10})
          .onChange((value)=>{
            this.account = value;
            this.check()
          })

      }.width('100%')
      .margin({bottom:10})


      Row(){
        Image($r('app.media.pwd'))
          .width(40)
          .height(40)
        TextInput({placeholder: '请输入密码'})
          .width('80%')
          .height(40)
          .backgroundColor('#cdcdcd')
          .type(InputType.Password) //输入文本类型
          .showPasswordIcon(true) //是否显示密码icon
          .margin({bottom: 10})
          .onChange(val=>{
            this.pwd = val
            this.check()
            console.log('输入的值为：' + val)
          })
          .margin({left: 10})
      }.width('100%')
      .margin({bottom:10})
      .margin({bottom: 100})



      Button($r('app.string.str_register'))
        .key('button')
        .onClick(()=>{
          if (this.enableClick) {
            focusControl.requestFocus('button')
            this.register()
          }
        })
        .width('90%')
        .backgroundColor(this.enableClick ?  $r('app.color.co_3080ff') : $r('app.color.co_DCDCDC'))
        .margin({bottom: 15})

      Button($r('app.string.str_login'))
        .key('button')
        .onClick(()=>{
          if (this.enableClick) {
            focusControl.requestFocus('button')//关闭软键盘
            this.login()
          }
        })
        .width('90%')
        .backgroundColor(this.enableClick ?  $r('app.color.co_3080ff') : $r('app.color.co_DCDCDC'))


    }.width('100%')
    .padding({left: 10, top: 10, right: 10})



  }
  /**
   * 验证是否可以注册或登录
   * */
  check() {
    if (this.account != undefined && this.account != ''
    && this.pwd != undefined && this.pwd != ''
    ) {
      console.log('enableClick:true')
      this.enableClick = true
    }else{
      console.log('enableClick:false')
      this.enableClick = false
    }
  }

  async register(){

    let res = await Api.get().postRegister(this.account, this.pwd)
    if (res.isSuccessWithData()) {
      console.log('注册成功' + res.data)
      ToastUtils.show('注册成功，点击登录，进行体验')
    }else{
      console.log('注册失败：' + res.errorMsg)
      ToastUtils.show('注册失败,' + res.errorMsg)
    }
  }

  async login(){
    //加个loading
    this.commonLoading.open()
    let res = await Api.get().postLogin(this.account, this.pwd);
    this.commonLoading.close()
    if (res.isSuccessWithData()) {
      ToastUtils.show('登录成功')
      emitter.emit(
        {eventId: 1, priority: emitter.EventPriority.LOW},
        { data: { "userName": res.data.username } }
      )

      PreferenceUtil.get(getContext()).putUserInfo(res.data)
      PreferenceUtil.get(getContext()).putLogin(true)

      router.back()
    } else {
      ToastUtils.show('登录失败')
    }

  }

}

