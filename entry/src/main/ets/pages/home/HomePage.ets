import { Article, ArticleList } from '../../model/ArticleList';
import { ArticleItemComponent } from '../../view/ArticleItemComponent';
import { LoadComponent, LoadState } from '../../view/LoadComponent';
import Api from '../../viewmodel/Api';

@Entry
@Component
export struct HomePage {
  @State data: Array<Object> = [];
  @State loadState: LoadState = LoadState.LOADING;
  @State showLoading: boolean = false;
  @State bannerPosition: number = 0;
  @State title: string = "首页";

 aboutToAppear(){
   this.loadData()
 }
  build() {
    Column(){
      LoadComponent(
        {
          loadState: this.loadState,
          showLoading: this.showLoading,
          onReload:()=>{
            this.loadData();
          }
        }
      ){
        Column(){

          this.ListViewBuilder()

        }.width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Center)
        .backgroundColor($r('app.color.co_DCDCDC'))

      }

      Text('首页')
    }

  }

  loadData(){
    this.loadState = LoadState.LOADING
    this.loadDataByPage(0).then(
      (data) => {
        this.data = data;
        if (this.data.length === 0) {
          this.loadState = LoadState.EMPTY
        }else{
          this.loadState = LoadState.SUCCESS
        }
      },
      (error)=>{
        this.loadState = LoadState.FAIL
      }
    )

  }

  async loadDataByPage(page: number): Promise<Array<Object>>{
    return new Promise<Array<Object>>(async (resolve, reject) =>{
      if (page === 0) {
        let articleRes  = await Api.get().getHomeArticleList(page);
        let articleLest = [];
        articleLest =  articleLest.concat(articleRes.data.datas);
        resolve(articleLest);
      }

    })

  }


  @Builder
  ListViewBuilder(){
    List({space: 15}){
      ForEach(this.data, (item: object)=>{
        ListItem(){
          ArticleItemComponent({
            article: item as Article,
            onCollectClick: (article: Article) =>{

            }
          })
        }
      })
    }
    .width('90%')
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }

}