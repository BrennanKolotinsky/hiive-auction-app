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

export const createItem = async (name: string, description: string): Promise<Boolean> => {
    const url = `/api/v1/item/create`;
    const body = {
        name,
        description,
    };

    try {
        const token = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                "X-CSRF-Token": token as string,
                "Content-Type": "application/json",
            },
            body: JSON.stringify(body),
        });

        if (response.ok) {
            return true;
        } else {
            throw response;
        }
    } catch(e) {
        console.warn(e);
        return false;
    };
};
