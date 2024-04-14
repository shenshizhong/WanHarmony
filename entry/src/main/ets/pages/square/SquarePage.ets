
import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh';
import { Article } from '../../model/ArticleList';
import { Response } from '../../model/Response';
import { ArticleItemComponent } from '../../view/ArticleItemComponent';
import { LoadState } from '../../view/LoadComponent';
import Api from '../../viewmodel/Api';

@Entry
@Component
export
struct SquarePage {
  @State loadState: LoadState = LoadState.LOADING
  @State showLoading: boolean = false;
  @State title: string = '广场';
  @State data: Array<Article> = [];
  private scroller: Scroller = new Scroller();
  private refreshConfig = new PullToRefreshConfigurator();
  private nextPage: number = 1;
  private hasMore: boolean = true;

  aboutToAppear(){
    this.requestData()
  }

  build() {
    Column(){
      PullToRefresh({
        data: $data,
        scroller: this.scroller,
        refreshConfigurator: this.refreshConfig,
        customList: this.ListViewComponent,
        onRefresh: ()=>{
          return new Promise<string>(async (resolve, reject)=>{
            //获取接口返回的值
            let res = await Api.get().getSquareArticleList(0)
            if (res.isSuccessWithData()) {
              let list = res.data.datas;
              this.data = list
              this.nextPage = 1;
              resolve('刷新成功');
            }else{
              reject('刷新失败');
            }

          })
        },
        onLoadMore:()=>{
          return new Promise<string>( async(resolve, reject)=>{
            if (this.hasMore) {
              let res = await Api.get().getSquareArticleList(this.nextPage)
              if (res.isSuccessWithData()) {
                let list = res.data.datas;
                console.log('获取的大小：' + list.length)
                if (list.length > 0) {
                  this.data = this.data.concat(list)
                  resolve('加载成功');
                }else{
                  this.hasMore = false;
                  resolve('没有更多了');
                }

              }else{
                reject('加载失败')
              }

            }
            else{
              resolve('没有更多了')
            }
          })
        },
        customLoad: null,
        customRefresh: null,

      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.co_DCDCDC'))

  }

  async requestData(){
    let res = await Api.get().getSquareArticleList(0)
    if (res.isSuccessWithData()) {
      let list = res.data.datas;
      this.data = list
      this.nextPage = 1;
    }
  }

  @Builder
  ListViewComponent(){
    Column(){
      List({space: 15, scroller :this.scroller}){
        ForEach(this.data, (item: Article)=>{
          ListItem(){
            ArticleItemComponent({
              article: item,
              onCollectClick: (article: Article)=>{
                //todo收藏

              }
            })
          }
        })
      }.width('90%')
      .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
    }
    .margin({top: 15})
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)


  }


}
