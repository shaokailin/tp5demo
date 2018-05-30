
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
            itemData:[],
            headerData:{},
            refreshing: false
        });
    };
    render() {
        return (
            <View style={{flex:1}}>
                <FlatList
                    ref={(flatList) => this._flatList = flatList}
                    data={this.state.itemData}
                    renderItem={this._renderItem}
                    ListHeaderComponent={this._header()}
                    ItemSeparatorComponent={this._separator}
                    refreshing={this.state.refreshing}
                    getItemLayout={this._layoutHeight}
                    onRefresh={this._onRefresh}
                    numColumns ={1}
                />
            </View>

        );
    }
    _renderItem = ({item})=> {
        console.log(item);
        return (<Cell data={item.key}/>);
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
    getNetData(){
        var params = {};
        params.bid = '20,21,22,23,24,25,26';
        params.limit = '5,8,4,4,4,2,3';
        params.cache = 300;
        var loadPromise = HTTPUtil.get("app.datablock/getlist.html",params);
        loadPromise.then(function(model){
            let array = model['26'];
            var cellArray = [];
            for(let index in array){
                cellArray.push({key:array[index]});
            }
            console.log(cellArray);
            this.setState = ({
                itemData:cellArray,
                headerData:model,
                refreshing:false
            });
            console.log(this.state.itemData);
        },function(error){
            this.setState = ({
                refreshing:false
            });
        });
    }

}
const styles = StyleSheet.create({
})