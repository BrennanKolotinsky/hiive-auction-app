import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getItem } from '../services';
import { Item } from '../types/item';
import { Link } from 'react-router-dom';
import { createBid } from '../services';

export default (): JSX.Element => {

    const { id } = useParams();
    const [item, setItem] = useState<Item | null>();
    const [auctionStillActive, setAuctionStillActive] = useState<boolean>(false);
    const [remainingAuctionTime, setRemainingAuctionTime] = useState<number>(0);
    const [bidAmount, setBidAmount] = useState<number>(1);

    useEffect(() => {
        const fetchItem = async (): Promise<void> => {
            const item = await getItem(Number(id)) as Item;
            setAuctionStillActive(item.auction_active);
            setItem(item);

            if (item.auction_active) {
                const timer = setInterval(() => {
                    const secondsPassedSinceCreation = Math.floor((new Date().getTime() - new Date(item.created_at).getTime()) / 1000);
                    const secondsRemaining = 30 - secondsPassedSinceCreation;
                    console.log('seconds remaining', secondsRemaining);
                    setRemainingAuctionTime(secondsRemaining);

                    if (secondsRemaining <= 0) {
                        clearInterval(timer);
                        setAuctionStillActive(false);
                    };
                }, 1000);
            };
        };

        fetchItem();
    }, []);

    if (!item) {
        return <></>;
    }

    const handleSubmit = async (): Promise<void> => {
        if (bidAmount === 0) {
            alert('Please enter a valid bid');
            return;
        };

        const success = await createBid(bidAmount, item.id);
        if (success) {
            alert('Successfully created bid');
        } else {
            alert('Failed to create bid!');
        };

        // let's update our bid info!
        const updatedItem = await getItem(Number(id)) as Item;
        setItem(updatedItem);
    };

    return(
        <div>
            {
               auctionStillActive && <h2 className='text-center'>Time to Bid Remaining: {remainingAuctionTime} seconds</h2>
            }
            <h2 className='text-center'>Product: {item.name}</h2>
            <p className='text-center'>Description: {item.description}</p>
            <p className='text-center'>{auctionStillActive ? 'Current Bid' : 'Winning Bid'}: <strong>${item.latest_bid_amount}</strong></p>
            <p className='text-center'>{auctionStillActive ? 'Current Winner' : 'Winner'}: {item.latest_bid_user}</p>
            {
                auctionStillActive && (
                    <>
                        <div className='d-flex justify-content-center'>
                            <input value={bidAmount} type="number" onChange={(e) => setBidAmount(Number(e.target.value))}></input>
                        </div>

                        <div className='d-flex justify-content-center'>
                            <button onClick={handleSubmit} className='btn btn-lg custom-button mt-4'>Create Bid</button>
                        </div>
                    </>
                )
            }

            <div className='d-flex justify-content-center'>
                <Link to='/' className='btn btn-lg custom-button mt-2'>Navigate Home</Link>
            </div>
        </div>
    );
};
