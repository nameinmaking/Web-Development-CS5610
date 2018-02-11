import React from 'react';
import ReactDOM from 'react-dom';
import {Button} from 'reactstrap';

export default function run_demo(root, channel) {
  ReactDOM.render(<Demo channel={channel}/>, root);
}

var cardCount = 0;
class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = {
      initialGameState: [],
      count: 0
    };
    this.channel.join().receive("ok", this.gotView.bind(this)).receive("error", resp => {
      console.log("Unable to join", resp)
    });
  }

  gotView(view) {
    console.log("New view", view);
    this.setState(view.game);
  }

  sendMatchedCard(card)
  {
    cardCount++;

    let newgame = this.channel.push("startGame", {card: card}).receive("ok", this.gotView.bind(this));

    if (cardCount == 2)
    {
      this.isFaceMatch();
      cardCount = 0;
    }
  }

  isFaceMatch()
  {
    this.channel.push("faceMatched", {faceMatched: "game"}).receive("ok", this.gotView.bind(this));
  }

  resetBuilder(e)
  {
    this.channel.push("reset", {reset: "game"}).receive("ok", this.gotView.bind(this));
  }

  render()
  {
    //go to each row and access each of the values from the object
    let cardlist = this.state.initialGameState.map((cardRow, rowIndex) =>
    <tr key={rowIndex}>
      {
        cardRow.map((card, i) => <td key={i} onClick={() => this.sendMatchedCard(card)}>
          <div className={card.done ? "card done" : "card"}>
            <p>{  card.flipped ? card.value : "?" }</p>
          </div>
        </td>)
      }
    </tr>);

    return (<div>
      <table>
        <tbody>
          {cardlist}
        </tbody>
      </table>
      <ShowClicks state={this.state}/>
      <button id="reset-button" onClick={() => this.resetBuilder(this)}>Restart Game? </button>
    </div>);
  }
}

function ShowClicks(props)
{
  let state = props.state;
  return <h2>Number of Clicks: {state.count} </h2>;
}
