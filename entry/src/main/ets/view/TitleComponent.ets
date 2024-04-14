import router from '@ohos.router'
/**
 * 自定义标题的统一组件
 * */
@Entry
@Component
struct TitleComponent {
  title:string = '标题'
  isShowTitleBar: boolean = true;
  isShowBack: boolean = true;
  onBack: ()=> void = ()=>{
    router.back();
  }
  menuIcon?: Resource;
  onMenuClick?: () =>void;

  build() {
    Stack(){
      Row(){

        Image($r('app.media.ic_back'))
          .width(48)
          .height(48)
          .padding(15)
          .objectFit(ImageFit.Contain)
          .onClick(()=>{
            if (this.onBack !== undefined) {
              this.onBack();
            }
          })

        if (this.menuIcon !== undefined) {
          Image(this.menuIcon)
            .width(48)
            .height(48)
            .padding(15)
            .objectFit(ImageFit.Contain)
            .onClick(()=>{
              if (this.onMenuClick !== undefined) {
                this.onMenuClick();
              }
            })
        }

      }.width('100%')
      .height(48)
      .backgroundColor(Color.Red)


      Text(this.title)
        .fontSize(15)
        .fontColor($r('app.color.co_212121'))
        .maxLines(1)
        .textOverflow({overflow: TextOverflow.Ellipsis})

    }
    .alignContent(Alignment.Center)
    .width('100%')
    .height(48)
  }
}