
export class ArticleList{
  curPage: number = 0
  datas: Array<Article> = []

}

export class Article{
  id: number = 0
  apkLink: string = ""
  audit: number = 0
  author: string = ""
  canEdit: boolean = false
  chapterId: number = 0
  chapterName: string = ""
  collect: boolean = false
  courseId: number = 0
  desc: string = ""
  descMd: string = ""
  envelopePic: string = ""
  fresh: boolean = false
  host: string = ""
  link: string = ""
  niceDate: string = ""
  niceShareDate: string = ""
  origin: string = ""
  prefix: string = ""
  projectLink: string = ""
  publishTime: number = 0
  realSuperChapterId: number = 0
  selfVisible: number = 0
  shareDate: number = 0
  shareUser: string = ""
  superChapterId: number = 0
  superChapterName: string = ""
  tags: Array<ArticleTag> = []
  title: string = ""
  type: number = 0
  userId: number = 0
  visible: number = 0
  zan: number = 0
  originId: number = 0

}

export function getArticleAuthor(article: Article):string{
  return article.author ?? article.shareUser  //不为空获取左边，为空获取右边。
}

export function getArticleChapter(article: Article): string{
  let chapter = article.superChapterName ?? '';
  if (chapter && article.chapterName) {
    chapter = chapter + ' / ';
  }
  chapter = chapter + article.chapterName ?? '';

  return chapter;
}

export class ArticleTag {
  name: string = ""
  url: string = ""
}

export class HomeBannerData {
  id: number = 0
  desc: string = ""
  imagePath: string = ""
  isVisible: number = 0
  order: number = 0
  title: string = ""
  type: number = 0
  url: string = ""
}