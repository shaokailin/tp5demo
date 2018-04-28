import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Dimensions,
    Button,
    Text
} from 'react-native'
import Classify from './Classify/ClassifyNavigator';
import Today from './Today/TodayBest'
import FourFucs from './FourFuncs/FuncFour';
var windowWidth = Dimensions.get('window').width;
var bannerHeight = 180 * windowWidth / 375;
let Banner = null;
export default class HeaderView extends Component {
    constructor (props){
        super(props);
        this.state = ({
            bannerArr:[],
            classifyArr:[],
            todayArr:[],
        });
    };
    render(){
        return(
            <View style={{flex:1}}>
                {this.state.bannerArr.length > 0?<Banner style={{width:windowWidth,height:bannerHeight}} data={this.state.bannerArr}  bannerEvent={(index)=>this.bannerClick(index)}/>:null}
                <Classify data={this.state.classifyArr}/>
                <Today data={this.state.todayArr} eventClick={(index)=>this.todayEvent(index)}/>
                <View style={styles.fourContainer}>
                    <FourFucs data={this.state.bannerArr} type={0}/>
                    <Text style={styles.hotTextStyle}>
                        热门资讯
                    </Text>
                </View>
                <Button style={{width:200, height:40}} title='button' onPress={()=>{
                    if (Banner == null) {
                        Banner = require('./AdBanner/BannerView').default;
                    }
                    this.setState({
                        bannerArr : [1,2,3,4],
                        classifyArr:[1,2,3,4,5,6,18],
                        todayArr:['11231231231231231231231231231313131231312','11231231231231231231231231231313131231313']
                    });
                }}/>

            </View>
        );
    }
    bannerClick(index) {
        console.log(index);
    }
    todayEvent(index){
        console.log(index);
    }
}
const styles = StyleSheet.create({
    fourContainer:{
        marginHorizontal:5,
        marginTop:2,
        borderTopLeftRadius:4,
        borderTopRightRadius:4,
        backgroundColor:'white'
    },
    hotTextStyle:{

    }
})