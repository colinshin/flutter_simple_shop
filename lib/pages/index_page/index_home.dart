import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:demo1/modals/dtkCategorys.dart';
import 'package:demo1/modals/goods_list_modal.dart';
import 'package:demo1/pages/index_page/store/component_index.dart';
import 'package:demo1/provider/category_provider.dart';
import 'package:demo1/provider/index_provider.dart';
import 'package:demo1/repository/IndexGoodsRepository.dart';
import 'package:demo1/widgets/component/custom_select_toolbar.dart';
import 'package:demo1/widgets/flexd/index_header_flexd_widget.dart';
import 'package:demo1/widgets/flexd/index_main_goods_mini_title_bar.dart';
import 'package:demo1/widgets/loading_more_list_indicator.dart';
import 'package:demo1/widgets/my_clipper.dart';
import 'package:demo1/widgets/pullto_refresh_header.dart';
import 'package:demo1/widgets/waterfall_goods_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:flutter/widgets.dart' hide NestedScrollView;
import '../../provider/dtk_index_goods_provider.dart';
import './ddq.dart';
import 'component/category_component.dart';
import 'component/category_item_layout.dart';
import 'component/topic_carousel.dart';
import 'grid_menu_list.dart';
import 'model/category_model.dart';

class IndexHome extends StatefulWidget {
  final ScrollController mController;

  IndexHome({Key key, this.mController}) : super(key: key);

  @override
  _IndexHomeState createState() => _IndexHomeState();
}

class _IndexHomeState extends State<IndexHome> with TickerProviderStateMixin, AfterLayoutMixin<IndexHome> {
//   状态管理
  DtkIndexGoodsModal _dtkIndexGoodsModal;
  CategoryProvider _categoryProvider;
  IndexProvider _indexProvider;
  List<CategoryItem> categorys = [];
  GlobalKey _titleKey = GlobalKey();

  bool _titleIsInTop = false;

  //dddd
  IndexGoodsRepository indexGoodsRepository = IndexGoodsRepository();
  ScrollController _mainScrollController = ScrollController();

  TabController tabController;

