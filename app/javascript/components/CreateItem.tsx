import React, { useState } from 'react';
import { createItem } from '../services';

export default (): JSX.Element => {

    const [itemName, setItemName] = useState<string>('');
    const [itemDescription, setItemDescription] = useState<string>('');

    const handleSubmit = async (): Promise<void> => {
        if (itemName.length === 0) {
            alert('Please enter product name');
            return;
        };

        const success = await createItem(itemName, itemDescription);
        if (success) {
            alert('Successfully created auction');
            window.open(`/`); 
        } else {
            alert('Failed to create auction!');
        };
    };

    return(
        <div className='margin-left-large mt-4'>
            <h2>Create Item</h2>
            <div className="d-flex align-items-center mt-2">
                <label>Item:</label>
                <input type='text' placeholder='iPhone' className='margin-left-small' onChange={(e) =>  setItemName(e.target.value)}></input>
            </div>
            <div className="d-flex align-items-center w-50 mt-2">
                <label>Item Description:</label>
                <textarea placeholder='Brand new, factory sealed' className='w-50 margin-left-small' onChange={(e) =>  setItemDescription(e.target.value)}></textarea>
            </div>
            <button onClick={handleSubmit} className='btn btn-lg custom-button mt-4'>Create Item</button>
        </div>
    );
};
