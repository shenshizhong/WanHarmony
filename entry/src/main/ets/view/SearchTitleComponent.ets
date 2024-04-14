import router from '@ohos.router';

@Component
export
struct SearchComponent{
  isShowBack: boolean = true;
  onBack: ()=> void = ()=>{
    router.back();
  }
  changeValue:string
  submitValue:string
  controller: SearchController = new SearchController()

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


      }.width('100%')
      .height(64)

      Search({
        value: this.changeValue,
        placeholder: '输入搜索词',
        controller: this.controller
      })
        .searchButton('搜索')  //最右边的提示文本
        .width('90%')
        .backgroundColor('#f5f5f5') //整个搜索条的背景颜色。
        .placeholderColor(Color.Grey)  //搜索框内的文本背景
        .placeholderFont({size: 14, weight: 400})
        .textFont({size: 14, weight:400})
        .onSubmit((value: string)=>{ //搜索按钮的监听
          this.submitValue = value
          this.search()
        })
        .onChange((value: string) =>{
          // this.changeValue = value
          console.log('输入的搜索词：' + value)
        })

    }
    .alignContent(Alignment.Center)
    .width('100%')
  }

  /**
   * 查询
   * */
  search(){

  }
}