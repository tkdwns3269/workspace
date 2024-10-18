import React from 'react'
import Comment from './Comment'

const comments= [
    {
        id: 1,
        name: "최지원",
        comment: "안녕하세요. 최지원입니다. 잘부탁드립니다.",
        path: "https://lh5.googleusercontent.com/proxy/B4CLTpabEzmiXRNvh_OOEzKu5qTeZRiuWFNTeloHg5AGWfwMSTa8yjaXFrr1sETWiDdZKvD2FVNVatr-ADcc9J3vATJa3o9NbkErsowUxtG5wBNPecM2tJoOcV0OwQdx-EFsLMRh_YIdjoNuTcxb"
    },{
        id: 2,
        name: "서재용",
        comment: "오늘 자습 10시까지하고 집에 갈꺼에요",
        path: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCnN73UqEDzMqpdl79gwtkFTRj3Z5AYVhVAxjf8xlmlsFKWIb_TX0Queb2KZyEkT6DcNc&usqp=CAU"
    },{
        id: 2,
        name: "안재휘",
        comment: "자습 10시받고 집가서 2시간 더",
        path: "https://blog.kakaocdn.net/dn/diP65P/btsh2sluS6t/ykup0mG4lLMJ9j1CT8aGPk/img.jpg"
    },
]

/*
    js에서
    (배열, 리스트).map(반복시 실행할 함수)

    map() => 배열의 요소를 전부 사용하여 동일한 길이의 새로운 배열을 리턴
*/

const CommentList = () => {
  return (
    <div>
        {/*
        <Comment name={comments[0].name} comment={comments[0].comment} path={comments[0].path}/>
        <Comment name={comments[1].name} comment={comments[1].comment} path={comments[1].path}/>
        <Comment name={comments[2].name} comment={comments[2].comment} path={comments[2].path}/>
        */}
        {
            comments.map(c => {
                return <Comment key={c.id} name={c.name} comment={c.comment} path={c.path}/>
            })

        }

    </div>
  )
}

export default CommentList