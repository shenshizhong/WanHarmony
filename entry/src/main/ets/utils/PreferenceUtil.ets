import dataPreferences from '@ohos.data.preferences';
import { User } from '../model/UserService';

const  PREFERENCES_NAME = 'com.ssz.wanharmony'
const  KEY_SEARCH_HISTORY = 'search_history'
const  KEY_USER = 'user'
const  KEY_IS_LOGIN = 'isLogin'

export default class PreferenceUtil{
  private static instance: PreferenceUtil;
  private context: Context
  private preference: dataPreferences.Preferences;

  private constructor(context: Context) {
    this.context = context;
  }

  /**
   * 获的查询历史
   * */
  async getSearchHistory(): Promise<Array<string>>{
    await this.checkInit();
    let json = await this.preference.get(KEY_SEARCH_HISTORY, PREFERENCES_NAME)
    return new Promise<Array<string>>((resolve, reject) =>{
      if (json) {//如果有值转化成数组
        resolve(JSON.parse(json.toString()))
      }else{
       resolve([])
      }
    })
  }

  /**
   * 判断是否初始化, 这里是获取preference
   * */
  private async checkInit(): Promise<void>{
    if (!this.preference) {
      this.preference = await dataPreferences.getPreferences(this.context, PREFERENCES_NAME)
    }
    return new Promise<void>((resole, reject) =>{
      resole()
    })
  }

  static get(context: Context): PreferenceUtil{
    if (PreferenceUtil.instance === undefined) {
      PreferenceUtil.instance = new PreferenceUtil(context)
    }
    return PreferenceUtil.instance
  }

  putSearchHistory(historyKeys: Array<string>){
    this.checkInit().then(()=>{
      this.preference.put(KEY_SEARCH_HISTORY, JSON.stringify(historyKeys))
      this.preference.flush()
    })
  }


  putUserInfo(user: User){
    this.checkInit().then(()=>{
      this.preference.put(KEY_USER, JSON.stringify(user))
      this.preference.flush()
    })
  }

  async getUserInfo(): Promise<User>{
    await this.checkInit();
    let json = await this.preference.get(KEY_USER, PREFERENCES_NAME)
    return new Promise<User>((resolve, reject)=>{
      if (json) {
        resolve(JSON.parse(json.toString()))
      }else{
        resolve(null)
      }
    })

  }

  putLogin(isLogin: boolean){
    this.checkInit().then(()=>{
      this.preference.put(KEY_IS_LOGIN, isLogin)
      this.preference.flush()
    })
  }

  async isLogin(){
    await this.checkInit();
    let isLogin = await this.preference.get(KEY_IS_LOGIN, PREFERENCES_NAME)
    return isLogin
  }

  clearUser(){
    //清空cookie
    this.preference.delete(KEY_USER);
    this.preference.flush()
  }

}