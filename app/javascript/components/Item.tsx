import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getItem } from '../services';
import { Item } from '../types/item';
import { Link } from 'react-router-dom';

export default (): JSX.Element => {

    const { id } = useParams();
    const [item, setItem] = useState<Item | null>();
    const [auctionStillActive, setAuctionStillActive] = useState<boolean>(false);
    const [remainingAuctionTime, setRemainingAuctionTime] = useState<number>(0);

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

    return(
        <div>
            {
               auctionStillActive && <h2 className='text-center'>Time to Bid Remaining: {remainingAuctionTime} seconds</h2>
            }
            <h2 className='text-center'>Product: {item.name}</h2>
            <p className='text-center'>Description: {item.description}</p>
            <p className='text-center'>Current Bid: <strong>${item.latest_bid_amount}</strong></p>
            <p className='text-center'>Current Winner: {item.latest_bid_user}</p>
            <div className='d-flex justify-content-center'>
                <Link to='/' className='btn btn-lg custom-button mt-2'>Navigate Home</Link>
            </div>
        </div>
    );
};
