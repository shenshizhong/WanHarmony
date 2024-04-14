import webView from '@ohos.web.webview'
import router from '@ohos.router'


/**
 * 如果模拟器不能滑动，可以使用键盘的上下键，进行滚动。
 * 滚动这是模拟器的bug。
 */
@Entry
@Component
struct WebPage {

  private webController: webView.WebviewController = new webView.WebviewController()
  private url: string = router.getParams()['url']
  @State title: string = '加载中...'
  @State progress: number = 0

  // onBackPress(){
    // if (this.webController.accessForward()) { //当前页面是否有前进历史
    //   this.webController.backward() //后退一个页面
    // }else{
    //   router.back()
    // }
  // }
  build() {
    Row() {
      Column() {

        Row(){
          Image($r('app.media.ic_back'))
            .width(48)
            .height(48)
            .padding(15)
            .objectFit(ImageFit.Contain)
            .onClick(()=>{
              if (this.webController.accessForward()) { //当前页面是否有前进历史
                this.webController.backward() //后退一个页面
              }else{
                router.back()
              }
            })

          Text(this.title)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis})
            .height(48)
            .margin({
              left: 8
            })
            .layoutWeight(1)

          Divider()
            .width(48)
            .color(Color.Transparent)

        }
        .width('100%')


        Column(){

          if (this.progress != 100){
            Progress({
              value: this.progress,
              total: 100,
              type: ProgressType.Linear
            })
              .width('100%')
          }

          Web({
            src: this.url,
            controller: this.webController
          })
            .javaScriptAccess(true)//是否允许执行js脚本
            .domStorageAccess(true)//是否开启文档对象模型存储接口
            .databaseAccess(true)//是否开启数据库
            .mixedMode(MixedMode.All)//是否允许加载http和https混合内容
            .onTitleReceive(({title})=>{//标题接收
              this.title = title
            })
            .onProgressChange(({newProgress})=>{
              this.progress = newProgress
            })
            .width('100%')
            .layoutWeight(1)
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .height('100%')
  }
}