import { NavigationListBean } from '../model/NavigationListBean';
import { Response } from '../model/Response';
import Api from '../viewmodel/Api'

@Entry
@Component
export
struct SystemPage {
  @State message: string = '我是导航页面'

  aboutToAppear(){
    this.loadData()
  }

  async loadData(){
   let data: Response<Array<NavigationListBean>> = await Api.get().getNavi();
    console.log('sszlog返回的数据：' + data.data[0].name)
  }


  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}