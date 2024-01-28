import React, {
    useState,
    useEffect,
} from 'react';
import { Item } from '../types/item';
import { getItems } from '../services';

export default () => {

    const [items, setItems] = useState<Item[]>([]);

    useEffect(() => {
        const fetchItem = async (): Promise<void> => {
            const items = await getItems();
            setItems(items);
        };

        fetchItem();
    });

    if (items.length === 0) {
        return <></>;
    };

    return (
        <div className="table-responsive">
            <table className="mx-auto w-75">
                <tr>
                    <th className='border w-50'>Product</th>
                    <th className='border w-50'>Description</th>
                </tr>
                {
                    items.map((item: Item) => {
                        return <tr>
                            <td className='border'>{item.name}</td>
                            <td className='border'>{item.description}</td>
                        </tr>
                    })
                }
            </table>
        </div>
    );
};
