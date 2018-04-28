import React,{Component} from 'react';
import {Text, View,Image,StyleSheet, TextInput } from 'react-native';

const instroll = 'Hello world!';

class HomeIndex2  extends Component {
    constructor (){
        super();
        this.state = {ShowText:true};
        setInterval(()=>{
            this.setState(previousState => {
                return { showText: !previousState.showText };
            });
        },1000);
    }
    render(){
        return (
            <Text>
                {this.props.name}
            </Text>
        );
    }
}

export default class HomeIndex extends Component {
    constructor(porps) {
        super(porps);
        this.state = {text:''};
    }
    render(){
        let pic = {
            uri: 'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg'
        };
        return (
            <View style={{
                flex: 1,
                flexDirection: 'column',
                justifyContent: 'space-around',
                alignItems: 'flex-start',
                backgroundColor:'red'}}>

            </View>
        );
    }
}
const styles = StyleSheet.create({
    imgStyle:{
        flex:0.5,
    },

});
