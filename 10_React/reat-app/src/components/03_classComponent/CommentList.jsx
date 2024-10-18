import React, { Component } from 'react'

const comments= [
    {
        id: 1,
        message: "안녕하세요. 최지원입니다.",
    },{
        id: 2,
        message: "종강일은 12월 12일 입니다.",
    },{
        id: 2,
        message: "11월은 쉬는 날이 없습니다.",
    },
]

class CommentList extends Component {

    constructor(props) {
        super(props)

        this.state = {
            CommentList: [],
        }
    }

    componentDidMount(){
        //const commentList = this.state.CommentList
        //const data1 = this.state.data1
        //const data2 = this.state.data2
        //위 아래 둘다 같다
        //const { commentList, data1, data2 } = this.state; // 비 구조할당

        const {commentList} = this.state;
    }

    render() {
        return (
            <div>
                {
                    this.state.CommentList.map(c =>{
                        return (
                            <Comment key={c.id}
                                     id={c.id}
                                     message={c.message} />
                        )
                    })
                }
            </div>
        )
    }
}

export default CommentList