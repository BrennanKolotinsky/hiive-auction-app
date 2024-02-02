import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { getItem } from '../services';
import { Item } from '../types/item';

export default (): JSX.Element => {

    const { id } = useParams();
    const [item, setItem] = useState<Item | null>();

    useEffect(() => {
        const fetchItem = async (): Promise<void> => {
            const item = await getItem(Number(id));
            setItem(item);
        };

        fetchItem();
    }, []);

    if (!item) {
        return <></>;
    }

    return(
        <div>
            <h2 className='text-center'>Product: {item.name}</h2>
            <p className='text-center'>Description: {item.description}</p>
        </div>
    );
};
