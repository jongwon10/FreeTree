import React from 'react';

export default function newmsg({msg}){
    return (
        <div className='msg'>
            <div className='writer'>{msg.writer}</div>
            <div className='date'>{msg.date}</div>
            <div className='content'>{msg.content}</div>
        </div>
    )
}