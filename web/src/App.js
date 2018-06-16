import React, { Component } from 'react';
import './App.css';
import 'whatwg-fetch';

const SERVER_URL = '/apicalllog';

function Square (canvasContext, position, data) {
  canvasContext.fillStyle = 'green';
  canvasContext.clearRect(position.x, position.y, 30, 30);
  canvasContext.fillText(data, position.x, position.y);
}

let numbers = [5,4,3,2,1];

class ProblemVisualizer extends Component {

  async componentDidMount() {

    const result = await fetch('/apicalllog', {
      method: "POST",
      body: {
        code: "flarts"
      },
      headers: {
        "Content-Type": "application/json"
      }
    });

      console.log(result);

    // let transitionIndex = 0;
    //
    // let canvas = document.getElementById('canvas');
    // let ctx = canvas.getContext('2d');
    //
    // let intervalId = setInterval(
    //   ()=> {
    //     console.log("transindex", transitionIndex, "transitions length", transitions.length, numbers);
    //     let xPos = 0;
    //     let yPos = 10;
    //     if(transitionIndex === transitions.length)
    //     {
    //       ctx.clearRect(0, 0, canvas.width, canvas.height);
    //       numbers.forEach((number) => {
    //         console.log('number in for each', number);
    //         Square(ctx, {x: xPos, y: yPos}, number)
    //         xPos+= 10;
    //       });
    //     }
    //     else if (transitionIndex === transitions.length + 1)
    //     {
    //       console.log("interval was cleared");
    //       clearInterval(intervalId);
    //     }
    //     else {
    //       ctx.clearRect(0, 0, canvas.width, canvas.height);
    //       numbers.forEach((number) => {
    //         console.log('number in for each', number);
    //         Square(ctx, {x: xPos, y: yPos}, number)
    //         xPos+= 10;
    //       });
    //       let temp = numbers[ transitions[transitionIndex][0] ];
    //       numbers[ transitions[transitionIndex][0] ] = numbers[ transitions[transitionIndex][1] ]
    //       numbers[ transitions[transitionIndex][1] ] = temp;
    //     }
    //     transitionIndex++;
    //   }, 1500);
  }

  updateCanvas() {
    var canvas = document.getElementById('canvas');
    var ctx = canvas.getContext('2d');
    ctx.fillStyle = 'green';
    ctx.fillRect(10, 10, 100, 100);
  }

  render() {
    return (
        <div className="poop">
          <h1 className="poop-title"> Welcome to farts.com</h1>
          <canvas id="canvas" width="300" height="300"> farts </ canvas>
        </div>
    );
  }
}

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Welcome to Fart munchers</h1>
          <ProblemVisualizer />
        </header>
      </div>
    );
  }
}

export default App;
