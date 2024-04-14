import MainViewModel from '../viewmodel/MainViewModel';
import { TabItemBean } from '../viewmodel/TabItemBean';
import { HomePage } from './home/HomePage';
import { MinePage } from './mine/MinePage';
import { NaviPage } from './navi/NaviPage';
import { SquarePage } from './square/SquarePage';
import { SystemPage } from './SystemPage';

@Entry
@Component
export
struct MainPage {

  @State selectIndex: number = 0;

  build() {
    Tabs({
      index: this.selectIndex,
      barPosition: BarPosition.End
    }){
      TabContent(){
        HomePage()
      }.tabBar(this.TabItem(MainViewModel.tabTitle[0], 0))

      TabContent(){
        SquarePage()
      }.tabBar(this.TabItem(MainViewModel.tabTitle[1], 1))

      TabContent(){
        NaviPage()
        // SystemPage()
      }.tabBar(this.TabItem(MainViewModel.tabTitle[2], 2))

      TabContent(){
        MinePage()
      }.tabBar(this.TabItem(MainViewModel.tabTitle[3],3))

    }.onChange((index)=>{
      this.selectIndex = index
    })
  }

  @Builder
  TabItem(item:TabItemBean,index:number){
    Column(){
      Image(this.selectIndex == index?item.imageActivated:item.imageOriginal).height(24)
        .width(24).margin({
        top: 5,
        bottom: 1
      })
      Text(item.title)
        .width('100%')
        .height(14)
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.selectIndex === index ? $r('app.color.co_1296DB') : Color.Gray)
        .textAlign(TextAlign.Center)
        .margin({
          top:3,
          bottom: 7
        })
    }.height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
  }
}