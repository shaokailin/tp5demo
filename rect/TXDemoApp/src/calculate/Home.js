
import React,{Component} from 'react';
import {
    StyleSheet,
    View,
    Text,
    FlatList
} from 'react-native';
import HeaderView from './HeaderView';
import Cell from './BannerCell';
import HTTPUtil from '../Units/HTTPUtil';
export default class Cal_Home extends Component {
    constructor (props){
        super(props);
        this.state = ({
            data:[],
            headerData:{},
            refreshing: false,
            // 加载更多
            isLoadMore:false
        });
    };
    getNetData(){

        var params = {};
        params.bid = '20,21,22,23,24,25,26';
        params.limit = '5,8,4,4,4,2,3';
        params.cache = 300;
        var loadPromise = HTTPUtil.get('app.datablock/getlist.html',params);
        loadPromise.then(this.loadSuccess.bind(this),this.loadError.bind(this));
    };
    loadSuccess = function(model){
        let array = model['26'];
        let dataBlob = [];
        let i = 0;
        array.map(function (item) {
            dataBlob.push({
                key: 'index' + i,
                value: item,
            })
            i++;
        });
        this.setState({ data:dataBlob,headerData:model,refreshing:false},()=>{
        });
        model = null;
        dataBlob = null;
    }
    loadError = function(error){
        this.setState = ({
            refreshing:false
        });
    };
    render() {
        return (
            <View style={{flex:1}}>
                <FlatList
                    ref={(flatList) => this._flatList = flatList}
                    data={this.state.data}
                    renderItem={this._renderItem}
                    ListHeaderComponent={this._header()}
                    ItemSeparatorComponent={this._separator}
                    refreshing={this.state.refreshing}
                    getItemLayout={this._layoutHeight}
                    onRefresh={this._onRefresh}
                    numColumns ={1}
                    //加载更多
                    // onEndReached={() => this._onLoadMore()}
                    // onEndReachedThreshold={0.1}
                />
            </View>

        );
    }
    _renderItem = ({item})=> {
        return (<Cell itemdata={item.value}/>);
    }
    _header = ()=> {
        return (<HeaderView data={this.state.headerData} ref={(headerView)=> this._headerView = headerView} />);
    }
    _separator = ()=>{
        return <View style={{backgroundColor:'#ededed', height:1,marginHorizontal:5}}></View>;
    }
    _onRefresh = ()=>{
        this.setState = ({
            refreshing:true
        });
        this.getNetData();
    }
    _layoutHeight(data,index) {
        return { length: 87, offset:88 * index, index }
    }

    componentDidMount() {
        this.getNetData();
    }


}
const styles = StyleSheet.create({
})