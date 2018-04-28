
import React,{Component} from 'react';
import {
    StyleSheet,
    View,
    Text,
    FlatList
} from 'react-native';
import HeaderView from './HeaderView';
import Cell from './BannerCell';
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
                    data={[{key:'a'},{key:'b'}]}
                    renderItem={this._renderItem}
                    ListHeaderComponent={HeaderView}
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
        return (<Cell data={item.key}/>);
    }
    _header = ()=> {
        return (<HeaderView />);
    }
    _separator = ()=>{
        return <View style={{backgroundColor:'#ededed', height:1,marginHorizontal:5}}></View>;
    }
    _onRefresh = ()=>{
        alert('正在刷新...');
    }
    _layoutHeight(data,index) {
        return { length: 87, offset:88 * index, index }
    }

    componentDidMount() {
    }

    componentWillUnmount() {
    }
}
const styles = StyleSheet.create({
})