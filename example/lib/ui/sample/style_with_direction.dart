/*
 * Author: Jpeng
 * Email: peng8350@gmail.com
 * Time:  2019-07-11 21:52
 */

/*
   sample to test different RefreshStyle and LoadStyle,four direction,
   this may contain bug
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Item.dart';

class StyleWithDirection extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StyleWithDirectionState();
  }

}
class StyleWithDirectionState extends State<StyleWithDirection>{
  List<Widget> items = [];
  bool _enablePullDown = true;
  bool _enablePullUp = true;
  RefreshController _refreshController;
  ScrollPhysics _physics = BouncingScrollPhysics();
  RefreshStyle _refreshStyle = RefreshStyle.Front;
  LoadStyle _loadStyle = LoadStyle.ShowAlways;
  Axis _direction = Axis.vertical;
  bool _reverse = true;

  void _init() {
    items = [];
    items.add(Row(
      children: <Widget>[
        Text("加载风格"),
        Radio(
          value: true,
          groupValue: _loadStyle ==LoadStyle.ShowAlways,
          onChanged: (i) {
            _loadStyle =LoadStyle.ShowAlways;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: _loadStyle ==LoadStyle.HideAlways,
          onChanged: (i) {
            _loadStyle =LoadStyle.HideAlways;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: _loadStyle ==LoadStyle.ShowWhenLoading,
          onChanged: (i) {
            _loadStyle =LoadStyle.ShowWhenLoading;
            setState(() {});
          },
        )
      ],
    ));
    items.add(Row(
      children: <Widget>[
        Text("刷新风格"),
        Radio(
          value: true,
          groupValue: _refreshStyle ==RefreshStyle.Follow,
          onChanged: (i) {
            _refreshStyle = RefreshStyle.Follow;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: _refreshStyle ==RefreshStyle.UnFollow,
          onChanged: (i) {
            _refreshStyle = RefreshStyle.UnFollow;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: _refreshStyle ==RefreshStyle.Behind,
          onChanged: (i) {
            _refreshStyle = RefreshStyle.Behind;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: _refreshStyle ==RefreshStyle.Front,
          onChanged: (i) {
            _refreshStyle = RefreshStyle.Front;
            setState(() {});
          },
        )
      ],
    ));
    items.add(Row(
      children: <Widget>[
        Text("滚动方向"),
        Radio(
          value: true,
          groupValue: _direction ==Axis.vertical,
          onChanged: (i) {
            _direction =Axis.vertical;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: _direction ==Axis.horizontal,
          onChanged: (i) {
            _direction =Axis.horizontal;
            setState(() {});
          },
        ),
      ],
    ));
    items.add(Row(
      children: <Widget>[
        Text("翻转列表"),
        Radio(
          value: true,
          groupValue: _reverse,
          onChanged: (i) {
            _reverse = true;
            setState(() {});
          },
        ),
        Radio(
          value: true,
          groupValue: !_reverse,
          onChanged: (i) {
            _reverse = false;
            setState(() {});
          },
        ),
      ],
    ));
    for (int i = 0; i < 7; i++) {
      items.add(Item(
        title: "Data$i",
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    _refreshController = RefreshController();
    super.initState();
  }

  _onLoading() {

    Future.delayed(Duration(milliseconds: 1000)).whenComplete((){
      _refreshController.loadComplete();
    });
  }

  _onRefresh() {
    items.add(Item(
      title: "Data",
    ));
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return RefreshConfiguration(
      child: SmartRefresher(
          child: ListView.builder(
            itemBuilder: (c, i) => items[i],
            itemExtent: 100.0,
            itemCount: items.length,
            physics: _physics,
            reverse: _reverse,
            scrollDirection: _direction,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          header: ClassicHeader(
            refreshStyle: _refreshStyle,
          ),
          footer: ClassicFooter(
            loadStyle: _loadStyle,
          ),
          enablePullDown: _enablePullDown,
          enablePullUp: _enablePullUp,
          controller: _refreshController),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }
}