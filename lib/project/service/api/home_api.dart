//置顶文章

import 'package:FlutterProject/project/models/banner.dart';
import 'package:FlutterProject/project/models/article.dart';
import 'package:FlutterProject/project/models/article_list.dart';
import 'package:FlutterProject/project/models/project_tree.dart';

import '../http_request.dart';

Future<List<Data>> getArticleTopData(int page) async {
  //HttpRequest.request("article/top/json");

  //var response = await Future.wait([HttpRequest.request("article/top/json"),HttpRequest.request("article/top/json")]);



  var response = await HttpRequest.request("article/top/json");

  var article_list = await getArticleListData(page);

  List<Data> articles = [];

  var article = Article.fromJson(response);

  articles.addAll(article.data);

  articles.addAll(article_list);

  return articles;
}

Future<List<Data>> getArticleListData(int page) async {
  List<Data> articles = [];

  var article_future = await HttpRequest.request("article/list/${page}/json");

  var article_list = ArticleList.fromJson(article_future);

  articles.addAll(article_list.data.datas);

  return articles;
}

Future<List<TreeData>> getProjectTree() async {
  List<TreeData> trees = [];

  var project_future = await HttpRequest.request("project/tree/json");

  var tree_list = ProjectTree.fromJson(project_future);

  trees.addAll(tree_list.data);

  return trees;
}

Future<List<BannerData>> getBanner() async {
  List<BannerData> banners = [];

  var banners_future = await HttpRequest.request("banner/json");

  var banner_list = Banners.fromJson(banners_future);

  banners.addAll(banner_list.data);

  return banners;
}