  bool carouselISLoaded = false; // 轮播图资源是否准备完毕
  bool categortListIsLoaded = false; // 分类数据是否准备好
  Color bgColor;
  int carouselHeight = 500; // 轮播图高度

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 1, vsync: this);
    this._initAliBC();
  }

  void _initAliBC() async {
    // var result =
    //     await FlutterAlibc.initAlibc(version: "1.0.0", appName: "典典的小卖部");
    // print("阿里百川初始化:${result.errorCode}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DtkIndexGoodsModal, CategoryProvider>(
      builder: (content, digm, categoryProvider, _) => PullToRefreshNotification(
          pullBackOnRefresh: false,
          maxDragOffset: 80.0,
          armedDragUpCancel: false,
          onRefresh: () async {
            await indexGoodsRepository.refresh(true);
            return true;
          },
          child: _buildIndexBody()),
      // child: IndexLoadingSkeletonPage(),)
    );
  }

  // 首页商品列表
  Widget _buildGoodsList() {
    return LoadingMoreSliverList(SliverListConfig<GoodsItem>(
      extendedListDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: ScreenUtil().setHeight(30), mainAxisSpacing: ScreenUtil().setWidth(30)),
      itemBuilder: (context, item, index) {
        return WaterfallGoodsCard(item);
      },
      sourceList: indexGoodsRepository,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
//      lastChildLayoutType: LastChildLayoutType.foot,
      indicatorBuilder: (context, state) {
        return LoadingMoreListCostumIndicator(state, isSliver: true);
      },
//      collectGarbage: (List<int> indexes) {
//        indexes.forEach((index) {
//          final item = indexGoodsRepository[index];
//          final provider = ExtendedNetworkImageProvider(
//            item.mainPic,
//          );
//          provider.evict();
//        });
//      },
    ));
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (this._dtkIndexGoodsModal == null) this._dtkIndexGoodsModal = Provider.of<DtkIndexGoodsModal>(context);
    if (this._categoryProvider == null) this._categoryProvider = Provider.of<CategoryProvider>(context);
    if (this._indexProvider == null) this._indexProvider = Provider.of<IndexProvider>(context);
  }

  /// 初始化数据
  /// 从上往下顺序加载
  Future<void> _initDatas() async {
    await _indexProvider.fetchCategorys(); // 超级菜单
    await _indexProvider.fetchTopics(); // 专辑列表
    await _indexProvider.fetchStores(); // 商店列表
    setState(() {
      carouselISLoaded = true;
    });
    await _dtkIndexGoodsModal.getGoodsList(1); // 首页商品列表
    await _categoryProvider.loadDtkCategoryDatas(context); // 分类数据
    setState(() {
      this.categorys = _categoryProvider.categorys;
      tabController = TabController(length: this.categorys.length + 1, vsync: this);
      setState(() {
        categortListIsLoaded = true;
      });
    });
  }

  // body
  Widget _buildIndexBody() {
    return LoadingMoreCustomScrollView(
      controller: _mainScrollController,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: IndexFlexdHeaderWidget(child: [
            _buildAppbar(),
            CategoryComponent(
              extendItems: [
                InsetCustomItem(
                    index: 0,
                    child: CategoryItemDefaultLayout(name: "首页", index: 0),
                    onTap: () {
                      print("我点击了首页");
                    }),
                InsetCustomItem(
                    index: 1,
                    child: Image.network(
                      "https://img.alicdn.com/imgextra/i3/2053469401/O1CN0155SHle2JJi3TPPkS3_!!2053469401.png",
                      fit: BoxFit.contain,
                      width: 250.w,
                    ),
                    onTap: () {
                      print("双十二预售");
                    })
              ],
              onSelect: (int index, MainCategory item) {
                print("选中了:${item.cname},index是:$index");
              },
            ),
          ], color: _indexProvider.topBackground),
          floating: true,
          pinned: true,
        ),

        // appbar和tab和轮播图
        SliverToBoxAdapter(
          child: _buildIndexTopWidgets(),
        ),

        // 下拉刷新指示头
        PullToRefreshContainer(buildPulltoRefreshHeader),

        // 网格菜单
        SliverToBoxAdapter(
          child: GridMenuList(),
        ),

        //钉钉抢
        SliverToBoxAdapter(
          child: DDQWidget(),
        ),
        SliverToBoxAdapter(
          child: StoreComponentIndex(),
        ),

        // SliverToBoxAdapter(
        //   child: HodgepodgeWidget(),
        // ),

        /// 商品列表标题
        SliverPersistentHeader(
          pinned: true,
          delegate: IndexMainGoodsMiniTitleBar(
              height: 220.h,
              child: AnimatedContainer(
                key: _titleKey,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: _titleIsInTop ? Colors.white : Color.fromRGBO(235, 235, 235, 1),
                    boxShadow: _titleIsInTop
                        ? [BoxShadow(color: Colors.grey[200], blurRadius: 1.0, spreadRadius: 1.0, offset: Offset(1, 1))]
                        : []),
                child: CustomSelectToolbar(items: [
                  SelectMenu(title: "佛系推荐", subTitle: '发现好物'),
                  SelectMenu(title: "精选", subTitle: '猜你喜欢'),
                ], select: 0, hideSubTitle: _titleIsInTop),
              )),
        ),

        //商品列表 (瀑布流)
        _buildGoodsList(),
      ],
    );
  }

  // 曲线
  Widget _buildIndexTopWidgets() {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: MyClipper(),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: ScreenUtil().setHeight(carouselHeight + 50),
              color: _indexProvider.topBackground,
            )),
        Column(
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            IndexTopicComponentCarousel()
            // carouselISLoaded && carouselProviderModal.carousels.isNotEmpty
            //     ? IndexTopSwiper(
            //         carouselProviderModal: this.carouselProviderModal,
            //         datum: cpm.carousels,
            //         height: carouselHeight,
            //       )
            //     : _buildGJP()
          ],
        ),
      ],
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        height: 140.h,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
              hintText: '输入商品名或者宝贝标题搜索',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: BorderSide.none),
              alignLabelWithHint: true,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintStyle: TextStyle(height: 1.5),
              contentPadding: EdgeInsets.only(top: 30.h, left: 40.w)),
          style: TextStyle(height: 1, color: Colors.black),
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 5.0, right: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //跳转到搜索页面
                  Navigator.pushNamed(context, 'search');
                },
                child: Icon(
                  Icons.message,
                  size: ScreenUtil().setSp(80),
                ),
              ),
              Text(
                "消息",
                style: TextStyle(fontSize: ScreenUtil().setSp(45)),
              )
            ],
          ),
        )
      ],
    );
  }

  //获取title的位置信息
  double _titleLocationHandler() {
    RenderBox renderBox = _titleKey.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset(0, 0));
    return offset.dy;
  }

  // 监听主滑动距离
  void _addMainScrollListening() {
    double topAppbarHei = 330.h + MediaQueryData.fromWindow(window).padding.top; // 顶部搜索框和选项卡高度
    _mainScrollController.addListener(() {
      double titleTopHei = _titleLocationHandler();
      if (titleTopHei <= topAppbarHei) {
        if (!_titleIsInTop) {
          setState(() {
            _titleIsInTop = true;
          });
        }
      } else {
        if (_titleIsInTop) {
          setState(() {
            _titleIsInTop = false;
          });
        }
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _titleLocationHandler();
    _addMainScrollListening();
    _initDatas();
  }
}
