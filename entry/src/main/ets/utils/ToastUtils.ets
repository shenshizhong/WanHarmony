import promptAction from '@ohos.promptAction'

export class ToastUtils{
  static show(message: string){
    promptAction.showToast({
      message: message
    })
  }
}