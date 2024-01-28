import { Item } from "../types/item";

export const getItem = async (id: number): Promise<Item | null> => {
    const url = `/api/v1/item/show/${id}`;
    try {
        const response = await fetch(url);

        if (response.ok) {
            const item = await response.json();
            return item;
        } else {
            throw response;
        }
    } catch(e) {
        console.warn(e);
        return null;
    };
};

export const getItems = async (): Promise<Item[]> => {
    const url = `/api/v1/item/index`;
    try {
        const response = await fetch(url);

        if (response.ok) {
            const items = await response.json();
            return items;
        } else {
            throw response;
        }
    } catch(e) {
        console.warn(e);
        return [];
    };
};
