import React, { Component } from 'react'

/*
    class Component
    state(필드대체)를 가지고 있고 이를 수정할 수 있다.
    라이프 사이클에 따른 생명주기 메서드를 사용할 수 있다.
    
*/
const styles = {
    wrapper: {
        margin: 8,
        padding: 8, 
        display: "flex", 
        flexDirection: "row",
        border: "1px solid gray",
        borderRadius: 16
    },
    image: {
        width: 50,
        height: 50,
        borderRadius: 25,
    },
    contentContainer:{
        marginLeft: 8,
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        fontSize: 16,
        alignItems : "flex-start",
        color: "black",
    },
    commentText:{
        fontWeight: "bold",
    }
}

class Comment extends Component {
  constructor(props) {
    super(props)
    
    //js에서는 class에 필드영역이 없기 때문에
    //저장하고 싶은 데이터를 state라는 객체에 key-value형태로 저장한다.

    this.state = {

    }
  } 

  compomentDidMount(){
    console.log("componentDidMount 실행됨")
  }

  componentDidUpdate(){
    console.log("componentDidUpdate 실행됨")
  }

  

  render(){
    return (
      <div style={styles.wrapper}>
        <span style={styles.commentText}>
            안녕하세요 최지원입니다.
        </span>
      </div>
    )
  }
}

export default Comment