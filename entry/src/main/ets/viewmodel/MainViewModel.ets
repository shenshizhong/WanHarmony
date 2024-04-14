
export class MainViewModel{

  tabTitle = [
    {
      index: 0,
      title: '首页',
      imageActivated: $r("app.media.ic_tab_home_selected"),
      imageOriginal: $r("app.media.ic_tab_home_default")
    },

    {
      index: 1,
      title: '广场',
      imageActivated: $r("app.media.ic_tab_square_selected"),
      imageOriginal: $r('app.media.ic_tab_square_default')
    },
    // {
    //   index: 2,
    //   title: "体系",
    //   imageActivated: $r('app.media.ic_tab_system_selected'),
    //   imageOriginal: $r('app.media.ic_tab_system_default')
    // },
    {
      index: 2,
      title: "导航",
      imageActivated: $r('app.media.ic_tab_navi_selected'),
      imageOriginal: $r('app.media.ic_tab_navi_default')
    },
    {
      index: 3,
      title: "我的",
      imageActivated: $r('app.media.ic_tab_mine_selected'),
      imageOriginal: $r('app.media.ic_tab_mine_default')
    },

  ]

}

let mainViewModel = new MainViewModel()
export default mainViewModel as MainViewModel