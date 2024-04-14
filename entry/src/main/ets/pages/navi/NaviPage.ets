import { FeedArticleBean } from '../../model/FeedArticleBean'
import { NavigationListBean } from '../../model/NavigationListBean'
import Api from '../../viewmodel/Api'

/**
 * 这是导航页面
 * */
@Entry
@Component
export
struct NaviPage {
  normalIcon: Resource = $r('app.media.startIcon') //侧边栏中的item 的默认icon
  selectedIcon: Resource = $r('app.media.phone') //选中时，侧边栏item中的icon

  @State arr: number[] = [1,2,3]  //侧边栏，左侧想要滚动，用List替代即可
  @State current: number = 0
  @State isShowSlideBar: boolean = true
  @State oneListData: Array<NavigationListBean> = null
  @State list: Array<number> = [1011, 202, 30, 40, 50, 602, 70,10, 20, 302, 40, 50, 602, 70, 89, 111, 2454, 542542, 54235425, 54254254, 5, 52, 542]
  @State colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]

  aboutToAppear(){
    this.getNaviData();
  }

  async getNaviData(){
    let res = await Api.get().getNavi()
    if (res != null) {
      this.oneListData = res.data
    }
  }

  build() {
    Column(){
      SideBarContainer(SideBarContainerType.Embed) { //侧边栏和内容并列显示，Overlay是侧边栏浮在内容上面
        //侧边栏的布局
        List(){
          ForEach(this.oneListData, (item, index)=>{
            ListItem(){
              Text(this.oneListData[index].name)
                .fontSize(15)
                .fontColor(this.current === index ?  Color.White : $r('app.color.co_80000000'))
                .maxLines(1)
                .backgroundColor(this.current === index ? $r('app.color.co_3080ff') : Color.White )
                .textOverflow({overflow: TextOverflow.Ellipsis})
                .padding(5)
                .width('90%')
                .textAlign(TextAlign.Center)

            }
            .onClick(()=>{
              this.current = index
            })
          }, item => item)
        }.width('100%')
        .margin({
          top: 90
        })
        // .backgroundColor(Color.Red)
        // .justifyContent(FlexAlign.SpaceEvenly)

        //右边 内容的布局
        Row(){
            if (this.oneListData != null && this.oneListData.length > 0){
                Flex({wrap: FlexWrap.Wrap}){
                  ForEach(this.oneListData[this.current].articles, (item: FeedArticleBean, index: number) =>{
                    Button(item.title)
                      .borderWidth(2)
                      .borderColor(this.colors[index % 5])
                      .fontColor(Color.Black)
                      .backgroundColor(Color.White)
                      .fontSize(20)
                      .height(40)
                      .margin({
                        top: 10,
                        right: 10
                      })


                    }, (item) =>JSON.stringify(item))

                  // ForEach(this.list, (item: number)=>{
                  //   Button('' + item)
                  //     .fontColor(Color.White)
                  //     .fontSize(20)
                  //     .height(40)
                  //     .margin({
                  //       top: 10,
                  //       right: 10
                  //     })
                  //
                  // }, (item) =>JSON.stringify(item))

                }.onAreaChange((_oldValue: Area, newValue: Area)=>{ //组件尺寸发生变化，或者位置发生变化触发

              })
              .margin({
                left: 10,
                right: 10
              })
              .width('100%')
              .height('100%')
            }

        }
        .margin({
          top: 90
        })
        .layoutWeight(1)
        .height('100%')
        .backgroundColor($r('app.color.co_DCDCDC'))

      }.controlButton({//控制侧边栏显示隐藏的按钮
        icons:{
          hidden: $r('app.media.ic_broadside_default'),
          shown:$r('app.media.ic_broadside_close'),
          switching: $r('app.media.ic_broadside_default')
        },
        width: 24,
        height:24
      })
      .sideBarWidth(120)
      .minSideBarWidth(50)
      .maxSideBarWidth('100%')
      .onChange((value)=>{ //侧边栏是否显示的值
        console.log('当前的值：' + value)
      })

    }
    .margin({
      top: -40
    })
  }
}