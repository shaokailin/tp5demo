import React,{Component} from 'react';
import {
    View,
    TouchableOpacity,
    Text,
    StyleSheet,
} from 'react-native'

import ClassifyItem from './ClassifyItem';


export default class ClassifyNavigator extends Component {
    render(){
        return (
            <View style={styles.container}>
                {this.props.data.length > 0?this.createItems():null}
            </View>
        );
    }

    createItems(){
        let count = this.props.data.length;
        var items = [];
        for(var i = 0; i < count; i++) {
            items.push(<ClassifyItem key={i} flag={i} url={''} textString={"323"+ i} eventClick={(index)=>{this.classifyEvent(index)}}/>);
        }
        return items;
    }
    classifyEvent(index) {
        console.log(index);
    }

}
const styles = StyleSheet.create({
    container:{
        paddingTop:20,
        backgroundColor:'white',
        flexDirection:'row',
        flexWrap:'wrap',
        alignItems:'flex-start',
        justifyContent:'flex-start',
    }
});