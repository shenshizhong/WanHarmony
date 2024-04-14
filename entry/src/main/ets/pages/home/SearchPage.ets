import { SearchComponent } from '../../view/SearchTitleComponent'

@Entry
@Component
struct SearchPage {


  build() {
    Column(){
      SearchComponent({
      })
        .margin({bottom:10})

      Text($r('app.string.str_hot_search'))
        .alignSelf(ItemAlign.Start)
        .padding({left: 20})
        .margin({
          bottom:15
        })


      List()
        .margin({bottom:15})

      Text($r('app.string.str_search_history'))
        .alignSelf(ItemAlign.Start)
        .padding({left: 20})
    }

  }
}