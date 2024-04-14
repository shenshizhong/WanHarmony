import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { RouterPath } from '../common/RouterPath';
import { Article, getArticleAuthor } from '../model/ArticleList';

/**
 * 自定义首页ArticleItem
 * */
@Component
export struct ArticleItemComponent {
  article: Article;
  onCollectClick:(article) => void;
  build() {
    Column(){

      Text(this.article.title)
        .width('100%')
        .fontColor($r('app.color.co_212121'))
        .fontSize(15)
        .maxLines(2)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        }) //超过最大行数，后面用省略号

      Divider()
        .width('100%')
        .height(15)
        .color(Color.Transparent) //占位符

      Row(){

        Text(getArticleAuthor(this.article))
          .layoutWeight(1)
          .fontColor($r('app.color.co_212121'))
          .fontSize(12)

        Blank()

        Text(this.article.niceDate)
          .fontColor($r('app.color.co_212121'))
          .fontSize(12)

      }

      Divider()
        .width('100%')
        .height(4)
        .color(Color.Transparent)



    }
    .width('100%')
    .padding({
      left: 15,
      top: 10,
      right: 15,
      bottom: 10
    })
    .borderRadius(5)
    .backgroundColor(Color.White)
    .onClick(()=>{
      router.pushUrl({
        url: RouterPath.WebPage,
        params:{
          url: this.article.link
        }
      })
      // promptAction.showToast({
      //   message: this.article.title,
      //   duration: 2000
      // })

    })


  }
}