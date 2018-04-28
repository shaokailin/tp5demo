import React, {Component} from 'react';
import {
    View,
    Button,
    Text,
    Animated,
    StyleSheet
} from 'react-native';

class FadeView extends Component {
    constructor(props){
        super(props);
        this.state = {
            fadeAnim:new Animated.Value(0),
        };
    }

    componentDidMount() {
        Animated.timing(
            this.state.fadeAnim,
            {
                toValue:1,
                duration:2000
            }
        ).start();
    }
    render(){
        return (
            <Animated.View style={{...this.props.style,opacity:this.state.fadeAnim}}>
                {this.props.children}
            </Animated.View>
        );
    }
}


export default class ActionIndex extends Component {
    static  navigationOptions = ({navigation}) => ({
        title:'Action-' + navigation.state.params.kai
    });
    _actionClick(){
        console.log(12);
    }

    render(){
        const {params} = this.props.navigation.state;
        return (
            <View style={{flex:1, flexDirection:'column',justifyContent:'center',alignItems:'center'}}>
                {/*<Text>*/}
                    {/*{params.kai};*/}
                {/*</Text>*/}
                {/*<Button title='点击' onPress={()=>this._actionClick()}/>*/}

                <FadeView style={{width:250, height:50, backgroundColor:'red'}}>
                    <Text style={{fontSize: 28, textAlign: 'center', margin: 10}}>Fading in</Text>
                </FadeView>

            </View>
        );
    }
}