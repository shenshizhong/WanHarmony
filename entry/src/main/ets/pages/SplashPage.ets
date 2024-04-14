import router from '@ohos.router'
import { RouterPath } from '../common/RouterPath'

@Entry
@Component
struct SplashPage {

  aboutToAppear(){
    setTimeout(()=>{ //2秒后自动跳到主页
      router.replaceUrl({
        url:"pages/MainPage"
      })
    }, 2000)

  }

  build() {
    Row() {
      Column() {
        Image($r('app.media.app_icon'))
          .interpolation(ImageInterpolation.High) //提高清晰度
          .objectFit(ImageFit.Fill)
          .width(50)
          .height(50)

      }
      .width('100%')
    }
    .height('100%')
  }
}