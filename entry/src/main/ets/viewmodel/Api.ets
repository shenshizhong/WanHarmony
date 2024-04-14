import uri from '@ohos.uri';
import http from '@ohos.net.http';
import EntryContext from '../common/EntryContext';
import { Response } from '../model/Response';
import { ArticleList } from '../model/ArticleList';
import CookieJar from '../net/cookie/CookieJar';
import PersistentCookieJar from '../net/cookie/PersistentCookieJar';
import CookieUtils from '../net/cookie/CookieUtils';
import { User } from '../model/UserService';
import {NavigationListBean } from '../model/NavigationListBean';

let TAG = 'Api';
let BASE_URL: string = 'https://www.wanandroid.com';

// let cookieJar: CookieJar = new PersistentCookieJar(EntryContext.getContext() as Context);

function parseUri(url: string): uri.URI{
  return new uri.URI(url);
}

/**
 * 发起请求
 * */
async function request<T>(path: string, method: http.RequestMethod, extraData?: Object): Promise<Response<T>>{
  // await cookieJar.init();
  return new Promise<Response<T>>((resolve, reject) => {
    let url = BASE_URL + path;
    let uri = parseUri(url);
    let header = {};

    // let cookies = cookieJar.loadForRequest(uri);
    // if (cookies.length > 0){
    //   header["Cookie"] = CookieUtils.cookieHeader(cookies);
    // }
    //如果是post 请求
    if (method === http.RequestMethod.POST) {
      header["Content-Type"] = "application/x-www-form-urlencoded"
    }

    let httpRequest = http.createHttp();

    console.log('开始请求，' + ` path：${path} method:${method} extraData: ${JSON.stringify(extraData)}`)

    httpRequest.request(
      url,
      {
        method: method,
        expectDataType: http.HttpDataType.OBJECT,
        header: header,
        extraData: extraData
      },

      (err, data) =>{

        let res = new Response<T>()
        console.log('请求结果,'  + `data.responseCode:${data.responseCode}`)
        console.log('请求结果,'  + 'err：' + !err + ' code:' + data.responseCode)
        if (!err && data.responseCode === 200) {
          //待办去处理cookie
          // cookieJar.saveFromResponse(uri, CookieUtils.parseHttpRequestCookies(data.cookies))
          console.log('请求结果,'  + '进来了')

          if (typeof  data.result === 'string') {
            Object.assign(res, JSON.parse(data.result));
          }else{
            Object.assign(res, data.result);
          }
          console.log('请求成功,' + `path：${path} restult: ${data.result}`)

        }else{
          console.log('请求失败,'  + `path: ${path} error:${JSON.stringify(err)}`)
          res.code = data?.responseCode??-1
          res.msg == err?.message ?? ''
        }

        resolve(res);
        //当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy()
      }
    )

  })
}

export default class Api{
  private static  instance: Api;

  private constructor() {

  }

  static get(): Api{
    if (Api.instance === undefined) {
      Api.instance = new Api();
    }
    return Api.instance;
  }

  clearCookie() {
    // cookieJar.clear();
  }

  async getUserInfo(): Promise<Response<User>> {
    return request("/lg/coin/userinfo/json", http.RequestMethod.GET);
  }


  /**
   * 获取首页列表
   * */
  async getHomeArticleList(page: number): Promise<Response<ArticleList>>{
    return request(`/article/list/${page}/json`, http.RequestMethod.GET)
  }

  /**
   * 获取广场列表
   * */
  async getSquareArticleList(page: number, pageSize: number = 15): Promise<Response<ArticleList>>{
    return request(`/user_article/list/${page}/json?page_size=${pageSize}`, http.RequestMethod.GET)
  }

  /**
   * 注册
   * */
  async postRegister(userName: string, password: string): Promise<Response<Object>>{
    return request('/user/register', http.RequestMethod.POST, `username=${userName}&password=${password}&repassword=${password}`)
  }

  /**
   * 登录
   * */
  async postLogin(userName: string, password: string): Promise<Response<User>>{
    return request('/user/login', http.RequestMethod.POST, `username=${userName}&password=${password}`)
  }

  async getLogout(): Promise<Response<string>>{
    return request('/user/logout/json', http.RequestMethod.GET)
  }

  async getNavi(): Promise<Response<Array<NavigationListBean>>> {
    return request(`/navi/json`, http.RequestMethod.GET)
  }
}
