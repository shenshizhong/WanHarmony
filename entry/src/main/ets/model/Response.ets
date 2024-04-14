
/**
 *
 * 服务器返回统一处理
 *
 * */
export class Response<T>{
  code: number = 0;
  msg: string = '';
  data: T = null;
  errorMsg: string = '';

  isSuccess(): boolean{
    return this.code === 0;
  }

  isSuccessWithData(): boolean{
    return this.code === 0 && !!this.data
  }

}