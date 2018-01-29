import React from 'react';
import ReactDOM from 'react-dom';
import { Table, Tr, Td, Button} from 'reactstrap';

export default function run_demo(root) {
  discovered,ReactDOM.render(<Layout />, root);
}

let ignoreCardClicks = false;
let correctMatches;

const discovered = <span>&#9989;</span>;

// shuffle the alphabets sequence
function randomize(a)
{
    let r, temp, i;

    for (i = a.length - 1; i > 0; i--)
    {
        r = Math.floor(Math.random() * (i + 1));
        temp = a[i];
        a[i] = a[r];
        a[r] = temp;
    }
}

const gameStates = {
    FIRSTCARD: "Player selected 1st card.", SECONDCARD:  "Player selected 2nd card."
};

//create and initialize to null
function createCardGrid(x,y)
{
    return Array.apply(null,Array(x)).map(function(e)
    {
        return Array(y);
    });
}

//initialize all the elements of the game
function intializeGame()
{
    correctMatches = 0;
    let cards = createCardGrid(4,4);
    let alphabets =["A", "B", "C", "D", "E", "F", "G", "H", "A", "B", "C", "D", "E", "F", "G", "H"];
    let i, j, n = 0;

    randomize(alphabets);

    for(i=0; i<4; i++)
    {
        for(j=0; j<4; j++)
        {
            cards[i][j] = {cardValue: alphabets[n], flipped:false, rowIndex:i, columnIndex:j};
            n++;
        }
    }

    return cards;
}

//for each card displayed on the page
class Card extends React.Component
{
    render()
    {
        return <div className="card"> <span> {this.props.card.flipped ? this.props.card.cardValue: " ? " } </span> </div>;
    }
}

class Layout extends React.Component
{
    constructor(props)
    {
        super(props);
        this.state = {cards: intializeGame(), currentGameState: gameStates.FIRSTCARD, firstCard: null, secondCard: null,clickCount:0};
    }

    //handle click event for each card
    cardClick(card)
    {
        if (!card.flipped && !ignoreCardClicks)
        {
            switch(this.state.currentGameState)
            {
                case gameStates.FIRSTCARD:
                    this.state.cards[card.rowIndex][card.columnIndex].flipped=true;
                    this.setState({cards:this.state.cards, firstCard: card, currentGameState: gameStates.SECONDCARD, clickCount: this.state.clickCount + 1});
                    break;

                case gameStates.SECONDCARD:
                    this.state.cards[card.rowIndex][card.columnIndex].flipped=true;
                    this.setState({cards:this.state.cards, currentGameState: gameStates.FIRSTCARD, clickCount: this.state.clickCount + 1});

                    //cards face value match
                    if(this.state.firstCard.cardValue === card.cardValue)
                    {
                        // ignoreCardClicks = true;
                        //
                        // setTimeout(()=>{
                        //     ignoreCardClicks= false;
                        
                        this.state.cards[this.state.firstCard.rowIndex][this.state.firstCard.columnIndex].cardValue = discovered;
                        this.state.cards[card.rowIndex][card.columnIndex].cardValue = discovered;
                        this.setState({cards:this.state.cards, currentGameState: gameStates.FIRSTCARD});
                        // },1000)
                        correctMatches++;
                    }
                    else
                    {
                        ignoreCardClicks = true;
                        setTimeout(()=> {
                            this.state.cards[this.state.firstCard.rowIndex][this.state.firstCard.columnIndex].flipped=false;
                            this.state.cards[card.rowIndex][card.columnIndex].flipped=false;                                    //reverse the flip
                            this.setState({cards:this.state.cards, firstCard:null, currentGameState: gameStates.FIRSTCARD});    //empty the firstCard
                            ignoreCardClicks = false;
                        },1000)
                    }
                    break;

                default:
                    this.state.cards[this.state.firstCard.rowIndex][this.state.firstCard.columnIndex].flipped=false;
                    this.state.cards[this.state.secondCard.rowIndex][this.state.secondCard.columnIndex].flipped=false;
                    this.setState({cards:this.state.cards, currentGameState: gameStates.FIRSTCARD});
                    break;
            }
        }


        //check if game needs to be reset
        /*if (correctMatches === 8 && !ignoreCardClicks)
        {
            ignoreCardClicks = true;
            setTimeout(()=> {
                this.restartGame();
                ignoreCardClicks = false;
            },1000)
        }*/
    }

    //reset everything on button click
    restartGame()
    {
        correctMatches = 0;
        this.setState({cards: intializeGame(), game: gameStates.FIRSTCARD, firstCard: null, secondCard: null,clickCount:0});
    }

    //render the cards to be displayed on the screen
    render()
    {
        const cardsRendered = this.state.cards.map((rowOfCards,rowIndex)=><tr>{rowOfCards.map((card,indexOfCardInRow)=>
            <td onClick={()=>this.cardClick(card)}><Card card={card}/></td>)}</tr>);

        return<div>
            <table> <tbody>{cardsRendered}</tbody></table>
            <p>No of clicks: {this.state.clickCount}</p>
            <button onClick={()=> this.restartGame()}>Reset</button>
        </div>
    }
}