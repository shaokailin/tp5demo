import React, {Component} from 'react';
import {
    ScrollView,
    Image,
    View,
    StyleSheet,
    Dimensions,
    TouchableOpacity
} from 'react-native';
import BannerDot from './BannerDotView';
var windowWidth = Dimensions.get('window').width;
export default class BannerView extends Component {
    constructor(props){
        super(props);
        this.state = ({
            var:currentCount=0,
            var:isDrag = false,
            var:isLastOfFirst = false,
            var:isMove = false,
        });
    };

    render(){
        return (
            <View  style={[this.props.style,styles.container]}>
                <ScrollView ref='scrollView'
                            bounces={false}
                            horizontal={true}
                            showsHorizontalScrollIndicator={false}
                            pagingEnabled={true}
                            onScroll={(event)=>this.onScrollViewScroll(event)}
                            onMomentumScrollEnd={(e)=>this.onScrollEndAnimated(e)}
                            onScrollBeginDrag={(e)=>this.dragView(e)}
                            scrollEnabled={this.props.data.length > 1?true:false}
                            contentOffset={{x:windowWidth,y:0}}
                            scrollEventThrottle={0}
                            onTouchEnd={this.onTouchEnd.bind(this)}


                >
                    {this.createItems()}
                </ScrollView>
                {this.props.data.length > 1? <BannerDot style={styles.dotsView} index={currentCount} count={this.props.data.length}/>:null}
            </View>
        );
    };
    onTouchEnd(){
        if(!isDrag){
            this.onPressJumpView();
        }
    }
    componentDidMount() {
        this.startTimerToScroll();
    }


    componentWillUnmount() {
        this.stopTimerToScroll();
    }
    shouldComponentUpdate(nextProps, nextState) {
        if (this.props.data !== nextProps.data){
            this.stopTimerToScroll();
            this.startTimerToScroll();
            return true;
        }
        if(this.state.currentCount !== nextState.currentCount) {
            return true;
        }
        return false;
    }
    //创造视图
    createItems(){
        var items = [];
        var count = this.props.data.length;
        if(count > 1) {
            count += 2;
        }
        for (var i = 0; i < count;i++) {
            var index = i;
            if(count > 1) {
                if(index == 0) {
                    index = count - 3;
                }else if(index == count - 1) {
                    index = 0;
                }else {
                    index = i - 1;
                }
            }
            items.push(<View key={i} style={[styles.itemView,{backgroundColor:'rgb('+ index * 65 + ','+index * 55 + ','+index * 55+')'}]}> </View>);
        }
        return items;
    }
    //滚动的事件
    onScrollViewScroll(event){
        if(!isLastOfFirst) {
            this.stopTimerToScroll();
        }else {
            isLastOfFirst = false;
        }

    }
    onScrollEndAnimated(e) {
        var contentOffSet = e.nativeEvent.contentOffset.x;
        var page = contentOffSet / windowWidth;
        var count =  this.props.data.length;
        var index = -1;
        if(page == count + 1) {
            page = 0;
            index = 1;
        }else if (page == 0) {
            index = count;
            page = count - 1;
        }else {
            page -= 1;
        }
        if(index > 0) {
            var scroller = this.refs.scrollView;
            var l = index * windowWidth;
            isLastOfFirst = true;
            scroller.scrollResponderScrollTo({x:l ,y:0, animated:false});
        }
        if(isDrag) {
            isDrag = false;
            currentCount = page;
        }
        this.setState({
            currentCount:page
        });
        this.startTimerToScroll();
    }
    dragView(e){
        this.stopTimerToScroll();
        isDrag = true;
    }
    startTimerToScroll() {
        if (this.timer == null && this.props.data.length > 0) {
            var scroller = this.refs.scrollView;
            var count =  this.props.data.length;
            if(count > 1){
                this.timer =  setTimeout(()=>{
                    var index = currentCount + 1;
                    index += 1;
                    if(index == count + 1) {
                        currentCount = 0;
                    }else {
                        currentCount += 1;
                    }
                    //计算位移的距离
                    var l = index * windowWidth;
                    //设置滑动距离
                    scroller.scrollResponderScrollTo({x:l,y:0, animated:true});
                    this.setState({
                        currentCount:currentCount
                    });
                },2000);
            }
        }
    }
    stopTimerToScroll(){
        this.timer && clearTimeout(this.timer);
        this.timer = null;
    }


    //点击事件
    onPressJumpView(){
        if(this.props.bannerEvent) {
            this.props.bannerEvent(currentCount);
        }
    }
}

const styles = StyleSheet.create({
   container:{

   },
    dotsView:{
        width:windowWidth,
        height:25,
    },
    itemView:{
        width:windowWidth,
        flex:1,
    }
});