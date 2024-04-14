import { MaterialProgressBar, MaterialProgressStyle } from '@ohos/materialprogressbar'

@Component
export struct LoadComponent {
  @Link loadState: LoadState;
  onReload?: ()=> void;
  @Link showLoading: boolean;
  @BuilderParam content: ()=> void;

  build() {
    Stack(){
      if (this.loadState === LoadState.LOADING){
        LoadingProgress()
          .color($r('app.color.co_4CAF50'))
          .width(100)
          .height(100)
      }else if (this.loadState === LoadState.SUCCESS){
        this.content();
        if (this.showLoading) {
          Stack(){
            Stack(){
              MaterialProgressBar({
                style: MaterialProgressStyle.MaterialCircular,
                modelBuild:{
                  color: $r('app.color.co_white'),
                  bgColor: Color.Transparent,
                  indeterminate: true,
                  strokeWidth: 3
                }
              })
                .margin({left:15, top:15})
                .align(Alignment.Center)
            }
            .width(80)
            .height(80)
            .align(Alignment.Center)
            .backgroundColor($r('app.color.co_80000000'))
            .borderRadius(8)
          }
          .width('100%')
          .height('100%')

        }

      }else if (this.loadState === LoadState.FAIL){
        Stack(){
          Text($r('app.string.load_retry'))
            .align(Alignment.Center)
        }
        .width('100%')
        .height('100%')
        .onClick(()=>{
          if (this.onReload !== undefined) {
            this.onReload();
          }
        })

      }else{
        Stack(){
          Text($r('app.string.load_nothing'))
            .align(Alignment.Center)
        }
        .width('100%')
        .height('100%')
        .onClick(()=>{
          if (this.onReload !== undefined) {
            this.onReload();
          }
        })
      }


    }
    .width('100%')
    .height('100%')

  }
}

export enum LoadState{
  LOADING,
  SUCCESS,
  FAIL,
  EMPTY
}