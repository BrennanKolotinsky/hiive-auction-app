import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Item from "../components/Item";
import Items from "../components/Items";
import CreateItem from "../components/CreateItem";

export default (
  <Router>
    <Routes>
      <Route path="/" exact element={<Items />} />
      <Route path="/item/:id" element={<Item />} />
      <Route path="/items" element={<Items />} />
      <Route path="/createItem" element={<CreateItem />} />
    </Routes>
  </Router>
);
