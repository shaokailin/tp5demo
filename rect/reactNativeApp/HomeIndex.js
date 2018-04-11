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
                {/*<Image source={pic} style={styles.imgStyle}/>*/}
                {/*<Text>*/}
                    {/*{instroll}*/}
                {/*</Text>*/}
                {/*<HomeIndex2 name={this.props.name}/>*/}
                {/*<View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />*/}
                {/*<View style={{width: 50, height: 50, backgroundColor: 'skyblue'}} />*/}
                {/*<View style={{width: 50, height: 50, backgroundColor: 'steelblue'}} />*/}
                <TextInput
                    style={{height: 40}}
                    placeholder="Type here to translate!"
                    onChangeText={(text) => this.setState({text})}
                />
                <Text style={{padding: 10, fontSize: 42}}>
                    {console.log(this.state.text.split())}
                    {this.state.text.split(' ').map((word) => word && '🍕').join(' ')}
                </Text>

            </View>
        );
    }
}
const styles = StyleSheet.create({
    imgStyle:{
        flex:0.5,
    },

});
